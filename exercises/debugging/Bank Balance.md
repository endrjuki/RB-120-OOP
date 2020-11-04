## Bank Balance

We created a simple `BankAccount` class with overdraft  protection, that does not allow a withdrawal greater than the amount of  the current balance. We wrote some example code to test our program.  However, we are surprised by what we see when we test its behavior. Why  are we seeing this unexpected output? Make changes to the code so that  we see the appropriate behavior.

```ruby
class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0
      success = (self.balance -= amount)
    else
      success = false
    end

    if success
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
    if valid_transaction?(new_balance)
      @balance = new_balance
      true
    else
      false
    end
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         #. => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
p account.balance         # => 50
```

### Answer

Setter methods in Ruby always return the argument that was passed in, even with an explicit return statement. Our `balance=` method will always return the argument that was passed in, regardless if the instance variable `@balance` is reassigned or not.

Because of this behavior, `balance=` method call on `line 21` will always return a truthy value and this truthy value will be assigned to local variable `success` as long as the argument `amount` is an integer that is larger than 0.

This in turn will guarantee that the following `if` statement on `line 26` will always execute, even if nothing was withdrawn.

A better solution is to check the validity of transaction by calling  `valid_transaction?` in `withdraw` instead of `balance=`. If the transaction is deemed valid, then we invoke `withdraw=`, otherwise we don't. This way we don't attempt to use the setter for its return value, but instead let it do its one job: assigning a value to `@balance`

```ruby
class BankAccount
  attr_reader :balance

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if valid_transaction?(balance - amount) && amount >= 0
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end    
  end

  def balance=(new_balance)
    @balance = new_balance    
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end
```

