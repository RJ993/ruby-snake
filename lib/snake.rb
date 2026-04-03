require_relative 'board'
require_relative 'tile'

# A collection of methods to form and move the snake.
class Snake
  attr_accessor :direction, :alive, :current_location_index, :head_display, :input

  def initialize
    @name = "Demo Dummy"
    @head_display = "##D"
    @input = 'a'
    @alive = true
    @current_location_index = index_generator
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
    board.layout[@current_location_index].change_content(self, self.head_display)
  end

  def dies?(new_location)
     @alive = false if new_location.content_display.include?("*")
  end

  def alive?
    return @alive
  end

  private

  # Generates a random index within the borders of the "grid".
  def index_generator
    location = rand(19..303)
    while location % 19 == 0 || location % 19 == 18
      location = rand(19..303)
    end
    location
  end
    
end
