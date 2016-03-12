require "byebug"
module SlidingMoves

  def diagonals
    [
      [1, 1],
      [-1, 1],
      [1, -1],
      [-1, -1]
    ]
  end

  def vert_lats
    [
      [1, 0],
      [0, 1],
      [-1, 0],
      [0, -1]
    ]
  end

  def moves
    possible_moves = []

    directions.each do |direction|
      possible_moves.concat(collect_moves(direction))
    end

    possible_moves
  end

  def collect_moves(direction)
    directional_moves = []
    current_x, current_y = @position
    loop do
      current_x, current_y = current_x + direction[0], current_y + direction[1]
      next_pos = [current_x, current_y]
      break unless @board.in_bounds?(next_pos)
      if @board[next_pos].colorless?
        directional_moves << next_pos
      else
        directional_moves << next_pos if @board[next_pos].color != self.color
        break
      end

    end
    directional_moves
  end















end
