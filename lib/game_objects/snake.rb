require_relative 'board'
require_relative 'tile'
require_relative '../snake_tech/rng_spawner'

# A collection of methods to form and move the snake.
class Snake
  include RNG_Spawner

  attr_accessor :alive, :current_location_index, :head_display, :input, :won

  def initialize
    @head_display = "##D"
    @input = 'a'
    @alive = true
    @current_location_index = index_generator
    @won = false
  end

  # Shifts the index to move a certain direction.
  def new_location?(input)
    if input.nil?
      input = @input
    else
      @input = input
    end
    case @input
    when 'w'
      @current_location_index -= 19
    when 'a'
      @current_location_index -= 1
    when 's'
      @current_location_index += 19
    when 'd'
      @current_location_index += 1
    end
  end

  # Finds former location and deletes the snake. Spawns snake to new location.
  def move(board)
    form_loc = board.layout.index {|tile| tile.content == self}
    board.layout[form_loc].revert_content
    board.layout[@current_location_index].change_content(self, @head_display)
  end

  def dies?(new_location)
     @alive = false if new_location.content_display.include?("*")
  end

  def wins?(board)
    @won = true if board.layout.none? {|tile| tile.content_display == "   "}
  end

  def won?
    return @won
  end

  def alive?
    return @alive
  end    
end
