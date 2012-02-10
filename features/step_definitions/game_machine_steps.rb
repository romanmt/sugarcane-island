require './lib/game_machine'
require './features/output'

Given /^a game file named "([^"]*)"$/ do |file_name|
  @game_files = [file_name]
end

When /^I start the game machine$/ do
  gm = GameMachine.new(output)
  gm.start(@game_files)
end

Then /^I should see "([^"]*)"$/ do |expected|
  output.messages.first.should include(expected)
end
