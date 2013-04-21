require_relative 'cipher'
require_relative 'deck'

message = ARGV.first
deck = Deck.new
cipher = Cipher.new message, deck.keystream
