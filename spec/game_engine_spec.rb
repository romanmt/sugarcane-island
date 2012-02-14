require './lib/game_engine'
require 'tempfile'

def game_file(contents)
  file = Tempfile.new('game')
  file.write(contents)
  file.rewind
  file
end

def load_game(engine, file_contents)
  file = game_file(file_contents)
  engine.load_game(file)
  file.close; file.unlink
end

describe GameEngine do
  let(:input) { double('input') }
  let(:output) { double('output') }
  let(:engine) { GameEngine.new(input, output) }

  describe '.run_game' do
    context 'that has start and finish' do
      it 'waits for the user to hit enter' do 
        load_game(engine, 'start "my game", :next
                           finish :next, "whoo"')
        output.should_receive(:puts).twice
        input.should_receive(:gets)
        engine.run_game
      end
    end

    context 'that has a start, step and finish' do
      it 'waits for enter 2 times' do
        load_game(engine, 'start "starting", :first_step
                           step :first_step, "first step", :happy_ending
                           finish :happy_ending, "Thanks for playing"')
        output.should_receive(:puts).exactly(3).times
        input.should_receive(:gets).twice
        engine.run_game
      end
    end

  end

  describe '.load_game' do
    
    context 'that has a start' do
      it 'stores the start and next step' do
        load_game(engine, 'start "starting game", :next_step')
        Game.instance.steps[:start].should eql({text: "starting game", next: :next_step})
      end
    end

    context 'that has a step' do
      it 'stores the step, text and next step' do
        load_game(engine, 'step :first, "the game is on", :second')
        Game.instance.steps[:first].should eql({text: 'the game is on', next: :second})
      end
    end

    context 'that has a choose' do
      it 'stores the step, text and next step options' do
        load_game(engine, 'choose :diet_or_regular, "would you like diet or regular?", :diet, :regular')
        Game.instance.steps[:diet_or_regular].should eql(
          {text: 'would you like diet or regular?', next: [:diet, :regular]}
        )
      end
    end

    context 'that has a finish' do
      it 'stores the step, text and sets next step to :finish' do
        load_game(engine, 'finish :you_died, "You died, play again."')
        Game.instance.steps[:you_died].should eql({text: "You died, play again.", next: :finish})
      end
    end
  end

end

