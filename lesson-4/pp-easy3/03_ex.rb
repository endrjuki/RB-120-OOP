=begin
Question 3
When objects are created they are a separate realization of a particular class.

Given the class below, how do we create two different instances of this class, both with separate names and ages?
=end
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

marc = AngryCat.new(14, "Marcellus")
lucy = AngryCat.new(5, "Lucy")
