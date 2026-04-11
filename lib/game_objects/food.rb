require_relative 'board'
require_relative 'tile'

# Object used to represent food.
class Food
  attr_reader :display, :current_location_index

  def initialize
    @current_location_index = 166
    @display = " O "
  end

  # Spawns the food in provided that there aren't any already.
  def spawn_in(board)
    if board.layout.none? {|tile| tile.content_display.include?("O") }
      self.spawn_gen(board) if board.layout.none? {|tile| tile.content_display == "   "} == false
      board.layout[@current_location_index].change_content(self, @display)
    end
  end

  private

  # Generates a spawn index for the food. Assures that it does spawn on blank tiles.
  def spawn_gen(board)
    if board.layout[@current_location_index].content_display != "   "
      until board.layout[@current_location_index].content_display == "   "
        @current_location_index = index_generator
      end
    end
  end

  # Generates a random index within the borders of the "grid".
  def index_generator
    location = rand(19..303)
    while location % 19 == 0 || location % 19 == 18
      location = rand(19..303)
    end
    location
  end
end