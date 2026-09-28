# Played only in the pass "minimal", where neither Medieval Overhaul nor Outland Core is loaded: both folders of
# the mod stay inactive, so nothing is patched. What is asserted is the absence, and that a vanilla insect
# still butchers into meat with the mod loaded.
#
# It asserts nothing about bones: with no bone mod there is no bone to suppress, so such an assertion would pass
# on a mod that did nothing. That is why the butchering scenarios of features 03 to 06 carry @integration and
# are left out of this pass.
@minimal-only
Feature: with no integration loaded the mod changes nothing

  Scenario: no integration and no animal mod is loaded
    Given the main menu is open
    Then mod "dankpyon.medieval.overhaul" is not loaded
    And mod "neronix17.outland.core" is not loaded
    And mod "sarg.alphaanimals" is not loaded
    And mod "spino.megafauna" is not loaded

  @save
  Scenario: a vanilla insect still butchers into meat
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "Megaspider"
    Then Insects Have No Bones Renew: the butcher products hold meat