class Keystream
  attr_accessor :deck, :keystream

  def initialize deck, size
    @deck = deck
    @keystream = generate_keystream deck, size
  end

  def to_s
    @keystream.join('').scan(/.{5}/).join(' ')
  end

  private

  def generate_keystream deck, size
    stream = []
    stream_length = roundup(size)
    while stream_length > 0
      deck.move_card 'A', 1  # move A down 1 card
      deck.move_card 'B', 2  # move B down two cards
      deck.triple_cut        # perform triple cut around A and B
      deck.count_cut         # perform count cut using value of bottom card
      letter = deck.output_letter
      unless letter.nil?
        stream << letter
        stream_length -= 1
      end
    end
    stream.each_slice(5).to_a
  end

  def roundup size, nearest=5
    return size % nearest == 0 ? size : size + nearest - (size % nearest)
  end
end
