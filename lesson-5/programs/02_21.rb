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

  def busted?
    calculate_score > Game::MAX_SCORE
  end
end

class Dealer < Player
  # implement name functionality perhaps?
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
  attr_accessor :player, :dealer, :deck, :turn

  MAX_SCORE = 21

  def initialize
    @deck = Deck.new
    @player = Player.new("Bobby")
    @dealer = Dealer.new("Holmes")
    @turn = :player
  end

  def display_welcome_message
    system "clear"
    puts "Welcome to 21"
    puts "PLACEHOLDER"
    sleep(1)
    # IMPLEMENT 'press any key' functionality here
  end

  def display_goodbye_message
    puts "Thanks for playing 21. Goodbye!"
  end

  def dealer_hand_helper_method
    if !player_turn?
      dealer_score = dealer.calculate_score
      dealer_cards = display_cards(dealer, :display_all)
    else
      dealer_score = '???'
      dealer_cards = display_cards(dealer, :display_only_first)
    end
    [dealer_score, dealer_cards]
  end

  def display_table
    dealer_score, dealer_cards = dealer_hand_helper_method

    puts "----------"
    puts "Player's hand:"
    puts display_cards(player)
    puts "Score: #{player.calculate_score}"
    puts "----------"
    puts "Dealer's hand:"
    puts dealer_cards
    puts "Score: #{dealer_score}"
  end

  def clear_screen_and_display_table
    system "clear" || system("cls")
    display_table
  end

  # ------- PLAYER TURN
  def player_turn?
    turn == :player
  end

  def next_turn
    turn == :player ? @turn = :dealer : @turn = :player
  end

  def deal_card(player)
    player.hand << deck.deal
  end

  def hit(player)
    deal_card(player)
    puts "You chose to hit!"
    sleep(1)
  end

  def stay(player)
    puts "You chose to stay!"
    next_turn
    sleep(1)
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

    choice #returns string 'h' or 's'
  end

  def player_busted?(player)
    player.busted?
  end

  def player_turn
    loop do
      clear_screen_and_display_table

      choice = hit_or_stay
      if choice == 'h'
        hit(player)
      else
        stay(player)
        break
      end

      if player_busted?(player)
        puts "You busted!"
        display_table
        next_turn
        break
      end
    end
  end

  def dealer_turn
    loop do
      clear_screen_and_display_table

      until dealer.calculate_score >= 17
        clear_screen_and_display_table
        hit(dealer)
        sleep(1)
      end

      if player_busted?(dealer)
        puts "DEALER BUSTED, YOU WIN!"
        break
      end

      puts "Dealer stays"
      break
    end
  end

  def display_result
    if player.calculate_score > dealer.calculate_score
      puts "player won!"
    elsif player.calculate_score == dealer.calculate_score
      puts "It's a tie!"
    else
      puts "Dealer won!"
    end
  end

  def display_cards(player, amount=:display_all)
    result = []

    player.hand.each do |card|
      result.push("#{card.suit} #{card.rank}")
    end

    amount == :display_all ? cards = result.size : cards = 1
    result[0, cards].join(', ')
  end

  def deal_initial_cards
    2.times do
      deal_card(player)
      deal_card(dealer)
    end
  end


  def start
    display_welcome_message
    deal_initial_cards
    player_turn
    dealer_turn
    display_result
    #show_result
    display_goodbye_message

  end
end

game = Game.new.start
