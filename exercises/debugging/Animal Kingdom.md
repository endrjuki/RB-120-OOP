## Animal Kingdom

The code below raises an exception.  Examine the error message and alter the code so that it runs without error.

```ruby
class Animal
  def initialize(diet, superpower)
    @diet = diet
    @superpower = superpower
  end

  def move
    puts "I'm moving!"
  end

  def superpower
    puts "I can #{@superpower}!"
  end
end

class Fish < Animal
  def move
    puts "I'm swimming!"
  end
end

class Bird < Animal
end

class FlightlessBird < Bird
  def initialize(diet, superpower)
    super
  end

  def move
    puts "I'm running!"
  end
end

class SongBird < Bird
  def initialize(diet, superpower, song)
    super
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end

# Examples

unicornfish = Fish.new(:herbivore, 'breathe underwater')
penguin = FlightlessBird.new(:carnivore, 'drink sea water')
robin = SongBird.new(:omnivore, 'sing', 'chirp chirrr chirp chirp chirrrr')
```

There is an error in `SongBird#initialize` method. When we are invoking `super` without arguments, ruby passes in all the arguments that we passed into the method, from which we invoked `super`. This invokes `initialize` from the class up the inheritance chain, more specifically the `Animal#initialize` , and attempts to pass in 3 arguments, which raises an `ArgumentError` exception, because `Animal#initialize` is defined with 2 parameters.

To remedy this, we need to specify which arguments should be passed to the `Animal#initialize` by passing them into the `super` method like so:

```ruby
class SongBird < Bird
  def initialize(diet, superpower, song)
    super(diet, superpower)
    @song = song
  end

  def move
    puts "I'm flying!"
  end
end
```

### Further Exploration

##### Is the `FlightlessBird#initialize` method necessary?  Why or why not?

It is not necessary, because we are just invoking the `Animal#initialize` by invoking `super`,  and `Animal#initialize` is already part of inheritance chain, and is going to be executed once we create a new `FlightlessBird` instance.

