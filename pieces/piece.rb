require "colorize"

class Piece
  attr_accessor :position, :board
  attr_reader :value, :color

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def colorless?
    self.color.nil?
  end

  def move_results_in_check(new_pos)
    future_board = @board.dup_self
    duped_guy = future_board[@position]
    future_board.move!(@position, new_pos, duped_guy)
    future_board.board_in_check_for(self.color)
  end

  def valid_moves
    moves.reject { |new_pos| move_results_in_check(new_pos) }
  end

end
