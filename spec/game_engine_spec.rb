require './lib/game_engine'
require 'tempfile'

def game_file(contents)
  file = Tempfile.new('game')
  file.write(contents)
  file.rewind
  file
end

def load_game(file_contents)
  file = game_file(file_contents)
  GameEngine.load_game(file)
  file.close; file.unlink
end

describe GameEngine do
  describe '.run_game' do
  end

  describe '.load_game' do
    
    context 'when the game has a start' do
      it 'stores the start and next step' do
        load_game('start "starting game", :next_step')
        Game.instance.steps[:start].should eql({text: "starting game", next: :next_step})
      end
    end

    context 'when the game has a step' do
      it 'stores the step, text and next step' do
        load_game('step :first, "the game is on", :second')
        Game.instance.steps[:first].should eql({text: 'the game is on', next: :second})
      end
    end

    context 'when the game has a choose' do
      it 'stores the step, text and next step options' do
        load_game('choose :diet_or_regular, "would you like diet or regular?", :diet, :regular')
        Game.instance.steps[:diet_or_regular].should eql(
          {text: 'would you like diet or regular?', next: [:diet, :regular]}
        )
      end
    end

    context 'when the game has a finish' do
      it 'stores the step, text and sets next step to :finish' do
        load_game('finish :you_died, "You died, play again."')
        Game.instance.steps[:you_died].should eql({text: "You died, play again.", next: :finish})
      end
    end
  end

end

