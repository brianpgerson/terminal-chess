require_relative "display"
require "byebug"
class Player
  attr_reader :display, :color

  def initialize(board, color)
    @board = board
    @display = Display.new(board)
    @color = color
  end

  def highlight_poss(moves)
    @display.to_highlight.concat(moves)
  end

  def unhighlight_poss
    @display.to_highlight = []
  end

  def move
    result = nil
    until result
      @display.render
      result = @display.get_input
    end
    result
  end

end
