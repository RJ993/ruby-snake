require 'io/console'

# An assortment of methods used to give the game more advanced controls then just usings "gets" and enter.
module Advanced_Controls
  private

  # Receives and returns inputs. Looks for terminal and non wasd input.
  def input_receiver
    if $stdin.tty?
      new_direction = advanced_getch(0.2)
    else
      no_terminal_error
    end
    new_direction = input_cleaner(new_direction) if %w[w a s d].include?(new_direction) == false
    return new_direction
  end

  def fluid_board
    Gem.win_platform? ? (system "cls") : (system "clear")
    puts "Press the WASD or arrow keys to move. To quit, press Ctrl + C\n "
    puts @board
  end

  # Retrieves other characters if escape sequence key is detected. If other non-acceptable input detected, returns nil.
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

  # Translates arrow-keys to wasd.
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

  # Sends out error message and kills the snake to exit the program.
  def no_terminal_error
    puts "ERROR: If using rdbg debugger, please connect it to a terminal using \"\"useTerminal\": true\". If not... consult Ruby docs."
    @snake.alive = false if self == Game
  end

  # Allows getch to be timed out and for game to be exited gracefully.
  def advanced_getch(timeout = nil, message = false)
    input = nil
    $stdin.timeout = timeout
      begin
        input = $stdin.getch.tap { |char| abort("Game exited successfully.") if char == "\u0003" || char == "\u0018" }
      rescue IO::TimeoutError
       puts "No input, game exited successfully." if message == true
      ensure
        $stdin.timeout = nil
      end
    input
  end
end