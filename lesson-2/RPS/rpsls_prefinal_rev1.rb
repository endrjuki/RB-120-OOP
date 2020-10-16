require 'pry'
module CoreExtensions
  module Array
    def joinor(delimiter=', ', word='or')
      return first if length == 1
      "#{self[0..-2].join(delimiter)} #{word} #{self[-1]}"
    end
  end
end

Array.include CoreExtensions::Array

class Move
  include Comparable

  attr_reader :value, :beats, :loses

  SHORTHAND_DICTIONARY = { 'r' => 'rock', 'p' => 'paper', 's' => 'scissors',
                           'l' => 'lizard', 'sp' => 'spock' }

  VALID_MOVES = SHORTHAND_DICTIONARY.values
  VALID_CHOICES = SHORTHAND_DICTIONARY.to_a.flatten

  def to_s
    @value
  end

  def <=>(other_move)
    if beats.include?(other_move.value)
      1
    elsif other_move.beats.include?(value)
      -1
    else
      0
    end
  end
end

class Rock < Move
  def initialize
    @value = 'rock'
    @beats = %w(scissors lizard)
    @loses = %w(spock paper)
  end
end

class Paper < Move
  def initialize
    @value = 'paper'
    @beats = %w(rock spock)
    @loses = %w(scissors lizard)
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
    @beats = %w(paper lizard)
    @loses = %w(rock spock)
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
    @beats = %w(spock paper)
    @loses = %w(rock scissors)
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
    @beats = %w(rock scissors)
    @loses = %w(paper lizard)
  end
end

class History
  def initialize
    @moves = []
  end

  def moves
    @moves[0..-2]
  end

  def add(move)
    @moves << move
  end

  def last_round_move
    return nil if moves.last.nil?
    moves.last
  end

  def last_move
    @moves.last
  end

  def full_move_record
    @moves
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    @score = 0
    @history = History.new
  end
end

class Human < Player
  def initialize
    set_name
    super
  end

  def set_name
    system "clear" || system("cls")

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
      puts "\nPlease choose between : #{valid_moves_display_version.joinor}."
      choice = gets.chomp
      break if Move::VALID_CHOICES.include?(choice)
      puts "Sorry, '#{choice}' is not a valid move"
    end

    self.move = Object.const_get(adjust_for_shorthand(choice)).new
    @history.add(move)
  end

  def adjust_for_shorthand(choice)
    if Move::SHORTHAND_DICTIONARY.keys.include?(choice)
      Move::SHORTHAND_DICTIONARY[choice].capitalize
    else
      choice.capitalize
    end
  end

  def valid_moves_display_version
    Move::VALID_MOVES.map do |m|
      if m.start_with?('sp')
        "[#{m[0, 2]}]#{m[2..-1]}"
      else
        "[#{m[0]}]#{m[1..-1]}"
      end
    end
  end
end

class Computer < Player
  PLAYERS = %w(Ultron Bender Sophia Reaper)

  def self.display_choices
    PLAYERS.each_with_index { |player, idx| puts "[#{idx + 1}] #{player}" }
  end

  def choose(human_history)
    self.move = make_move(human_history).new
    @history.add(move)
  end

  def make_random_move
    Object.const_get(Move::VALID_MOVES.sample.capitalize)
  end
end

class Ultron < Computer
  INTRO_MESSAGE = "I won't fall for the same move twice!"

  def initialize
    @name = 'Ultron'
    super
  end

  def make_move(human_history)
    make_counter_move(human_history)
  end

  private

  def make_counter_move(history)
    if history.moves.empty?
      make_random_move
    else
      Object.const_get(history.last_round_move.loses.sample.capitalize)
    end
  end
end

class Bender < Computer
  INTRO_MESSAGE = "Ah, so many choices, but it makes so little difference..."

  def initialize
    @name = 'Bender'
    super
  end

  def make_move(*)
    make_stubborn_move
  end

  private

  def make_stubborn_move
    if history.full_move_record.empty?
      make_random_move
    else
      history.last_move.class
    end
  end
end

class Sophia < Computer
  INTRO_MESSAGE = "I'll follow your every move!"

  def initialize
    @name = 'Sophia'
    super
  end

  def make_move(history)
    make_copycat_move(history)
  end

  private

  def make_copycat_move(history)
    if history.moves.empty?
      make_random_move
    else
      history.last_round_move.class
    end
  end
end

class Reaper < Computer
  INTRO_MESSAGE = "You've chosen certain doom. I will be the instrument of your unmaking."

  def initialize
    @name = 'Reaper'
    super
  end

  def make_move(history)
    make_clairvoyant_move(history)
  end

  private

  def make_clairvoyant_move(history)
    Object.const_get(history.last_move.loses.sample.capitalize)
  end
end

class RPSGame
  attr_accessor :human, :computer

  MAX_POINTS = 5
  COLUMN_PADDING = 4

  def initialize
    @human = Human.new
  end

  def play
    display_welcome_message
    display_rules
    match_loop
    display_goodbye_message
  end

  private

  def match_loop
    loop do
      reset_game
      pick_opponent
      display_opponent_and_intro_message
      round_loop
      display_grand_winner if grand_winner?
      break unless play_again?
    end
  end

  def reset_game
    reset_score
    reset_history
  end

  def pick_opponent
    puts "\nPick Your opponent, type in [1-#{Computer::PLAYERS.size}]:"
    choice = retrieve_opponent_input
    @computer = Object.const_get(choice.capitalize).new
  end

  def retrieve_opponent_input
    choice = nil
    loop do
      Computer.display_choices
      choice = gets.chomp
      break if ("1"..Computer::PLAYERS.size.to_s).include?(choice)
      system "clear" || system("cls")
      puts "Sorry, that's not a valid choice"
    end
    choice = Computer::PLAYERS[choice.to_i - 1]
  end

  def reset_score
    human.score = 0
  end

  def reset_history
    human.history = History.new
  end

  def round_loop
    loop do
      human.choose
      computer.choose(human.history)
      display_move_history
      display_moves
      display_winner

      update_score
      display_score
      break if grand_winner?
    end
  end

  def display_welcome_message
    system "clear" || system("cls")
    puts "Welcome to RPS!"
  end

  def display_rules
    puts "One who scores #{MAX_POINTS} points first is the Grand Winner!"
  end

  def display_opponent_and_intro_message
    system "clear" || system("cls")
    puts "You will be playing against #{computer.name}."
    puts "#{computer.name} says \"#{@computer.class::INTRO_MESSAGE}\""
  end

  def display_moves
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
    puts "\n#{human.name} score: #{human.score}"
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
    puts "\nThanks for playing RPS! Goodbye!"
  end

  def play_again?
    answer = nil
    loop do
      puts "\nWould you like to play again? (y/n)"
      answer = gets.chomp
      break if %w(y n).include?(answer)
      puts "Sorry, #{answer} is not a valid answer"
    end
    system "clear" || system("cls")
    answer == 'y'
  end

  def calc_human_col_size
    full_human_move_record = human.history.full_move_record
    longest_move_string = full_human_move_record.map(&:value).map(&:size)
    [longest_move_string, header_strings[1]].map(&:size).max + COLUMN_PADDING
  end

  def calc_computer_col_size
    full_computer_move_record = computer.history.full_move_record
    longest_move_string = full_computer_move_record.map(&:value).max_by(&:size)
    [longest_move_string, header_strings[2]].map(&:size).max + COLUMN_PADDING
  end

  def calc_winner_col_size
    longest_name = [human.name, computer.name].map(&:size).max
    [longest_name, header_strings[3].length].max + COLUMN_PADDING
  end

  def calc_nr_col_size
    header_strings[0].size + COLUMN_PADDING
  end

  def header_strings
    ["Move Nr",
     "#{@human.name}'s Move",
     "#{@computer.name}'s Move",
     "Winner"]
  end

  def total_table_length
    calc_nr_col_size + calc_human_col_size +
      calc_computer_col_size + calc_winner_col_size
  end

  def header_divider
    print "-" * total_table_length
  end

  def number_header_column
    header_strings[0].ljust(calc_nr_col_size)
  end

  def h_move__header_column
    header_strings[1].ljust(calc_human_col_size)
  end

  def c_move_header_column
    header_strings[2].ljust(calc_computer_col_size)
  end

  def winner_header_column
    header_strings[3].ljust(calc_winner_col_size)
  end

  def display_move_history_header
    print  number_header_column +
           h_move__header_column +
           c_move_header_column +
           winner_header_column
    puts ""
    puts header_divider
  end

  def generate_winner_string(moves)
    if moves[0] > moves[1]
      human.name
    elsif moves[0] < moves[1]
      computer.name
    else
      '-'
    end
  end

  def history_table_row(move_nr, moves)
    winner_str = generate_winner_string(moves)

    h_move_str = moves[0].value
    c_move_str = moves[1].value

    (move_nr.ljust(calc_nr_col_size) +
      h_move_str.ljust(calc_human_col_size) +
      c_move_str.ljust(calc_computer_col_size) +
      winner_str.ljust(calc_winner_col_size))
  end

  def display_move_history
    system "clear" || system("cls")
    display_move_history_header
    h_history = human.history.full_move_record
    c_history = computer.history.full_move_record
    move_history_arr = h_history.zip(c_history)

    move_history_arr.each_with_index do |moves, idx|
      move_nr = (idx + 1).to_s
      puts history_table_row(move_nr, moves)
    end

    puts ""
  end
end

RPSGame.new.play
