require 'pry'
module TTTGame # namespace
  module SyntaxTools
    def clear
      system 'clear'
    end
  end

  module CoreExtensions
    module Array
      def joinor(delimiter=', ', word='or')
        return first if length == 1
        "#{self[0..-2].join(delimiter)} #{word} #{self[-1]}"
      end
    end
  end

  Array.include CoreExtensions::Array

  class Board
    attr_accessor :squares

    WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                    [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                    [[1, 5, 9], [3, 5, 7]]              # diagonal
    CENTER = 5

    def initialize
      @squares = {}
      reset
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def draw
      puts "     |     |"
      puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
      puts "     |     |"
      puts "-----+-----+-----"
      puts "     |     |"
      puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
      puts "     |     |"
      puts "-----+-----+-----"
      puts "     |     |"
      puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
      puts "     |     |"
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def reset
      (1..9).each { |key| @squares[key] = Square.new }
    end

    def []=(num, marker)
      @squares[num].marker = marker
    end

    def [](num)
      @squares[num].marker
    end

    def place_center_square
      CENTER if unmarked_keys.include?(CENTER)
    end

    def full?
      unmarked_keys.empty?
    end

    def someone_won?
      !!winning_marker
    end

    def winning_marker
      WINNING_LINES.each do |line|
        markers = get_markers_at(line)
        markers.delete(Square::INITIAL_MARKER)
        return markers.first if markers.length == 3 && markers.uniq.length == 1
      end
      nil
    end

    def find_strategic_square(marker)
      WINNING_LINES.each do |line|
        markers = get_markers_at(line)
        next unless n_identical_markers?(2, markers, marker)

        return (line & unmarked_keys).sample
      end
      nil
    end

    def unmarked_keys
      @squares.keys.select { |key| @squares[key].unmarked? }
    end

    def get_markers_at(line)
      @squares.values_at(*line).map(&:marker)
    end

    def strategic_move(marker)
      WINNING_LINES.each do |line|
        markers = get_markers_at(line)
        next unless n_identical_markers?(2, markers, marker)
        line.each do |position|
          return position if self[position] == Square::INITIAL_MARKER
        end
      end
      nil
    end

    private

    def n_identical_markers?(number, marker_arr, marker)
      marker_arr.delete(Square::INITIAL_MARKER)
      marker_arr.count(marker) == number && marker_arr.uniq.length == 1
    end
  end

  class Square
    INITIAL_MARKER = ' '
    attr_accessor :marker

    def initialize(marker=INITIAL_MARKER)
      @marker = marker
    end

    def marked?
      marker != INITIAL_MARKER
    end

    def to_s
      @marker
    end

    def unmarked?
      marker == INITIAL_MARKER
    end
  end

  class Player
    attr_reader :name
    attr_accessor :marker, :score

    def initialize
      @name = nil
      @marker = nil
      @score = 0
    end
  end

  class Human < Player
    def initialize
      @name = nil
      @marker = nil
      @score = 0
    end

    def choose_marker
      puts ""
      puts "Pick your marker: #{[TTTGame::MARKER_1, TTTGame::MARKER_2].joinor}"
      choice = nil
      loop do
        choice = gets.chomp.upcase
        break if [TTTGame::MARKER_1, TTTGame::MARKER_2].include?(choice)
        puts "Invalid choice! pick between #{[TTTGame::MARKER_1, TTTGame::MARKER_2].joinor}!"
      end
      @marker = choice
    end

    def choose_name
      puts "Please enter your name:"
      name = nil
      loop do
        name = gets.chomp
        break if !name.empty?
        puts "Please don't leave the name field blank! Try again!"
      end
      @name = name
    end

    def choose_first_move
      puts ""
      puts "Options:"
      puts "1) You have the first move"
      puts "2) Computer has the first move"
      puts ""
      puts "Enter 1 or 2 to choose"

      choice = nil
      loop do
        choice = gets.chomp
        break if ["1", "2"].include?(choice)
        puts "Invalid choice, please choose between 1 or 2"
      end
      choice
    end
  end

  class Computer < Player
    def choose_name
      @name = ['Walle', 'Chappie', 'Alita', 'R2D2', 'Marvin'].sample
    end
  end

  class TTTGame
    include SyntaxTools

    attr_reader :board, :human, :computer

    MARKER_1 = 'X'
    MARKER_2 = 'O'
    FIRST_TO_MOVE = "X"
    MAX_SCORE = 3

    def initialize
      @board = Board.new
      @human = Human.new
      @computer = Computer.new
      @first_move = :choose # :choose, :computer, :human
    end

    def setup_game
      set_names
      set_first_move
      set_markers
      set_current_marker
    end

    def set_names
      human.choose_name
      computer.choose_name
    end

    def set_first_move
      return @first_move unless @first_move == :choose
      answer = human.choose_first_move
      @first_move = case answer
                    when '1' then :human
                    when '2' then :computer
                    end
    end

    def set_markers
      human.choose_marker
      computer.marker = (human.marker == MARKER_1 ? MARKER_2 : MARKER_1)
    end

    def set_current_marker
      @current_marker = case @first_move
                        when :human then human.marker
                        when :computer then computer.marker
                        end
    end

    def play
      display_welcome_message
      match_loop
      display_goodbye_message
    end

    private

    def display_welcome_message
      clear
      puts "Welcome to Tic Tac Toe"
      puts ""
    end

    def display_goodbye_message
      puts "Thanks for playing TTT, Good bye!"
    end

    def display_board_and_score
      display_score
      puts ""
      puts "You are #{human.marker}. #{computer.name} is a #{computer.marker}."
      puts ""
      board.draw
    end

    def clear_screen_and_display_board
      clear
      display_board_and_score
    end

    def update_score
      case board.winning_marker
      when human.marker
        human.score += 1
      when computer.marker
        computer.score += 1
      end
    end

    def play_round
      clear_screen_and_display_board
      player_move
      update_score
      display_result
      sleep 1
      reset_board
    end

    def match_loop
      loop do
        setup_game
        play_round until grand_winner?
        display_grand_winner

        break unless play_again?
        reset_score
        reset_board
        display_play_again_message
      end
    end

    def grand_winner?
      human.score >= MAX_SCORE || computer.score >= MAX_SCORE
    end

    def return_grand_winner
      human.score >= MAX_SCORE ? human.name : computer.name
    end

    def display_grand_winner
      puts "The Grand Winner is #{return_grand_winner}"
    end

    def current_player_moves
      if human_turn?
        human_moves
        @current_marker = computer.marker
      else
        computer_moves
        @current_marker = human.marker
      end
    end

    def player_move
      loop do
        current_player_moves
        clear_screen_and_display_board if human_turn?

        break if board.someone_won? || board.full?
      end
    end

    def human_turn?
      @current_marker == human.marker
    end

    def human_moves
      puts "Choose a square (#{board.unmarked_keys.joinor})"
      square = nil
      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, that's not a valid choice."
      end

      board[square] = human.marker
    end

    def computer_moves
      move = board.find_strategic_square(computer.marker) ||
             board.find_strategic_square(human.marker) ||
             board.place_center_square

      if !move
        move = board.unmarked_keys.sample
      end

      board[move] = computer.marker
    end

    def display_result
      clear_screen_and_display_board

      case board.winning_marker
      when human.marker
        puts "#{human.name} won!"
      when computer.marker
        puts "#{computer.name} won!"
      else
        puts "It's a tie"
      end
    end

    def display_score
      puts "#{human.name} #{human.score} : #{computer.score} #{computer.name}"
    end

    def play_again?
      answer = nil
      loop do
        puts "Would you like to play again? (y/n)"
        answer = gets.chomp.downcase
        break if %w(y n).include? answer
        puts "Sorry, must be y or n"
      end

      answer == 'y'
    end

    def display_play_again_message
      puts "Let's play again!"
      puts ""
    end

    def reset_score
      human.score = 0
      computer.score = 0
    end

    def reset_board
      board.reset
      @current_marker = FIRST_TO_MOVE
      clear
    end

  end
end


game = TTTGame::TTTGame.new
game.play
