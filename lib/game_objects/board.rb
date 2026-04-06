require_relative "tile"

# Where the game takes place.
class Board
  attr_reader :layout

  def initialize
    @layout = board_creator
  end

  def to_s
    board_string=""
      layout.each_with_index do |tile, index|
      if (index + 1) % 19 == 0
        board_string += "#{tile}\n"
      else
        board_string += "#{tile}"
      end
    end
    board_string
  end


  private

  # Creates a 17 by 19 (15 by 17 with some "walls") grid.
  def board_creator
    board_array = []
      19.times {board_array.push(Tile.new("*  "))}
      15.times do
        board_array.push(Tile.new("*  "))
        17.times do
        board_array.push(Tile.new("   "))
        end
        board_array.push(Tile.new("*"))
      end
      19.times {board_array.push(Tile.new("*  "))}
    board_array
  end
end