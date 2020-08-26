require "pry"

module Hand
  def calculate_score
    cards = self.hand.map(&:rank)
    total = 0

    cards.each do |card|
      case card
      when 'A'           then total += 11
      when 'J', 'K', 'Q' then total += 10
      else;                   total += card.to_i
      end
    end

    cards.count('A').times do
      break if total <= 21
      total -= 10
    end

    total
  end
end

class Player
  include Hand

  attr_accessor :hand

  def initialize(name)
    @name = name
    @hand = []
  end


  def stay
  end

  def busted?
    calculate_score > Game::MAX_SCORE
  end

  def total
    # definitely looks like we need to know about "cards" to produce some total
  end
end

class Dealer < Player

  def deal
    # does the dealer or deck deal?
  end
end

class Deck
  attr_accessor :cards

  SUITS = %w(♠ ♥ ♦ ♣)
  RANK = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  def initialize
    @cards = generate_deck
  end

  def generate_deck
    deck = []
    SUITS.each { |suit| RANK.each { |rank| deck << Card.new(rank, suit) } }
    deck.shuffle
  end

  def deal
    @cards.pop
  end
end

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end
end

class Game
  attr_accessor :human, :dealer, :deck

  MAX_SCORE = 21

  def display_welcome_message
    puts "Welcome to 21"
    puts "PLACEHOLDER"
    sleep(1)
  end

  def display_goodbye_message
    puts "Thanks for playing 21. Goodbye!"
  end

  def display_table
    puts "----------"
    puts "Player's hand:"
    puts "#{display_cards(@human)}"
    puts "#{@human.calculate_score}"
    puts "----------"
    puts "Computer's hand:"
    puts "#{display_cards(@dealer)}"
    puts "<COMPUTER SCORE HERE: ?>"
  end

  def initialize
    @deck = Deck.new
    @human = Player.new("Bobby")
    @dealer = Dealer.new("Holmes")
  end

  # ------- PLAYER TURN
  def deal_card(player)
    player.hand << @deck.deal
  end

  def hit_or_stay
    puts ""
    puts "Would you like to hit or stay? (type in 'h' or 's')"

    choice = nil
    loop do
      choice = gets.chomp.downcase
      break if %w(h s).include?(choice)
      puts "Invalid choice!"
    end

    choice
  end

  def player_busted?(player)
    player.busted?
  end

  def player_turn
    loop do
      deal_card(@human)
      display_table
      break if player_busted?(@human)
      case hit_or_stay
      when 'h'
        system "clear"
        puts "Player choses to hit!"
        next
      when 's'
        system "clear"
        puts "Player choses to stay!"
        sleep(1)
        break
      end
    end

    if player_busted?(@human)
      puts "You busted! Computer wins!"
      sleep(1)
    end

  end

  def computer_turn
    loop do
      system "clear"
      display_table
      sleep 1
      deal_card(@dealer)
      break if @dealer.hand.length > 4
    end
  end

  def display_cards(player)
    result = []

    player.hand.each do |card|
      result.push("#{card.suit} #{card.rank}")
    end

    result.join(', ')
  end

  def start
    display_welcome_message
    deal_initial_cards
    show_initial_cards

    player_turn

    computer_turn

    #setup_game

    #show_initial_cards
    #player_turn
    #dealer_turn
    #show_result
    display_goodbye_message

  end
end

game = Game.new.start
