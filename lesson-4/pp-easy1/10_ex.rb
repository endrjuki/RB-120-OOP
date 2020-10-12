# If we have the class below, what would you need to call to create a new instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
# by calling method `new` on the class' name and passing in two strings as arguments.
Bag.new("red", "velvet")
