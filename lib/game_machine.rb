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
end

