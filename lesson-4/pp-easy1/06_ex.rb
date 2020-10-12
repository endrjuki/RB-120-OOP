# What could we add to the class below to access the instance variable @volume?
# - we could add a getter method either mannualy or through `attr_reader`
# - or we could call a method `instance_variable_get("@volume")` 

class Cube
  def initialize(volume)
    @volume = volume
  end

  def volume
    @volume
  end
end

# or

class Cube
  attr_reader :volume

  def initialize(volume)
    @volume = volume
  end
end

# or
big_cube = Cube.new(5000)
big_cube.instance_variable_get("@volume")
5000
