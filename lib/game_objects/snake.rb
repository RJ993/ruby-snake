require_relative 'board'
require_relative 'tile'
require_relative 'snake_parts/snake_head'
require_relative 'snake_parts/snake_part'

# A linked list structure used to represent a snake.
class Snake
  attr_accessor :alive, :won, :head

  def initialize
    @head = SnakeHead.new
    @alive = true
    @won = false
    3.times do
      grow
      slither
      @head.current_location_index += 1
    end
  end

  def dies?(new_location)
    @alive = false if new_location.content_display.include?('*') || new_location.content_display.include?('#')
  end

  def wins?(board)
    @won = true if board.layout.none? { |tile| tile.content_display == '   ' } && board.layout.none? do |tile|
      tile.content_display == ' O '
    end
  end

  def won?
    @won
  end

  def alive?
    @alive
  end

  # Uses recursion to find the last part of the snake and add another part onto it.
  def grow(part = @head)
    return if part.nil?

    if !part.next_part.nil?
      grow(part.next_part)
    else
      part.next_part = SnakePart.new
    end
  end

  # Uses recursion to push indexes to the next parts.
  def slither(part = @head)
    return if part.nil?

    part.former_location_index = part.current_location_index
    return if part.next_part.nil?

    slither(part.next_part)
    part.next_part.current_location_index = part.current_location_index
  end

  # Shifts snake parts to the index of the part in front of it using recursion.
  def move(board, part = @head)
    return if part.nil?

    if !part.next_part.nil?
      part.next_part.current_location_index = part.former_location_index if part.next_part.current_location_index.nil?
      move(board, part.next_part)
    else
      form_loc = board.layout.index { |tile| tile.content == part }
      board.layout[form_loc].revert_content unless form_loc.nil?
    end
    dies?(board.layout[@head.current_location_index]) if part == @head
    board.layout[part.current_location_index].change_content(part, part.display)
  end
end
