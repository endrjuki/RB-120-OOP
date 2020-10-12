# If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# What would happen if I called the methods like shown below?
tv = Television.new
tv.manufacturer # => NoMethodError
tv.model        # => return value of `model` instance method invocation

Television.manufacturer # => return value of 'self.manufacturer' class method invocation
Television.model        # => NoMethodError
