require 'rspec'
require_relative '../lib/game_mechanics'
require_relative '../lib/game_objects/snake'

describe Game do
  subject(:game) { described_class.new }
  describe '#play' do
    context 'when snake being alive is false' do
      it 'ends the game loop' do
        game.snake.alive = false
        expect(game).to receive(:input_receiver).exactly(0).times
        game.play
      end
    end
    context 'when snake winning is true' do
      it 'ends the game loop' do
        game.snake.won = true
        expect(game).to receive(:input_receiver).exactly(0).times
        game.play
      end
    end
  end
end
