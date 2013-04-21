class Deck
  attr_accessor :cards

  def initialize cards=nil
    @cards ||= (1..52).to_a << 'A' << 'B'
  end

  def move_card card, lines
    index = @cards.index(card)
    @cards.delete_at(index)
    insert_at = (index + lines) > 53 ? (index + lines + 1) % 54 : (index + lines)
    @cards.insert(insert_at, card)
  end

  def triple_cut
    index_a = @cards.index('A')
    index_b = @cards.index('B')
    if index_a > index_b
      bottom = @cards.pop(53-index_a)
      top = @cards.shift(index_b)
    else
      bottom = @cards.pop(53-index_b)
      top = @cards.shift(index_a)
    end

    @cards.unshift bottom
    @cards.concat top
    @cards.flatten!
  end

  def count_cut
    cut_by = value_of @cards.last
    off_the_top = @cards.shift(cut_by.to_i)
    @cards.insert(-2, off_the_top).flatten!
  end

  def output_letter
    top_card = value_of @cards.first
    card = @cards[top_card]
    return %W(A B).include?(card) ? nil : ('A'..'Z').to_a[(card.to_i % 26) - 1]
  end

  def value_of card
    case card
    when 'A' then 53
    when 'B' then 53
    else card.to_i
    end
  end
end

