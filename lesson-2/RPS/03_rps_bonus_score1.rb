class Move
  attr_accessor :value, :beats

  def initialize(value)
    @value = value
  end

  def >(other_move)
    @beats.include?(other_move.value)
  end

  def <(other_move)
    other_move.beats.include?(@value)
  end

  def to_s
    @value
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = ['lizard', 'scissors']
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = ['spock', 'rock']
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = ['lizard', 'paper']
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = ['spock', 'paper']
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = ['scissors', 'rock']
  end
end



class Player
  attr_accessor :move, :name, :score

  VALUES = { 'rock' => Rock.new, 'paper' => Paper.new,
             'scissors' => Scissors.new, 'lizard' => Lizard.new,
             'spock' => Spock.new }

  def initialize
    set_name
    @score = 0
    @history = []
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
      loop do
        puts "Please choose rock, paper, or scissors"
        choice = gets.chomp
        break if VALUES.keys.include?(choice)
        puts "Sorry, invalid choice."
      end
      self.move = VALUES[choice]
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = VALUES.values.sample
  end
end

class RPSGame
  attr_accessor :human, :computer
  MAX_SCORE = 5


  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
    puts "Whoever reaches #{MAX_SCORE} points first is the grand winner!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_winner(who_won)
    case who_won
    when :human    then puts "#{human.name} won!"
    when :computer then puts "#{computer.name} won!"
    when nil       then puts "It's a tie!"
    end
  end

  def determine_winner
    if human.move > computer.move
      :human
    elsif human.move < computer.move
      :computer
    else
      nil
    end
  end

  def update_score!(who_won)
    case who_won
    when :human then human.score += 1
    when :computer then computer.score += 1
    end
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_score
    puts "#{human.name} : #{human.score}, #{computer.name} : #{computer.score}"
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    return false if answer.downcase == 'n'
    return true if answer.downcase == 'y'
  end

  def display_grand_winner
    human.score == 5 ? (puts "#{human.name} is the grand winner!") : (puts "#{computer.name} is the grand winner!")
  end

  def play
    loop do
      system "clear"
      display_welcome_message
      human.score = 0
      computer.score = 0

      loop do
        human.choose
        computer.choose
        system "clear"
        display_moves
        who_won = determine_winner
        display_winner(who_won)
        update_score!(who_won)
        display_score

        break if human.score == MAX_SCORE || computer.score == MAX_SCORE
      end

      display_grand_winner
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
