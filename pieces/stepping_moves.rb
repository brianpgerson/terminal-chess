module SteppingMoves

  def moves
    current_x, current_y = @position
    possible_moves = []
    move_deltas.each do |step|
      next_pos = [current_x + step[0], current_y + step[1]]
      if @board.in_bounds?(next_pos)
        if @board[next_pos].color.nil? || @board[next_pos].color != self.color
          possible_moves << next_pos
        end
      end
    end

    possible_moves
  end

end
