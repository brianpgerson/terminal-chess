require 'byebug'
require_relative "board"
require_relative "player"

class Game
  attr_reader :board
  def initialize
    @board = Board.new
    @player_w = Player.new(@board, :white)
    @player_b = Player.new(@board, :black)
    @curr_player = @player_w
    @other_player = @player_b
  end

  def take_turn
    if @board.checkmate_for(@curr_player.color)
      notify_mate
    elsif @board.board_in_check_for(@curr_player.color)
      notify_check
    end
    @pos = pick_a_spot
    piece = select_a_piece(@pos)
    almost_valid = piece.valid_moves

    moves = almost_valid.reject do |pos|
      pos == (@board.get_king(@other_player.color).position)
    end

    @curr_player.highlight_poss(moves)
  begin
    set_the_piece(moves, piece)
  rescue
    puts "Pick a valid move, or select the current piece's spot to select a different piece."
    sleep(1)
    retry
  end
    @curr_player.unhighlight_poss

    player_switch
  end


  def notify_mate
    puts "CHECKMATE"
    sleep(5)
    exit
  end


  def notify_check
    puts "CHECK"
    sleep(2)
  end

  def pick_a_spot
    @curr_player.move
  end

  def select_a_piece(pos)
    selected_piece = @board[pos]
    until @curr_player.color == selected_piece.color
      puts "Please select your own player."
      sleep(1)
      @pos = pick_a_spot
      selected_piece = @board[@pos]
    end
    selected_piece
  end

  def set_the_piece(moves, selected_piece)
    new_pos = @curr_player.move
    if moves.include?(new_pos)
      row, col = new_pos
      @board.move!(@pos, new_pos, selected_piece)
      if selected_piece.class == Pawn && selected_piece.first_move = true
        selected_piece.first_move = false
      end
    elsif new_pos == selected_piece.position
      @curr_player.unhighlight_poss
      player_switch
      puts "Select another piece"
      sleep(1)
      return
    else
      raise "Pick a valid move!"
    end
    @curr_player.display.render
  end

  def player_switch
    @curr_player = @curr_player == @player_w ? @player_b : @player_w
    @other_player = @other_player == @player_w ? @player_b : @player_w
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new

  100.times { game.take_turn }

end
