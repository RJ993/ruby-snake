require_relative '../snake_tech/rng_spawner'
require_relative 'board'
require_relative 'tile'

# Object used to represent food.
class Food
  attr_reader :display, :current_location_index

  include RNG_Spawner

  def initialize
    @current_location_index = index_generator
    @display = " O "
  end

  def spawn_gen(board)
    if board.layout[self.current_location_index].content_display != "   "
      until board.layout[self.current_location_index].content_display == "   "
        @current_location_index = index_generator
      end
    end
  end
end