require "spec_helper"

describe Hand do
  let(:cards) { %w[6D 7H AH 7S QC] }
  let(:hand) { Hand.new(cards) }

  describe ".new" do
    it "it creates a new instance with a cards argument" do
      expect(hand).to be_an_instance_of Hand
    end
  end

  describe ".winner" do
    it "returns the winner" do
      expect(Hand.winner(Hand.new(%w[6D 7H AH 7S QC]), Hand.new(%w[6H 7D AD 7C QS]))).to eq "none"
      expect(Hand.winner(Hand.new(%w[6D 7H AH 7S KC]), Hand.new(%w[6H 7D AD 7C QS]))).to eq "left"
      expect(Hand.winner(Hand.new(%w[6S 7H AH 7S KC]), Hand.new(%w[6D 7D AD 8D QD]))).to eq "right"
      expect(Hand.winner(Hand.new(%w[6S 7H 8H 9S TC]), Hand.new(%w[TD 7D 9D 8D JD]))).to eq "right"
      expect(Hand.winner(Hand.new(%w[6S 6H 7S 7H 7C]), Hand.new(%w[6D 6C 6S 7D 7D]))).to eq "left"
    end
  end

  describe "#cards" do
    it "returns the cards in the Hand" do
      expect(hand.cards.map(&:to_h)).to eq [{:value=>14, :suit=>"H"},
                                            {:value=>12, :suit=>"C"},
                                            {:value=>7, :suit=>"H"},
                                            {:value=>7, :suit=>"S"},
                                            {:value=>6, :suit=>"D"}]
    end
  end

  describe "#card_values" do
    it "returns the cards' values" do
      expect(hand.card_values).to eq([14, 12, 7, 7, 6])
    end
  end

  describe "#card_suits" do
    it "returns the cards' suits" do
      expect(hand.card_suits).to match_array(["D", "H", "H", "S", "C"])
    end
  end

  describe "has_ace?" do
    it "returns false if hand does not contain ace" do
      hand = Hand.new(%w[TD QH JH KS QC])
      expect(hand.has_ace?).to be_false
    end

    it "returns true if hand contains ace" do
      hand = Hand.new(%w[8D JH AH KS QC])
      expect(hand.has_ace?).to be_true
    end
  end

  describe "flush?" do
    it "returns false if hand does not contain flush" do
      hand = Hand.new(%w[TD QH AH KS QC])
      expect(hand.flush?).to be_false
    end

    it "returns true if hand contains flush" do
      hand = Hand.new(%w[9D JD AD KD QD])
      expect(hand.flush?).to be_true
    end
  end

  describe "four_of_a_kind?" do
    it "returns false if hand does not contain four-of-a-kind" do
      hand = Hand.new(%w[TD QH AH KS QC])
      expect(hand.four_of_a_kind?).to be_false
    end

    it "returns true if hand contains four-of-a-kind" do
      hand = Hand.new(%w[9C 9D 9S 9H QD])
      expect(hand.four_of_a_kind?).to be_true
    end
  end

  describe "three_of_a_kind?" do
    it "returns false if hand does not contain three-of-a-kind" do
      hand = Hand.new(%w[9C 9D 9S 9H QD])
      expect(hand.three_of_a_kind?).to be_false
    end

    it "returns true if hand contains three-of-a-kind" do
      hand = Hand.new(%w[9C 9D 9S KH QD])
      expect(hand.three_of_a_kind?).to be_true
    end
  end

  describe "two_pairs?" do
    it "returns false if hand does not contain two pairs" do
      hand = Hand.new(%w[9C 10D JS 9H QD])
      expect(Hand.new(%w[9C 10D JS 9H QD]).two_pairs?).to be_false
    end

    it "returns true if hand contains two pairs" do
      hand = Hand.new(%w[9C 9D QS KH QD])
      expect(hand.two_pairs?).to be_true
    end
  end

  describe "one_pair?" do
    it "returns false if hand does not contain one pair" do
      hand = Hand.new(%w[9C 9D 9S 9H QD])
      expect(hand.one_pair?).to be_false
    end

    it "returns true if hand contains one pair" do
      hand = Hand.new(%w[9C 9D QS KH JD])
      expect(hand.one_pair?).to be_true
    end
  end

  describe "full_house?" do
    it "returns false if hand does not contain full house" do
      hand = Hand.new(%w[TD QH AH KS QC])
      expect(hand.full_house?).to be_false
    end

    it "returns true if hand contains full house" do
      hand = Hand.new(%w[9C 9D 9S TH TD])
      expect(hand.full_house?).to be_true
    end
  end

  describe "straight?" do
    it "returns false if hand does not contain straight" do
      hand = Hand.new(%w[TD QH AH KS QC])
      expect(hand.straight?).to be_false
    end

    it "returns true if hand contains straight" do
      hand = Hand.new(%w[TD JD AD KD QD])
      expect(hand.straight?).to be_true
    end
  end

  describe "straight_flush?" do
    it "returns false if hand does not contain straight flush" do
      hand = Hand.new(%w[TD QH AH KS QC])
      expect(hand.straight_flush?).to be_false
    end

    it "returns true if hand contains straight flush" do
      hand = Hand.new(%w[TD JD AD KD QD])
      expect(hand.straight_flush?).to be_true
    end
  end

  describe "royal_flush?" do
    it "returns false if hand does not contain royal flush" do
      hand = Hand.new(%w[TD QH AH KS QC])
      expect(hand.royal_flush?).to be_false
    end

    it "returns true if hand contains royal flush" do
      hand = Hand.new(%w[TD JD AD KD QD])
      expect(hand.royal_flush?).to be_true
    end
  end
end
