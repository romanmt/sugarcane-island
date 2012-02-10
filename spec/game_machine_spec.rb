require './lib/game_machine'

describe GameMachine do 
  describe '.start' do
    it 'lists the available games' do
      game_files = ['my_game.gml']
      output = double('output')
      output.should_receive(:puts).with('A. My Game')
      gm = GameMachine.new(output)
      gm.start(game_files)
    end
  end

end
