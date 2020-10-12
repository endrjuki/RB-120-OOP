# If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# Explain what the @@cats_count variable does and how it works.
# - it's a class variable, it gets incremented by the constructor method (initialize)
#   every time a new Cat object is being instantiated, therefore it keeps track of how many
#   Cat objects that have been instantiated

# What code would you need to write to test your theory?
muri = Cat.new("egyptian")
buri = Cat.new("bengal")
huri = Cat.new("coon")
Cat.cats_count # => 3
