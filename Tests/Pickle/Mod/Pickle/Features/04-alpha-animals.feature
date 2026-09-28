# Hiroyan's Alpha Animals lists, sampled once per way a creature is reached:
#   AA_Animalisk   inherits AA_AlphaBaseInsect
#   AA_BlackSpider inherits BaseInsect2
#   AA_AngelMoth   named in the "no bone, fat kept" list
#   AA_Agaripawn   named in the same list, and not an Insectoid
#   AA_Aerofleet   named in the "neither bone nor fat" list
#   AA_GreenGoo    named in the same list
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
      | AA_Agaripawn   |
      | AA_Aerofleet   |
      | AA_GreenGoo    |

  @mo
  Scenario Outline: a creature of the "no fat" list gives no fat under Medieval Overhaul
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold meat
    And Insects Have No Bones Renew: the butcher products hold no fat

    Examples:
      | kind        |
      | AA_Aerofleet |
      | AA_GreenGoo |

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
      | AA_Agaripawn   |