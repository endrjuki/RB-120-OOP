# You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# What is the result of executing the following code:
oracle = Oracle.new
oracle.predict_the_future

# on line 14 we are instantiating a new object of Oracle class, initializing variable `oracle` and assigning this Oracle object to it
# on line 15 we are invoking instance method `predict_the_future` on object referenced by `oracle`
# `predict_the_future` method invocation returns the return value of `"You will " + choices.sample` expression
# - `choices` is an instance method that returns `["eat a nice lunch", "take a nap soon", "stay at work late"]`array
# - sample method invocation on ["eat a nice lunch", "take a nap soon", "stay at work late"] returns a random object from this array
# - finally this random object is being passed into `String#+` method invocation, which returns a new string object that
#   consists of "You will <one of the strings from the array here>"
