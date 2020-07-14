=begin
Create a superclass called Vehicle for your MyCar class to inherit from and move the behavior
that isn't specific to the MyCar class to the superclass.

Create a constant in your MyCar class that stores information about the vehicle
that makes it different from other types of Vehicles.

Then create a new class called MyTruck that inherits from your superclass
that also has a constant defined that separates it from the MyCar class in some way.
=end

module Towable
  def can_tow?(kg)
    kg < 2000 ? true : false
  end
end

class Vehicle
  attr_reader :year, :model
  attr_accessor :color

  @@number_of_cars = 0

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color    
    @current_speed = 0
    @@number_of_cars += 1
  end

  def self.number_of_cars
    p @@number_of_cars
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brakes and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park up!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles/gallons} MPG of gas"
  end

  def how_old
    p "The vehicle is #{age(year)} years old"
  end

  private

  def age(year)
    Time.now.year - year
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 4
  
  def to_s
    puts "My truck is #{year} #{model} in #{color} color."
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 2

  def to_s
    puts "My car is #{year} #{model} in #{color} color."
  end
end

MyCar
