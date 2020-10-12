# Assignment: RPS Bonus Features

## Keeping Score

### Score As a Separate Class

`rps_class_score.rb`

For the purpose of this exercise, I created `Score` as a separate class, to be used as a collaborator object together for `Player` class.

A new `Score` object would be created upon instantiation of a `Player` object like so:

```ruby
class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = Score.new
  end
end
```

The `Score` class would have the following methods:

```ruby
class Score
  attr_reader :score

  def initialize
    @score = 0
  end

  def add_point
    @score += 1
  end

  def reset
    @score = 0
  end
	
  def win? 
    @score >= RPSGame::MAX_POINTS
  end
end
```

I found this approach incorporated unneeded complexity, because I had to first access the `Score` object and only then I could further interact with the actual score that is stored within the object:

```ruby
human.score.add_point
```

Also, `win?` method should be part of the `RPSGame` class, doesn't seem like `Score` class should concern itself with the win condition for grand winner. 

I've decided against this approach and will explore the option of having score as an attribute of `Player` class.

### Score as a attribute of `Player` class

`rps_score_class_attribute.rb`

I've decided to implement instance variable `@score` for `Player` class and a getter/setter methods to interact with it:

```ruby
class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end
```

And I've implemented all the necessary methods for interacting with score in the `RPSGame` class:

```ruby
# ommited
  def update_score
    winner = determine_winner
    winner.score += 1 if winner == human || winner == computer
  end

  def display_score
    puts ""
    puts "#{human.name} score: #{human.score}"
    puts "#{computer.name} score: #{computer.score}"
  end
  # ommited
```

## Add Lizard and Spock

### Handling the additional moves in `Move` class

Due to how I've structured my code, all I really have to do is to update couple of display messages and `WIN_CONDITION` constant in the `Move` class in order to facilitate Lizard and Spock choices:

```ruby
WIN_CONDITION = {   'rock' => %w(scissors lizard),
                    'paper' => %w(rock spock),
                    'scissors' => %w(paper lizard),
                    'lizard' => %w(spock paper),
                    'spock' => %w(rock scissors) }
```

### Implementing a Class For Each Move

`rpsls_5classes.rb`

In the way I had implemented the logic for comparing the moves in `Move` class:

```ruby
class Move
  attr_reader :value

  include Comparable
  WIN_CONDITION = { 'rock' => %w(scissors lizard),
                    'paper' => %w(rock spock),
                    'scissors' => %w(paper lizard),
                    'lizard' => %w(spock paper),
                    'spock' => %w(rock scissors) }

# ommited for brevity
    def <=>(other_move)
    if WIN_CONDITION[value].include?(other_move.value)
      1
    elsif WIN_CONDITION[other_move.value].include?(value)
      -1
    else
      0
    end
  end
end 
  .
```

I did not see much upside in having a separate class for each move. I could rework this comparison logic entirely, implement `@beats` class variable for each of the classes (`Rock`, `Paper`, `Scissors`... etc.) and move from there, but this just seemed like a lot of work for no visible upside.

I opted for just making some minor tweaks to make the new class structure work:

* constructor method in `Move` class:

  ```Ruby
  def initialize
  	@value = self.class.to_s.downcase
  end
  ```

  Once an instance of one of the child classes(`Rock`, `Paper` etc.) is created, an instance variable is initialized and string version of the class name is assigned to it. This is so it doesn't break the move comparison logic.

* creating new objects that sub-class from `Move`:

  ```ruby
  class Human
  	# omitted for brevity
    
    def choose
      choice = nil
      # obtaining user input
      # ommited for brevity
     Module.const_get(choice.capitalize).new
    end
  end
  ```

  and similarly, for the `Computer` class:

  ```ruby
  def choose		
  	self.move = Module.const_get(Move::VALID_CHOICES.sample.capitalize).new
  end
  ```

  `Module#const_get` method references the class name by the `String` object that is passed in as an argument, then we invoke method `new` to create a new object

overall, I did not see much value in this type of design, so going forward, I will scrap the separate classes for each of the moves.

## Keep Track of History of Moves



