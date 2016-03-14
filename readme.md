# Terminal Chess

Have you ever wished you could simply fire up a new terminal tab and play a beautiful, functional game of chess, complete with color and keyboard controls?

Wish granted, friend: introducing *Terminal Chess*.

## Run This Code

First things first, you'll want to clone this repo:

`git clone https://github.com/brianpgerson/terminal-chess.git`

Next, navigate to your chess directory and `gem install colorize`, which will give you the beautiful magentas and reds of Terminal Chess.

Finally, run `ruby game.rb`.

(If you really want to soak in the unicode beauty of the game, zoom in a few times, too.)

## How to Play

I'll refer you to this [fine article](https://www.chess.com/learn-how-to-play-chess)

But in all seriousness, you'll want to use the arrow keys to move your selector/cursor. When you've highlighted a piece you want to move (remember, white goes first), press enter.

All the moves you can make will instantly highlight! If there are no moves available for that piece - or if you decide you'd rather use another piece regardless - simply select the same piece to cancel your original selection.

The game will end when checkmate is detected.

## Fun Code Things

I really wanted to stay as modular as possible here, so each class, no matter how small, has its own file. Modules like sliding moves and stepping moves apply to the relevant piece classes, or (in the case of the Queen) both will apply at once.

### Piece#valid_moves

Checks for moves that result in check by deeply duping the board, making the move, and checking the game status on the duped board:

```
def move_results_in_check(new_pos)
  future_board = @board.dup_self
  duped_guy = future_board[@position]
  future_board.move!(@position, new_pos, duped_guy)
  future_board.board_in_check_for(self.color)
end
```

Board is deep-duped because we don't want to affect the actual pieces involved in the real game just in order to check hypothetical moves:

### Board#dup_self

```
def dup_self
<!-- false is passed in order to stop the new board from populating itself with default pieces -->
  new_board = Board.new(false)
  new_board.grid.map!.with_index do |row, i|
    row.map.with_index do |pos, j|
      pos = self[[i, j]].class.new([i,j], new_board, self[[i, j]].color)
    end
  end
  new_board
end
```
