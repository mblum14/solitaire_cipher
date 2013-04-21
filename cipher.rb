require_relative 'keystream'
require_relative 'deck'

class Cipher
  attr_accessor :message, :keystream, :normalized_message

  def initialize message, keystream
    @message = message
    @normalized_message = normalize(message)
    @keystream = keystream
  end

  def encrypt
    numbered_message = convert_to_numbers normalize(@message)
    numbered_keystream = convert_to_numbers @keystream
    encrypted_numbers = [numbered_message, numbered_keystream].transpose.map { |x| x.reduce(:+) }
    convert_to_characters encrypted_numbers
  end

  def decrypt
    numbered_message = convert_to_numbers normalize(@message)
    numbered_keystream = convert_to_numbers @keystream
    decrypted_numbers = [numbered_message, numbered_keystream].transpose.map { |x| x.first.kind_of?(::String) ? ' ' : x.reduce(:-) }
    convert_to_characters decrypted_numbers
  end
  private

  def normalize text
    text = text.upcase.delete("^A-Z")
    text += ("X" * ((text.length+1) % 5))
    text.scan(/.{5}/).join(' ')
  end

  def convert_to_numbers text
    numbers = []
    alphabet = ('A'..'Z').to_a
    text.to_s.upcase.each_char {|c| numbers << (c == ' ' ? c : alphabet.index(c) + 1) }
    numbers
  end

  def convert_to_characters array
    chars = []
    alphabet = ('A'..'Z').to_a
    array.each do |n| 
      chars << (n.kind_of?(::String) ? ' ' : alphabet[(n % 26) - 1])
    end
    chars.join('')
  end
end
