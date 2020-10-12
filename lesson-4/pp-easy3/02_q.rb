class Greeting
  def self.greet(message)
    puts message
  end
end

class Hello < Greeting
  def self.hi
    greeting = Greeting.new
    greeting.greet("hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# If we call Hello.hi we get an error message. How would you fix this?
# 1) we need to change `Hello` to a class method by prefixing it with `self.`
# 2) since `Greeting` class only defines `greet` method for its instances, not the class itself
#    we need to instantiate a `Greeting` object inside the class
# 3) then we can invoke `greet` on this object and pass in "hello" as an argument to it
