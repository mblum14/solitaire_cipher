require 'rspec'
require_relative 'cipher'

describe Cipher do
  let(:deck) { Deck.new }
  it "should convert the message to uppercase" do
    cipher = Cipher.new('hello there', nil)
    cipher.normalized_message.should eql 'HELLO THERE'
  end

  it "should ignore non-character letters" do
    cipher = Cipher.new('hello there!', nil)
    cipher.normalized_message.should eql 'HELLO THERE'
  end

  it "should pad the extra spaces with X's" do
    cipher = Cipher.new('hello there partner', nil)
    cipher.normalized_message.should eql 'HELLO THERE PARTN ERXXX'
  end

  it "converts a message to number values" do
    message = 'hello there partner'
    answer = [8, 5, 12, 12, 15, " ", 20, 8, 5, 18, 5, " ", 16, 1, 18, 20, 14, 5, 18]
    cipher = Cipher.new message, nil
    cipher.send(:convert_to_numbers, message).should eql answer
  end

  it "encodes a message" do
    cipher = Cipher.new('hello there', 'DWJXH YRFDG')
    cipher.encrypt.should eql 'LBVJW SZKVL'
  end

  it "decodes a message" do
    cipher = Cipher.new('LBVJW SZKVL', 'DWJXH YRFDG')
    cipher.decrypt.should eql 'HELLO THERE'
  end
end
