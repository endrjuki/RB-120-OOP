# We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
# What is the result of the following:
trip = RoadTrip.new
trip.predict_the_future

# - We are calling `predict_the_future` on an instance of RoadTrip class
# - Ruby first looks for `predict_the_future` method in RoadTrip class
#   and then moves up the lookup chain.
# - super-class Oracle is next one in the chain, this is where Ruby finds `predict_the_future`
#   method and invokes it.
# - predict_the_future method then references `choices` method
# - Ruby starts to look for the method from the beggining of the lookup chain again, starting
#   from RoadTrip class
# - there is `choices` defined in RoadTrip class so Ruby invokes it and stops looking
# - this returns ["visit Vegas", "fly to Fiji", "romp in Rome"]
# - then`sample` method invocation on this array object returns a random string from it
# - after that 'String#+' method with this random string passed into it returns a new string object
#    "You will <random_string from arr"
