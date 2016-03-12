require_relative "pieces"

class NullPiece < Piece

  def initialize(position, board, color)
    super(position, board, color)
    @value = "   "
  end

  def valid_moves
    []
  end

end
