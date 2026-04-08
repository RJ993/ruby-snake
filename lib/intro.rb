require_relative 'game-mechanics'
require_relative 'snake_tech/advanced_controls'

class Introduction
  include Advanced_Controls
  def initialize
    intro_ascii_art
    input = advanced_getch(60, true)
    if input != nil
      @game = Game.new
      @game.play
    end
  end

  def intro_ascii_art
    puts " \n "
    puts "###############################################################"
    puts "###############################################################"
    puts "##                                                           ##"
    puts "##  #########   #     #         #         #    #   ########  ##"
    puts "##  #           ##    #        ###        #  #     #         ##"
    puts "##    #         # #   #       #   #       ##       #         ##"
    puts "##      #       #  #  #      #     #      # #      ######    ##"
    puts "##        #     #   # #     #########     #  #     #         ##"
    puts "##          #   #    ##    #         #    #   #    #         ##"
    puts "##  #########   #     #   #           #   #    #   ########  ##"
    puts "##  _______________________________________________________  ##"
    puts "############### Press any key to play the game. ###############"
    puts "###############################################################"
  end
end