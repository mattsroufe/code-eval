Card = Struct.new(:value, :suit)

class Hand
  attr_accessor :cards

  def initialize(cards)
    cards.map! { |card| [card[0], card[1]] }
    cards.each do |card|
      case card[0]
      when "A" then card[0] = 14
      when "K" then card[0] = 13
      when "Q" then card[0] = 12
      when "J" then card[0] = 11
      when "T" then card[0] = 10
      else
        card[0] = card[0].to_i
      end
    end.sort_by! { |card| -card[0] }
    @cards = cards.map do |card|
      Card.new(card[0], card[1])
    end
  end

  def self.winner(left, right)
    left_score = left.score
    right_score = right.score

    if left_score == right_score
      if (left.card_values - right.card_values).empty? && !left.full_house?
        "none"
      else
        left.card_values.each_with_index do |left_card_value, i|
          next if left_card_value == right.card_values[i]
          return left_card_value > right.card_values[i] ? "left" : "right"
        end
      end
    else
      left_score > right_score ? "left" : "right"
    end
  end

  def card_values
    cards.map(&:value)
  end

  def card_suits
    cards.map(&:suit)
  end

  def straight?
    card_values.sort == (card_values[4]..card_values[0]).to_a
  end

  def flush?
    card_suits.uniq.count == 1
  end

  def four_of_a_kind?
    same_value_counts.max == 4
  end

  def three_of_a_kind?
    same_value_counts.max == 3
  end

  def one_pair?
    same_value_counts.max == 2
  end

  def two_pairs?
    same_value_counts.count == 3 && (same_value_counts - [1,2,2]).empty?
  end

  def same_value_counts
    counts = []
    card_values.uniq.each do |unique_value|
      count = 0
      card_values.each do |value|
        count += 1 if value == unique_value
      end
      counts << count
    end
    counts
  end

  def full_house?
    card_values.uniq.count == 2 && (same_value_counts - [3,2]).empty?
  end

  def straight_flush?
    flush? && straight?
  end

  def royal_flush?
    straight_flush? && has_ace?
  end

  def has_ace?
    card_values.max == 14
  end

  def score
    return 9 if royal_flush?
    return 8 if straight_flush?
    return 7 if four_of_a_kind?
    return 6 if full_house?
    return 5 if flush?
    return 4 if straight?
    return 3 if three_of_a_kind?
    return 2 if two_pairs?
    return 1 if one_pair?
    0
  end
end

File.open(ARGV[0]).each_line do |line|
  cards = line.split(' ')
  left = Hand.new(cards.slice(0,5))
  right = Hand.new(cards.slice(5,10))
  puts Hand.winner(left, right)
end
