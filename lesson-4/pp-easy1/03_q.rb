# Question 3
# In the last question we had a module called Speed which contained a go_fast method.
# We included this module in the Car class as shown below.

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

# >> small_car = Car.new
# >> small_car.go_fast
# I am a Car and going super fast!

=begin
When we called the go_fast method from an instance of the Car class (as shown below)
you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using.
How is this done?
- we use `self.class` in this method and this works in the following way:
  1) `self` refers to the calling object itself, in this case either a `Car` or `Truck` object
  2) We ask `self` to tells us its class with `.class` method. The return value is the name of the class
  3) we use string interpolation (which automatically calls `to_s` on the object) inside the string
=end



