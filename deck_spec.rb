require 'rspec'
require_relative 'deck'

describe Deck do
  let(:deck) { Deck.new }
  it "should be initialized with a clean deck of cards" do
    deck.cards.should eql (1..52).to_a << 'A' << 'B'
  end

  it "considers the deck circular when moving the last card down one spot" do
    deck.cards = ((1..52).to_a << ['B', 'A']).flatten
    deck.move_card 'B', 2
    deck.cards.should eql ([1, 'B'] << (2..52).to_a << 'A').flatten
  end

  it "should move a card down 1 spot" do
    deck.move_card 'A', 1
    deck.cards.should eql (1..52).to_a << 'B' << 'A'
  end

  it "should triple cut the deck" do
    deck.cards = ([1, 2, 'B'] << (3..50).to_a << ['A',51, 52]).flatten
    deck.triple_cut
    deck.cards.should eql ([51, 52,'B'] << (3..50).to_a << ['A', 1, 2]).flatten
  end

  it "should count cut the deck" do
    deck.cards = ([51, 'A', 1, 'B'] + (2..50).to_a + [52]).flatten
    deck.count_cut
    deck.cards.should eql ([50, 51, 'A', 1, 'B'] + (2..49).to_a + [52]).flatten
  end

  it "should generate the output letter" do
    deck.cards = ((2..52).to_a + ['A', 'B', 1]).flatten
    deck.output_letter.should eql 'D'
  end

  it "should generate the output letter" do
    deck.cards = (["B", 6] + (14..50).to_a + [52, 1, 2, 9, 10, 11, 3, 'A', 4, 5, 7, 8, 12, 13, 51]).flatten
    deck.output_letter.should eql 'Y'
  end
end
