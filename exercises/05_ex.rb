=begin
Continuing with our Person class definition, what does the below print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
=end

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

=begin
Outputs string with string version of `bob` object (return value of `to_s` method invocation on object referenced by `bob`)
"The person's name is: #<Person:0x0000562e8a87a8e8>"

We could remedy this by interpolating the return value of `name` method call on object referenced by `bob` instead like so:
puts "The person's name is: #{bob.name}"

Or alternatively, we could override `to_s` method in `Person` ckass like so:
def to_s
  name
end

=end
