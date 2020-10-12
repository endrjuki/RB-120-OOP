# How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?
# - Ruby will first look into the calling object's class and then follow up the lookup chain.
# - If the method appears nowhere in the lookup chain, Ruby will raise a NoMethodError
# - You can find object's ancestors by invoking method `ancestors` on the class itself


module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# What is the lookup chain for Orange and HotSauce?
# - [HotSauce, Taste, Object, Kernel, BasicObject]
# - [Orange, Taste, Object, Kernel, BasicObject]
