# A pass of its own: this file plays only when the original mod (Workshop 2041677515) is staged, with
#
#   Submit-PickleRun.ps1 -Mod InsectsHaveNoBonesRenew -DepMap wsl-deps.incompat-original.map -Filter '07-original-mod-incompatibility'
#
# and is skipped by requirement in every other pass, where it counts as skipped and not as passed.
#
# About.xml declares the two incompatible because they patch the same defs. RimWorld does not refuse that. What
# the log shows is the original's own defect, the reason this port exists: its Medieval Overhaul patch names
# DankPyon.ButcherProperties, a class Medieval Overhaul renamed in its 1.5 build, and the game reports the class
# it cannot find. That error is asserted, and it goes red the day the original is updated, which is the day the
# incompatibleWith line can be reconsidered. It also proves the original's patches were read beside ours.
#
# It starts from the main menu, not a save: the patches are read while the game loads. @allow-errors stops the
# error it is about from failing the scenario on its own account.
@requires:sirmashedpotato.insectshavenobones @allow-errors
Feature: the declared incompatibility with the original mod is still true

  Scenario: the original mod loads beside this one and still names the class Medieval Overhaul renamed
    Given the main menu is open
    Then mod "sirmashedpotato.insectshavenobones" is loaded
    And mod "nelim.insectshavenobones" is loaded
    And mod "dankpyon.medieval.overhaul" is loaded
    And Insects Have No Bones Renew: an error or a warning was logged naming "DankPyon.ButcherProperties"