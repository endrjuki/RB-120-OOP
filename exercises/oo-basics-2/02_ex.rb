=begin
Using the following code, add an instance method named #rename that renames kitty when invoked.
=end

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def rename(var)
    self.name = var
  end
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name
