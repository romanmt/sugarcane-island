require './lib/game_engine'
require './features/output'

Given /^I load the "([^"]*)" file$/ do |game_file|
  GameEngine.load("fixtures/#{game_file}")
end

When /^I start the game$/ do
  GameEngine.run_game
end

