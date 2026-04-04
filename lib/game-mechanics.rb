require_relative 'snake'
require_relative 'board'
require_relative 'tile'
require_relative 'advanced_controls'

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
    while @snake.alive? == true
      fluid_board
      new_direction = input_receiver
      @snake.new_location?(new_direction)
      @snake.dies?(@board.layout[@snake.current_location_index])
      break if @snake.alive? == false
      @snake.move(@board)
    end
  end
end