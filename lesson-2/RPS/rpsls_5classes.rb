require "pry"

class Move
  attr_reader :value

  include Comparable
  WIN_CONDITION = { 'rock' => %w(scissors lizard),
                    'paper' => %w(rock spock),
                    'scissors' => %w(paper lizard),
                    'lizard' => %w(spock paper),
                    'spock' => %w(rock scissors) }

  VALID_CHOICES = WIN_CONDITION.keys

  def initialize
    @value = self.class.to_s.downcase
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

class Rock < Move; end
class Paper < Move; end
class Scissors < Move; end
class Lizard < Move; end
class Spock < Move; end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    system "clear"

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
      puts ""
      puts "Please choose between : #{Move::VALID_CHOICES.join(', ')}."
      choice = gets.chomp
      break if Move::VALID_CHOICES.include?(choice)
      puts "Sorry, '#{choice}' is not a valid move"
    end
    self.move = Module.const_get(choice.capitalize).new
  end
end

class Computer < Player
  PLAYERS = %w(Bmax R2D2 DUCKY)

  def set_name
    if name.nil?
      self.name = PLAYERS.sample
    else
      find_new_opponent
    end
  end

  def find_new_opponent
    previous_player = computer.name
    player_pool = PLAYERS.select { |name| name != previous_player }
    self.name = player_pool.sample
  end

  def choose
    self.move = Module.const_get(Move::VALID_CHOICES.sample.capitalize).new
  end
end

class RPSGame
  attr_accessor :human, :computer

  MAX_POINTS = 3

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def play
    display_welcome_message
    match_loop
    display_goodbye_message
  end

  private

  def match_loop
    loop do
      reset_game
      round_loop
      display_grand_winner if grand_winner?
      break unless play_again?
    end
  end

  def reset_game
    new_opponent
    reset_score
  end

  def reset_score
    human.score = 0
  end

  def new_opponent
    @computer = Computer.new
  end

  def round_loop
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      update_score
      display_score
      break if grand_winner?
    end
  end

  def display_welcome_message
    system "clear"
    puts "Welcome to RPS!"
  end

  def display_moves
    system "clear"
    puts "The #{human.name} chose #{human.move}."
    puts "The #{computer.name} chose #{computer.move}."
  end

  def determine_winner
    if human.move > computer.move
      human
    elsif human.move < computer.move
      computer
    else
      :tie
    end
  end

  def update_score
    winner = determine_winner
    winner.score += 1 if winner == human || winner == computer
  end

  def display_score
    puts ""
    puts "#{human.name} score: #{human.score}"
    puts "#{computer.name} score: #{computer.score}"
  end

  def grand_winner?
    human.score >= MAX_POINTS || computer.score >= MAX_POINTS
  end

  def determine_grand_winner
    human.score >= MAX_POINTS ? human : computer
  end

  def display_grand_winner
    grand_winner = determine_grand_winner
    puts "The Grand Winner is #{grand_winner.name}"
  end

  def display_winner
    winner = determine_winner

    if winner == :tie
      puts "It's a tie!"
    else
      puts "#{winner.name} won!"
    end
  end

  def display_goodbye_message
    puts ""
    puts "Thanks for playing RPS! Goodbye!"
  end

  def play_again?
    puts ""

    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include?(answer)
      puts "Sorry, #{answer} is not a valid answer"
    end
    answer == 'y'
  end
end

RPSGame.new.play
