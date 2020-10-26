=begin
Expected output:

Jessica

=end

class Person
  attr_accessor :name
  attr_reader :phone
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name
