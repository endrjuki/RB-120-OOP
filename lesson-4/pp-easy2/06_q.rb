class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Which one of these is a class method (if any) and how do you know?
# - self.manufacturer is a class method, because in Ruby, class methods start with `self`
#   context refers to class itself.
# How would you call a class method?
# - by calling the method on the class name like so: Television.manufacturer
