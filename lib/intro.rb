require_relative 'game_mechanics'
require_relative 'advanced_controls'

# Intro of the game.
class Introduction
  include AdvancedControls
  def initialize
    intro_ascii_art
    input = advanced_getch(60, true)
    return if input.nil?

    @game = Game.new
    @game.play
  end

  def intro_ascii_art
    puts " \n "
    puts '###############################################################'
    puts '###############################################################'
    puts '##                                                           ##'
    puts '##   ########   #     #         #         #    #   ########  ##'
    puts '##  ##          ##    #        ###        #  #     #         ##'
    puts '##    #         # #   #       #   #       ##       #         ##'
    puts '##      #       #  #  #      #     #      # #      ######    ##'
    puts '##        #     #   # #     #########     #  #     #         ##'
    puts '##         ##   #    ##    #         #    #   #    #         ##'
    puts '##  ########    #     #   #           #   #    #   ########  ##'
    puts '##  _______________________________________________________  ##'
    puts '############### Press any key to play the game. ###############'
    puts '###############################################################'
  end
end
