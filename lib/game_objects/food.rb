require_relative '../snake_tech/rng_spawner'

# Object used to represent food.
class Food
  attr_reader :display

  include RNG_Spawner

  def initialize
    @location = nil
    @display = "O"
  end
end