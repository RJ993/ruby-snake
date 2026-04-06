# Spawns the snake and food.
module RNG_Spawner
  
  private

  # Generates a random index within the borders of the "grid".
  def index_generator
    location = rand(19..303)
    while location % 19 == 0 || location % 19 == 18
      location = rand(19..303)
    end
    location
  end
end