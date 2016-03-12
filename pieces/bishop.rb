require_relative "pieces"

class Bishop < Piece
  include SlidingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♝ "
  end


  def directions
    diagonals
  end
  
end
