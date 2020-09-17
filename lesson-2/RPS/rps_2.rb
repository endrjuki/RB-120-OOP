require "pry"

class Move
  attr_reader :value

  include Comparable
  VALUES = %w(rock paper scissors)
  WIN_CONDITION = { 'rock' => %w(scissors),
                    'paper' => %w(rock),
                    'scissors' => %w(paper) }

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

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

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    name = nil
    loop do
      puts "What's your name?"
      name = gets.chomp
      break unless name.empty?
      puts "Sorry, can't leave the field empty!"
    end
    self.name = name
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, '#{choice}' is not a valid move"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w(Bmax R2D2 DUCKY).sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to RPS!"
  end

  def display_moves
    puts "The #{human.name} chose #{human.move}."
    puts "The #{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "The #{human.name} has won!"
    elsif human.move < computer.move
      puts "The #{computer.name} has won!"
    else
      puts "It's a tie!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing RPS! Goodbye!"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include?(answer)
      puts "Sorry, #{answer} is not a valid answer"
    end
    answer == 'y'
  end

  def play
    display_welcome_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
