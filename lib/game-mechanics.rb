require_relative 'game_objects/snake'
require_relative 'game_objects/board'
require_relative 'game_objects/tile'
require_relative 'game_objects/food'
require_relative 'advanced_controls'

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
    objects_spawn
    until @snake.alive? == false || @snake.won? == true
      fluid_board
      new_direction = input_receiver
      snake_management(new_direction)
      objects_spawn
      @snake.wins?(@board) if @snake.alive? == true
    end
    win_or_lose_declarations
  end

  # Handles snake movement and food spawns.
  def objects_spawn
    @snake.move(@board) if @board.layout.none? {|tile| tile.content == @snake.head}
    @food.spawn_in(@board)
  end

  # Manages every snake parts location/
  def snake_management(new_direction)
    @snake.slither
    @snake.head.new_location?(new_direction)
    @snake.move(@board)
    refresh_snake if @board.layout.none? {|tile| tile.content_display.include?("O") }
  end

  # Grows the snake and reflects that growth.
  def refresh_snake
    @snake.grow
    @snake.move(@board)
  end

  def win_or_lose_declarations
    puts "GAME OVER" if @snake.alive? == false
    puts "You win!" if @snake.won? == true
  end
end