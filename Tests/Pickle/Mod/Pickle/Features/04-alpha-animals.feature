# Hiroyan's Alpha Animals lists, sampled once per way a creature is reached:
#   AA_Animalisk   inherits AA_AlphaBaseInsect
#   AA_BlackSpider inherits BaseInsect2
#   AA_AngelMoth   named in the "no bone, fat kept" list
#   AA_Bumbledrone named in the same list, and not an Insectoid by inheritance
#   AA_Aerofleet   named in the "neither bone nor fat" list
#   AA_Mantrap     named in the same list
#
# AA_Agaripawn and AA_GreenGoo were the first choice for the last two rows and both failed on the "holds
# meat" precondition (mo-0220807, 2026-09-29): Agaripawn's CompProperties_AnimalProduct replaces its
# butcher yield with AA_AgariluxRawFungus instead of adding to it, and GreenGoo yields nothing at all.
# Replaced with two creatures of the same list that carry no such comp and inherit AnimalThingBase
# directly, the same shape as AA_Aerofleet, which already produced meat in the same run. Not replayed yet.
#
# Played when Alpha Animals is staged; skipped by requirement in the passes without it, where it counts as
# skipped and not as passed. The fat scenarios are Medieval Overhaul's alone (!@mo in the pass "outland").
@requires:sarg.alphaanimals @integration @save
Feature: Alpha Animals creatures give no bone

  Scenario Outline: an Alpha Animals creature gives no bone
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold meat
    And Insects Have No Bones Renew: the butcher products hold no bone

    Examples:
      | kind           |
      | AA_Animalisk   |
      | AA_BlackSpider |
      | AA_AngelMoth   |
      | AA_Bumbledrone |
      | AA_Aerofleet   |
      | AA_Mantrap     |

  @mo
  Scenario Outline: a creature of the "no fat" list gives no fat under Medieval Overhaul
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold meat
    And Insects Have No Bones Renew: the butcher products hold no fat

    Examples:
      | kind         |
      | AA_Aerofleet |
      | AA_Mantrap   |

  @mo
  Scenario Outline: a creature of the "fat kept" list keeps its fat under Medieval Overhaul
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold fat

    Examples:
      | kind           |
      | AA_Animalisk   |
      | AA_BlackSpider |
      | AA_AngelMoth   |
      | AA_Bumbledrone |