require 'singleton'
class Game; include Singleton
  attr_reader :steps

  def clear
    @steps = {}
  end
 
  def step(key, text, next_step)
    @steps[key] = {text: text, next: next_step}
  end
end

class GameEngine
  def initialize(input, output)
    @input = input
    @output = output
  end
  
  def start(text, next_step)
    Game.instance.step(:start, text, next_step)
  end

  def step(key, text, next_step)
    Game.instance.step(key, text, next_step)
  end

  def choose(key, text, *next_steps)
    Game.instance.step(key, text, next_steps)
  end

  def finish(key, text)
    Game.instance.step(key, text, :finish)
  end

  def load_game(file_name)
    Game.instance.clear
    File.open(file_name) do |f|
      instance_eval(f.read)
    end
  end

  def run_game(step = :start)
    @output.puts Game.instance.steps[step][:text]
    if (nstep = next_step(step)) != :finish
      run_game(nstep)
    end
  end

private
  def next_step(step)
    unless (s = Game.instance.steps[step][:next]) == :finish
      if s.respond_to?(:count) 
        s.each_with_index do | item, index |
          @output.puts "#{index}. #{item}"
        end
        i = @input.gets.chomp.to_i
        s = s[i-1]
      else
        @input.gets
      end
    end
    s
  end
end
