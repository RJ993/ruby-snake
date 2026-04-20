require 'rspec'
require_relative '../../lib/game_objects/food'
require_relative '../../lib/game_objects/board'
require_relative '../../lib/game_objects/tile'

describe Food do
  subject(:food) { described_class.new }
  subject(:board) { Board.new }
  describe '#spawn_in' do
    context 'when the board has food' do
      before do
        board.layout[food.current_location_index].change_content(food, food.display)
      end
      it 'will return immediately without changing the food\'s index' do
        expect { food.spawn_in(board) }.to_not change { food.current_location_index } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
      it 'will return immediately without changing the tile\'s state' do
        expect(board.layout[food.current_location_index]).to receive(:change_content).exactly(0).times
        food.spawn_in(board)
      end
    end
    context 'when the board is filled with snake parts' do
      before do
        board.layout.each do |tile|
          tile.change_content(nil, ' # ') if tile.content_display == '   '
        end
      end
      it 'will return immediately without changing the food\'s index' do
        expect { food.spawn_in(board) }.to_not change { food.current_location_index } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
      it 'will return immediately without changing the tile state' do
        expect(board.layout[food.current_location_index]).to receive(:change_content).exactly(0).times
        food.spawn_in(board)
      end
    end
    context 'when the snake has eaten the food' do
      before do
        board.layout[food.current_location_index].change_content(nil, ' 0 ')
      end
      it 'will change the food\'s index' do
        expect { food.spawn_in(board) }.to change { food.current_location_index } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
      it 'will change another tile\'s content' do
        food.spawn_in(board)
        expect(board.layout.any? { |tile| tile.content_display == ' O ' }).to be true
      end
    end
    context 'when the board has nothing' do
      it 'will not change the food\'s index' do
        expect { food.spawn_in(board) }.to_not change { food.current_location_index } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
      it 'will change the tile\'s content' do
        expect(board.layout[food.current_location_index]).to receive(:change_content).exactly(1).time
        food.spawn_in(board)
      end
    end
  end
end
