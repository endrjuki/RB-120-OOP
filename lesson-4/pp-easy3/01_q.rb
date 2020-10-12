# # If we have this code:
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end


# What happens in each of the following cases:

# case 1:
hello = Hello.new
hello.hi # => Hello

#case 2:
hello = Hello.new
hello.bye # => NoMethodError, `bye` is not defined in Hello and it's parent class

# case 3:
hello = Hello.new
hello.greet # => ArgumentError, Hello class can access it's parent's class' greet method,
                              # but greet takes an argument which we are not suplying.

# case 4:
hello = Hello.new
hello.greet("Goodbye") # => Goodbye

# case 5:
Hello.hi # => NoMethodError, there is no class method `hi` defined
