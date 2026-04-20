require 'rspec'
require_relative '../../lib/game_objects/snake'
require_relative '../../lib/game_objects/board'
require_relative '../../lib/game_objects/tile'
require_relative '../../lib/game_objects/snake_parts/snake_head'
require_relative '../../lib/game_objects/snake_parts/snake_part'

describe Snake do
  subject(:snake) { described_class.new }
  subject(:board) { Board.new }
  describe '#dies?' do
    context 'when snake head is moving' do
      it 'dies when it hits it\'s other parts.' do
        new_location = Tile.new(' # ')
        expect { snake.dies?(new_location) }.to change { snake.alive }.to be false
      end
      it 'dies when it hits a wall.' do
        new_location = Tile.new(' * ')
        expect { snake.dies?(new_location) }.to change { snake.alive }.to be false
      end
      it 'does not die when going to an open space.' do
        new_location = Tile.new('   ')
        expect { snake.dies?(new_location) }.to_not change { snake.alive } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
    end
  end

  describe '#wins?' do
    context 'when the board is blank and has food' do
      it 'doesn\'t declare the snake the winner' do
        board.layout[166].change_content(nil, ' O ')
        expect { snake.wins?(board) }.to_not change { snake.won } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
    end
    context 'when the board is not blank but still has food' do
      before do
        board.layout[166].change_content(nil, ' O ')
        board.layout.each do |tile|
          tile.change_content(nil, ' # ') if tile.content_display == '   '
        end
      end
      it 'doesn\'t declare the snake the winner' do
        expect { snake.wins?(board) }.to_not change { snake.won } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
    end
    context 'when the board is not blank and has no food' do
      before do
        board.layout.each do |tile|
          tile.change_content(nil, ' # ') if tile.content_display == '   '
        end
      end
      it 'declares the snake the winner' do
        expect { snake.wins?(board) }.to change { snake.won }.to be true
      end
    end
  end

  describe '#grow' do
    it 'changes the last part\'s next node from nil to another part.' do
      expect { snake.grow }.to change { snake.head.next_part.next_part.next_part.next_part }.from(nil).to(SnakePart)
    end
  end

  describe '#slither' do
    it 'changes the head\'s next part\'s current index to the head\'s former location.' do
      expect { snake.slither }.to change { snake.head.next_part.current_location_index }.from(155).to(156)
    end
    it 'changes the head\'s next part\'s former index variable to it\'s previous current index.' do
      expect { snake.slither }.to change { snake.head.next_part.former_location_index }.from(154).to(155)
    end
  end

  describe '#move' do
    context 'when there is no new snake part' do
      it 'spawns the head on it\'s current index 156' do
        expect { snake.move(board) }.to change { board.layout[156].content_display }.from('   ').to(' 0 ')
      end
      it 'spawns the last part on it\'s current index 153' do
        expect { snake.move(board) }.to change { board.layout[153].content_display }.from('   ').to(' # ')
      end
    end
    context 'when there is a new snake part' do
      before do
        snake.slither
        snake.grow
        snake.head.current_location_index += 1
      end
      it 'changes the new last part\'s current location index from nil to 153' do
        expect { snake.move(board) }.to change {
          snake.head.next_part.next_part.next_part.next_part.current_location_index
        }.from(nil).to(153)
      end
      it 'spawns the head on it\'s current index 157' do
        expect { snake.move(board) }.to change { board.layout[157].content_display }.from('   ').to(' 0 ')
      end
      it 'spawns the new last part on it\'s current index 153' do
        expect { snake.move(board) }.to change { board.layout[153].content_display }.from('   ').to(' # ')
      end
    end
  end
end
