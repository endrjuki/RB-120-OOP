# Given the class:
class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

# Create a sub-class from Dog called Bulldog overriding the swim method to return "can't swim!"

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end
