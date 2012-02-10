require 'singleton'
class Game; include Singleton
  attr_accessor :intro
end

module GameEngine
  def GameEngine.intro(msg)
    Game.instance.intro = msg 
  end

  def GameEngine.load_game(file_name)
    File.open(file_name) do |f|
      module_eval(f.read)
    end
  end

  def GameEngine.run_game
  end
end
