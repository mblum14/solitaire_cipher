require 'rspec'
require_relative 'keystream'

describe Keystream do
  let(:deck)      { Deck.new }

  it "generates a keystream from a deck" do
    keystream = Keystream.new deck, 10
    keystream.keystream.should eql [%W(D W J X H), %W(Y R F D G)]
  end

  it "generates a padded keystream from a deck" do
    keystream = Keystream.new deck, 11
    keystream.keystream.should eql [%W(D W J X H), %W(Y R F D G), %W(T M S H P)]
  end

  it "converts the keystream to a string padded with a blank space every 5 characters" do
    keystream = Keystream.new deck, 11
    keystream.to_s.should eql 'DWJXH YRFDG TMSHP'
  end
end
