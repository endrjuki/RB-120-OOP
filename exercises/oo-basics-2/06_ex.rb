=begin
Using the following code, create a class named Cat that prints a greeting when #greet is invoked.
The greeting should include the name and color of the cat. Use a constant to define the color.

Hello! My name is Sophie and I'm a purple cat!
=end

class Cat
  CAT_COLOR = 'purple'

  def initialize(name, color=CAT_COLOR)
    @name = name
    @color = CAT_COLOR
  end

  def greet
    p "Hello! My name is #{@name} and I'm a #{@color} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
