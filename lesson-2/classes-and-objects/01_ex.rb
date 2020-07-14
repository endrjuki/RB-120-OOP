=begin
Given the below usage of the Person class, code the class definition.
=end

class Person
  attr_accessor :name

  def initialize(n)
    @name = n
  end
end

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
