## Wish You Were Here

On `lines 37` and 38 of our code, we can see that `grace` and `ada` are located at the same coordinates.  So why does line 39 output `false`? Fix the code to produce the expected output.

```ruby
class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false
```

Answer

It is because we haven't defined `==` method for `GeoLocation` class and ruby is invoking `BasicObject#==` method from up the method lookup chain, this method returns `true` if the objects compared are actually the same object.

We can remedy this by defining a `==` method inside `GeoLocation` class and specifying that it is the coordinates that actually need to be compared like so:

```ruby
class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def to_s
    "(#{latitude}, #{longitude})"
  end
  
  def ==(other)
    latitude == other.latitude &&
    longitude == other.longitude
  end
end
```

