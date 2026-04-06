require_relative 'game_objects/snake'
require_relative 'game_objects/board'
require_relative 'game_objects/tile'
require_relative 'snake_tech/advanced_controls'

# Collection of methods needed to have the game running.
class Game
  include Advanced_Controls

  def initialize
    @snake = Snake.new
    @board = Board.new
  end

  # Spawns snake. While the snake is alive, an input is received, checked, and the snake moves if not determined dead.
  def play
    @board.layout[@snake.current_location_index].change_content(@snake, @snake.head_display)
    until @snake.alive? == false || @snake.won? == true
      fluid_board
      new_direction = input_receiver
      @snake.new_location?(new_direction)
      @snake.wins?(@board)
      @snake.dies?(@board.layout[@snake.current_location_index])
      break if @snake.alive? == false || @snake.won? == true
      @snake.move(@board)
    end
  end
end