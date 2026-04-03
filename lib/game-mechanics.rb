require 'io/wait'
require 'io/console'
require_relative 'snake'
require_relative 'board'
require_relative 'tile'

# Collection of methods needed to have the game running.
class Game
  def initialize
    @snake = Snake.new
    @board = Board.new
  end

  # While the snake is alive, an input is received and the snake moves.
  def play
    @board.layout[@snake.current_location_index].change_content(@snake, @snake.head_display)
    while @snake.alive? == true
      fluid_board
      new_direction = input_receiver
      @snake.new_location?(new_direction)
      @snake.dies?(@board.layout[@snake.current_location_index])
      break if @snake.alive? == false
      @snake.move(@board)
    end
  end

  private

  # Receives and returns inputs. Looks for non-desirable inputs and/or Ctrl+C in the middle.
  def input_receiver
    if $stdin.tty?
      new_direction = advanced_getch
    else
      no_terminal_error
    end
    new_direction = input_cleaner(new_direction) if new_direction != %w[w a s d]
    return new_direction
  end

  def fluid_board
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts @board
  end

  def input_cleaner(input)
    if input == "\e"
      2.times do
        input += $stdin.getch
      end
      input = arrow_key_translator(input)
    else
      input = nil
    end
    input
  end

  # Translates arrow-keys to WASD and any other input to nil.
  def arrow_key_translator(char)
    case char
      when "\e[A"
        char = 'w'
      when "\e[D"
        char = 'a'
      when "\e[B"
        char = 's'
      when "\e[C"
        char = 'd'
    end 
    char
  end

  def no_terminal_error
    puts "ERROR: If using rdbg debugger, please connect it to a terminal using \"\"useTerminal\": true\". If not... consult Ruby docs."
    @snake.alive = false
  end

  def advanced_getch
    new_direction = nil
    $stdin.timeout = 2
      begin
        new_direction = $stdin.getch.tap { |char| abort("Game exited successfully") if char == "\u0003" || char == "\u0018" }
      rescue IO::TimeoutError
      ensure
        $stdin.timeout = nil
      end
    new_direction
  end
end