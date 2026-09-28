# The loaded-game half of what a person would read from Player.log, and the only scenario every pass but the
# incompatibility one plays.
#
# No save is loaded, on purpose. The errors this mod can produce are logged while the defs load, before any
# scenario is armed, and Pickle's own "no errors were logged" only sees what is logged after it is armed, so it
# would pass on a mod that failed to load. The audit step of PickleTools reads the game's own log from the start
# of the game instead. It is staged by every pass map.
#
# Not played in the pass "incompat-original", where the original mod logs an error on purpose (feature 07).
Feature: the mod loads clean

  Scenario: the mod is loaded and nothing it owns was logged as a problem
    Given the main menu is open
    Then mod "nelim.insectshavenobones" is loaded
    And Nelim's Pickle Tools: the load of the mod "nelim.insectshavenobones" is clean