Feature: Game Selector

  In order to know which games I can play
  I need to be presented a list of games
  So that I can select one

  Scenario: Game Machine lists available games
    Given a game file named "my_game.gml" 
    When I start the game machine
    Then I should see "A. My Game"

