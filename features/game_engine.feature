Feature: Game Engine

  In order play a game
  As a player
  I need the game engine to execute a game file

  Scenario: Player begins a game
    Given I load the "test_game_1.gml" file
    When I start the game
    Then I should see "Welcome to Test Game 1"
