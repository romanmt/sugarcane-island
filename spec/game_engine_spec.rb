require './lib/game_engine'
require 'tempfile'

def game_file(contents)
  file = Tempfile.new('game')
  file.write(contents)
  file.rewind
  file
end

describe GameEngine do
  describe '.load_game' do
    after(:each) {@file.close; @file.unlink}
    
    context 'when the game has an intro' do

      it 'stores the intro message' do
        @file = game_file('intro "it\'s a game"')
        GameEngine.load_game(@file.path)
        Game.instance.intro.should eql('it\'s a game')
      end
    end

    context 'when the game has a tell step' do
      it 'stores the tell as a step'
    end
  end

end

