# Question 2
# Alan created the following code to keep track of items for a shopping cart application he's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# Alyssa looked at the code and spotted a mistake. "This will fail when update_quantity is called", she says.
# Can you spot the mistake and how to address it?
# - setter method for quantity is undefined, so on line 14, instead of updating `@quantity`, we are going to be initializing
#   a local variable `quantity`. We need to either change line 14 to `@quantity = updated_count if updated_count >= 0` # to
#   access instance variable `@quantity` directly, or create a setter method for `@quantity` and change line 14 to
#   `self.quantity = ...omitted for brevity`

class InvoiceEntry
  attr_reader   :product_name
  attr_accessor :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0 @ # accessing @quantity through setter method
  end
end

# or
class InvoiceEntry
  attr_reader :product_name, :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0 # accessing @quantity directly
  end
end
