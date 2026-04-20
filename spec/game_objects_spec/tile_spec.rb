require 'rspec'
require_relative '../../lib/game_objects/tile'

describe Tile do
  subject(:tile) { described_class.new('   ') }
  describe '#change_content' do
    context 'when tile is empty' do
      it 'changes from a blank space to a non-blank space' do
        expect { tile.change_content(nil, ' 0 ') }.to change { tile.content_display }.to(' 0 ')
      end
    end
    context 'when tile is not empty' do
      it 'changes from a non-blank space to a space with another symbol' do
        expect { tile.change_content(nil, ' # ') }.to change { tile.content_display }.to(' # ')
      end
    end
  end

  describe '#revert_content' do
    context 'when tile is not empty' do
      it 'changes display back to it\'s initial state' do
        tile.content_display = ' # '
        expect { tile.revert_content }.to change { tile.content_display }.to('   ')
      end
    end
  end
end
