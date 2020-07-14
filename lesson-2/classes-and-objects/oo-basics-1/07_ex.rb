=begin
Using the code from the previous exercise, add a getter method named #name and invoke it in place of @name in #greet.
=end

class Cat
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def greet
    puts "Hi, my name is #{name}"
  end
end

# or alternatively

class Cat
  attr_reader :name
  
  def initialize(name)
    @name = name
  end

    def greet
    puts "Hi, my name is #{name}"
  end
end

kitty = Cat.new('Sophie')
kitty.greet
