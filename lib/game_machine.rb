require './lib/game_engine'
class GameMachine 
  def initialize(output)
    @output = output
  end

  def titleize(name)
    File.basename(name, '.gml').sub('_', ' ').gsub(/\b\w/){$&.upcase}
  end

  def start(game_files)
    @output.puts("A. #{titleize(game_files.first)}")
  end
  
  def main
    ge = GameEngine.new(STDIN, STDOUT)
    ge.load_game('./game_files/example.gml')
    ge.run_game
  end
end

