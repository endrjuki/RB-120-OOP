# Question 6
# If we have these two methods:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?

# Example 1: `create_template` instance method initializes @template and assigns it to string
# Example 2: 'create_template' uses setter method to assign the string value to `@template` instance var

# Example 1 and 2: Both use getter method to retrieve the value of `@template`, `self` can be ommited in the second example.
