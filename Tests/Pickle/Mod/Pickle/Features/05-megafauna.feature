# The three arthropods of Megafauna, which descend from AnimalThingBase and are reached by no other rule.
# Played when Megafauna is staged; skipped by requirement otherwise. The fat scenario is Medieval Overhaul's
# alone (!@mo in the pass "outland").
@requires:spino.megafauna @integration @save
Feature: Megafauna arthropods give no bone

  Scenario Outline: a Megafauna arthropod gives no bone
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold meat
    And Insects Have No Bones Renew: the butcher products hold no bone

    Examples:
      | kind            |
      | Arthropleura    |
      | Meganeura       |
      | Pulmonoscorpius |

  @mo
  Scenario Outline: a Megafauna arthropod keeps its fat under Medieval Overhaul
    Given the save "test-colony" is loaded
    When Insects Have No Bones Renew: I butcher a fresh adult "<kind>"
    Then Insects Have No Bones Renew: the butcher products hold fat

    Examples:
      | kind            |
      | Arthropleura    |
      | Meganeura       |
      | Pulmonoscorpius |