=begin
What's the Output?
Take a look at the following code:

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

What output does this code print? Fix this class so that there are no surprises waiting in store for the unsuspecting developer.

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin
Further Exploration
What would happen in this case?

This code "works" because of that mysterious to_s call in Pet#initialize.
However, that doesn't explain why this code produces the result it does. Can you?
=end

=begin
On line 79 local var `name` is being initalized and int 42 is being assigned to it
then we are initializing a new Pet object `fluffy` with `new` method and passing in object referenced by `name` as an argument

Inside the class definition, object referenced by `name` is being passed in to the conctructor `initialize`

On line 52, inside `initialize` method definition, we are initializing class variable @name and assigning it to
return value of `to_s` method invocation on object referenced by `name`. This returns a new string object '42'

`@name` now points to an entirely different object than `name`

also, when we are reassigning `name` to `name += 1`, we are not modifying the actual object referenced by `name` and since it points
to an integer, its actually impossible. We are merely reassignin it

So in actuality there are 2 occurances where `@name` would lost its connection to object referenced by `name`:
line 94 and line 96
=end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

