=begin
Using the code from the previous exercise, add a setter method named #name. Then, rename kitty to 'Luna' and invoke #greet again.
=end

class Cat
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end

    def greet
    puts "Hi, my name is #{name}"
  end
end

kitty = Cat.new('Sophie')
kitty.name = 'Luna'
kitty.greet
