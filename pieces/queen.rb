require_relative "pieces"
require "colorize"

class Queen < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♛ "
  end

  def directions
    vert_lats.concat(diagonals)
  end

end
