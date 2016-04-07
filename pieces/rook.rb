require_relative "pieces"

class Rook < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♜ "
  end

  def directions
    vert_lats
  end

end
