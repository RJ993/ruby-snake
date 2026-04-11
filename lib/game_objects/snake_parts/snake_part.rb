# Parts of the snake
class SnakePart
  attr_accessor :display, :next_part, :current_location_index, :former_location_index

  def initialize
    @display = ' # '
    @next_part = nil
    @current_location_index = nil
    @former_location_index = nil
  end
end
