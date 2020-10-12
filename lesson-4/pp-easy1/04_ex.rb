=begin
Question 4
If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like this:
=end

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# You can define a new instance of `AngryCat` like this
# using `.new` method after a class name will tell Ruby this new object is an instance of `AngryCat`
AngryCat.new
