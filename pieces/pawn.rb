require_relative "pieces"
require "byebug"
class Pawn < Piece
  attr_accessor :first_move, :initial_row

  def initialize(position, board, color)
    super(position, board, color)
    @value = " ♟ "
    @initial_row = color == :black ? 1 : 6
    @first_move = @initial_row == position[0]
  end

  def all_moves
    row, col = @position
    if color == :black
      move, long_move = 1, 2
    else
      move, long_move = -1, -2
    end

    possible_moves = {
      first_move: [row + long_move, col],
      standard_move: [row + move, col],
      right_kill: [row + move, col + 1],
      left_kill: [row + move, col - 1]
    }
    possible_moves.select { |key, pos| @board.in_bounds?(pos) && pos != @position }
  end

  def moves
    filtered_moves = []
    #first move
    if @first_move
      first_move_pos = all_moves[:first_move]
      if @board[first_move_pos].colorless?
        filtered_moves << first_move_pos
      end
    end
    # kill moves
    kill_moves = [all_moves[:right_kill], all_moves[:left_kill]]
    kill_moves.each do |pos|
      unless pos.nil?
        if !@board[pos].color.nil? && @board[pos].color != @color
          filtered_moves << pos
        end
      end
    end
    #standard move

    if @board[all_moves[:standard_move]].colorless?
      filtered_moves << all_moves[:standard_move]
    end

    filtered_moves
  end



end
