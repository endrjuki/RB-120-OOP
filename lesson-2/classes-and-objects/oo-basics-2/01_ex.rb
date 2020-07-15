=begin
Modify the following code so that Hello! I'm a cat! is printed when Cat.generic_greeting is invoked.
=end

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat"
  end
end

Cat.generic_greeting

=begin
# Further exploration
# What happens if you run kitty.class.generic_greeting? Can you explain this result?

First, `class` method is being called on object referenced by variable `kitty`, since `kitty` references an object of `Cat` class,
this method call's return value is `Cat`. Then we call method `generic_greeting` on `Cat` class just like before.
=end

