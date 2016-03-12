require 'byebug'
require "colorize"
require_relative "./pieces/pieces"
require_relative "display"
class Board
  attr_accessor :grid

  def initialize(pop = true)
    @grid = Array.new(8) { Array.new(8) { nil } }
    populate if pop
  end

  def back_row(i, j, color)
    [
      Rook.new([i,j], self, color),
      Knight.new([i,j], self, color),
      Bishop.new([i,j], self, color),
      Queen.new([i,j], self, color),
      King.new([i,j], self, color),
      Bishop.new([i,j], self, color),
      Knight.new([i,j], self, color),
      Rook.new([i,j], self, color)
      ]
  end


  def dup_self
    new_board = Board.new(false)
    new_board.grid.map!.with_index do |row, i|
      row.map.with_index do |pos, j|
        pos = self[[i, j]].class.new([i,j], new_board, self[[i, j]].color)
      end
    end
    new_board
  end

  def all_pieces_of_a_color(color)
    #TODO maybe just one condition here?
    @grid.flatten.select { |piece| piece.color == color && piece.color != nil }
  end

  def get_king(color)
    all_pieces_of_a_color(color).select { |piece| piece.class == King }.first
  end

  def board_in_check_for(color)
    opponent_color = color == :black ? :white : :black
    all_moves = []
    all_pieces_of_a_color(opponent_color).each { |piece| all_moves += piece.moves }
    all_moves.include?(get_king(color).position)
  end

  def checkmate_for(color)
    remaining_moves = []

    all_pieces_of_a_color(color).each do |piece|
      remaining_moves += piece.valid_moves
    end

    remaining_moves.empty?
  end

  def populate
    @grid.map!.with_index do |row, i|
      row.map.with_index do |space, j|
        case i
        when 0
          piece = back_row(i, j, :black)[j]
        when 7
          piece = back_row(i,j, :white).reverse[j]
        when 1
          piece = Pawn.new([i, j], self, :black)
        when 6
          piece = Pawn.new([i, j], self, :white)
        else
          piece = NullPiece.new([i, j], self, nil)
        end
      end
    end
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row, col = pos
    @grid[row][col] = piece
  end

  def in_bounds?(pos)
    pos[0].between?(0, 7) && pos[1].between?(0, 7)
  end

  def move!(old_pos, new_pos, selected_piece)
    self[new_pos] = selected_piece
    selected_piece.position = new_pos
    self[old_pos] = NullPiece.new(old_pos, self, nil)
  end

end
