# The rule the mod exists for, on the base game's insects: every animal that inherits from BaseInsect.
#
# The patch is applied to an abstract def, so the result each concrete insect ends up with is only known once
# the game has resolved inheritance and every other mod's patches have run. That is the part the offline tests
# (Tests/Audit-*.ps1) cannot reach.
#
# "holds meat" comes first in each scenario for a reason: a bone can only be suppressed if it would have been
# produced, and the bone mods only produce one for an animal that yields meat. Without that line, a creature
# that yields nothing would pass as "no bone" without the mod having done anything.
#
# The fat scenario is Medieval Overhaul's alone: Outland Core has no fat, so it is skipped in the pass "outland"
# with !@mo.
@integration @save
Feature: base game insects give no bone

  Scenario Outline: a base game insect gives no bone
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold meat
    And Insects Have No Bones Renew: the butcher products hold no bone

    Examples:
      | kind       |
      | Megaspider |
      | Megascarab |
      | Spelopede  |

  @mo
  Scenario Outline: a base game insect keeps its fat under Medieval Overhaul
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold fat

    Examples:
      | kind       |
      | Megaspider |
      | Megascarab |
      | Spelopede  |