# Question 5
# Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

=begin
'Pizza' has an instance variable `@name`, variables that start with `@` are instance variables
In `Pizza` class, we are initializing local variable `name`

We can double check this by instantiating 1 object of each class and calling method `instance_variables` on said objects
=end

hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

hot_pizza.instance_variables # => [:@name]
orange.instance_variables #    => []
