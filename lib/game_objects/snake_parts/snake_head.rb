# Head of the snake. Tracks input
class SnakeHead
  attr_accessor :display, :input, :next_part, :current_location_index, :former_location_index

  def initialize
    @display = ' 0 '
    @input = 'd'
    @next_part = nil
    @current_location_index = 153
    @former_location_index = nil
  end

  # Shifts the index to move a certain direction.
  def new_location?(input)
    @input = input unless input.nil?
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
end
