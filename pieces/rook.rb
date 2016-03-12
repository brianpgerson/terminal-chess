require_relative "pieces"
require 'byebug'

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
