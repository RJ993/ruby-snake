require 'rspec'
require_relative '../../../lib/game_objects/snake_parts/snake_head'

describe SnakeHead do
  subject(:head) { described_class.new }
  describe '#new_location?' do
    context 'when input is nil' do
      it 'doesn\'t change input' do
        expect { head.new_location?(nil) }.to_not change { head.input } # rubocop:disable Lint/AmbiguousBlockAssociation
      end
    end

    context 'when input is not nil' do
      it 'changes input when any input is registered' do
        expect { head.new_location?('a') }.to change { head.input }.to('a')
      end

      it 'changes current index by minus 1 when a is pressed' do
        expect { head.new_location?('a') }.to change { head.current_location_index }.from(153).to(152)
      end

      it 'changes current index by plus 19 when s is pressed' do
        expect { head.new_location?('s') }.to change { head.current_location_index }.from(153).to(172)
      end

      it 'changes current index by minus 19 when w is pressed' do
        expect { head.new_location?('w') }.to change { head.current_location_index }.from(153).to(134)
      end

      it 'changes current index by plus 1 when d is pressed' do
        expect { head.new_location?('d') }.to change { head.current_location_index }.from(153).to(154)
      end
    end
  end
end
