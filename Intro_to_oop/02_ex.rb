=begin
What is a module? What is its purpose?
How do we use them with our classes?
Create a module for the class you created in exercise 1 and include it properly.
=end

# - Module is a collection of behaviors that can be made available to other classes via mixins
# - Module allows us to group reuseable code in one place
# - We use moduls in our classes via `include` method invocation, followed by the module name
# - Modules can also be used as namespaces

module Study
end

class MyClass
  include Study
end

my_obj = MyClass.new

# Modules as namespaces

module Outer
  class MyClass
    include Study
  end
end

my_obj = Outer::MyClass.new
