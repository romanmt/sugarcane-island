require 'singleton'
class Game; include Singleton
  attr_reader :steps

  def step(key, text, next_step)
    @steps = {} if @steps.nil?   
    @steps[key] = {text: text, next: next_step}
  end
end

module GameEngine
  def GameEngine.start(text, next_step)
    Game.instance.step(:start, text, next_step)
  end

  def GameEngine.step(key, text, next_step)
    Game.instance.step(key, text, next_step)
  end

  def GameEngine.choose(key, text, *next_steps)
    Game.instance.step(key, text, next_steps)
  end

  def GameEngine.finish(key, text)
    Game.instance.step(key, text, :finish)
  end

  def GameEngine.load_game(file_name)
    File.open(file_name) do |f|
      module_eval(f.read)
    end
  end

  def GameEngine.run_game(output)
    output.puts Game.instance.steps[:start][:text]
    output.puts "Thanks for playing"
  end
end
