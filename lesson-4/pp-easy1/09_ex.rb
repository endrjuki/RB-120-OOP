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

# In the name of the cats_count method we have used self. What does self refer to in this context?
# - self in this context refers to the class `Cat` itslef
# - therefore self.cats_count is a class method and can only be called upon the Cat class itself, not instantiated objects of `Cat` class
