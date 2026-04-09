require_relative 'game_objects/snake'
require_relative 'game_objects/board'
require_relative 'game_objects/tile'
require_relative 'game_objects/food'
require_relative 'snake_tech/advanced_controls'

# Collection of methods needed to have the game running.
class Game
  include Advanced_Controls

  def initialize
    @snake = Snake.new
    @board = Board.new
    @food = Food.new
  end

  # Spawns snake. While the snake is alive, an input is received, checked, and the snake moves if not determined dead.
  def play
    initial_spawn
    until @snake.alive? == false || @snake.won? == true
      fluid_board
      new_direction = input_receiver
      @snake.new_location?(new_direction)
      @snake.dies?(@board.layout[@snake.current_location_index])
      break if @snake.alive? == false
      objects_respawn
      @snake.wins?(@board)
    end
    win_or_lose_declarations
  end

  # Handles the first spawns of the game
  def initial_spawn
    @board.layout[@snake.current_location_index].change_content(@snake, @snake.head_display)
    @food.spawn_in(@board)
  end

  # Handles snake movement and food respawns.
  def objects_respawn
    @snake.move(@board)
    @food.spawn_in(@board)
  end

  def win_or_lose_declarations
    puts "GAME OVER" if @snake.alive? == false
    puts "You win!" if @snake.won? == true
  end
end