# The controls: animals this mod must not touch. A muffalo and a cow still yield the bone mod's bone, in the
# same pass, so a "no bone" elsewhere means the patch worked and not that the bone mod did nothing.
#
# This is also the check on how a bone is recognised: the step takes any product whose defName contains "Bone"
# (see ButcherSteps.cs). If Outland Core names its bone otherwise, it is these scenarios that go red first.
@integration @save
Feature: animals the mod does not target still give bone

  Scenario Outline: an ordinary animal still gives the bone mod's bone
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold meat
    And Insects Have No Bones Renew: the butcher products hold a bone

    Examples:
      | kind    |
      | Muffalo |
      | Cow     |

  @mo
  Scenario Outline: an ordinary animal still gives fat under Medieval Overhaul
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold fat

    Examples:
      | kind    |
      | Muffalo |
      | Cow     |