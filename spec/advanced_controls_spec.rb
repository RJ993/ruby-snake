require 'rspec'
require_relative '../lib/game_mechanics'
require_relative '../lib/advanced_controls'

describe AdvancedControls do
  subject(:game) { Game.new }
  describe '#input_receiver' do
    it 'returns w when w is the input' do
      allow($stdin).to receive(:getch).and_return('w')
      expect(game.input_receiver).to eql('w')
    end

    it 'returns a when a is the input' do
      allow($stdin).to receive(:getch).and_return('a')
      expect(game.input_receiver).to eql('a')
    end

    it 'returns s when s is the input' do
      allow($stdin).to receive(:getch).and_return('s')
      expect(game.input_receiver).to eql('s')
    end

    it 'returns d when d is the input' do
      allow($stdin).to receive(:getch).and_return('d')
      expect(game.input_receiver).to eql('d')
    end

    it 'returns nil when anything else (i.e. y) is the input' do
      allow($stdin).to receive(:getch).and_return('y')
      expect(game.input_receiver).to eql(nil)
    end

    it 'returns w when \\e[A is the input' do
      allow($stdin).to receive(:getch).and_return("\e", '[', 'A')
      expect(game.input_receiver).to eql('w')
    end

    it 'returns a when \\e[D is the input' do
      allow($stdin).to receive(:getch).and_return("\e", '[', 'D')
      expect(game.input_receiver).to eql('a')
    end

    it 'returns s when \\e[B is the input' do
      allow($stdin).to receive(:getch).and_return("\e", '[', 'B')
      expect(game.input_receiver).to eql('s')
    end

    it 'returns d when \\e[C is the input' do
      allow($stdin).to receive(:getch).and_return("\e", '[', 'C')
      expect(game.input_receiver).to eql('d')
    end

    it 'raises a SystemExit when Ctrl + C (\\u0003) is the input' do
      allow($stdin).to receive(:getch).and_return("\u0003")
      expect { game.input_receiver }.to output("Game exited successfully.\n").to_stderr.and raise_error(SystemExit)
    end

    it 'raises a SystemExit when Ctrl + X (\\u0018) is the input' do
      allow($stdin).to receive(:getch).and_return("\u0018")
      expect { game.input_receiver }.to output("Game exited successfully.\n").to_stderr.and raise_error(SystemExit)
    end
  end
end
