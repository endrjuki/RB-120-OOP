=begin
I
how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?
=end

=begin
If we have a Car class and a Truck class and we want to be able to go_fast,
how can we add the ability for them to go_fast using the module Speed?
- by "mixing in" the `Speed` module with class by using `include` method. Modules mixed in classes are also refered as mixins


How can you check if your Car or Truck can now go fast?
- we can instantiate an object of each class and call the method `go_fast` (from the `Speed` module) on said object.
=end

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

class Truck
  include Speed
  
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
