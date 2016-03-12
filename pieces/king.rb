require_relative "pieces"

class King < Piece
  include SteppingMoves

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♚ "
  end

  def move_deltas
    [
      [1, 1],
      [0, 1],
      [1, 0],
      [-1, 1],
      [1, -1],
      [-1, 0],
      [0, -1],
      [-1, -1]
    ]
  end

end
