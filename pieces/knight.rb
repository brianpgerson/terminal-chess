require_relative "pieces"

class Knight < Piece
  include SteppingMoves


  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♞ "
  end


  def move_deltas
    [
      [1, 2],
      [2, 1],
      [1, -2],
      [-1, 2],
      [-2, 1],
      [2, -1],
      [-1, -2],
      [-2, -1]
    ]
  end

end
