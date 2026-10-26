# Workshop gallery, "The day the giants came to the fence": one day in Nelim's Sanctuary, five pictures, dawn to dusk (PUBLICATION.md, "Screenshots" and
# "Gallery subtitles"). Written 2026-10-15 from that plan; NOT PLAYED YET. Every cell below was read on the places' documentation (SanctuaryBacklot
# docs/SANCTUAIRE-LIEUX.md and SANCTUAIRE-CASES.md), not on a photograph: each picture is opened and read after the run, and what is wrong is recomposed.
#
# 1. enclosure-south, 06:00: Nelim at the gate, an Arthropleura and a Megascarab at the fence, both turned to the camera (South).
# 2. gravel-yard, 09:00: a dead Megaspider on the gravel, Nelim beside it. The hunt is over.
# 3. barn, 11:00: the butcher table, the carcass beside it, Nelim at the table.
# 4. exhibition-zone, 14:00: the products of a butchered Megaspider, one per cell, on the orange carpet: meat, fat, leather, no bone. Nelim behind the row.
# 5. fire-pit, 19:00: Nelim by the hearth, a lit Stick Lantern, an Alpha Animals AA_Aerofleet resting near, the hall's thrumbo left where it stands.
#
# NELIM: the fixture gives her dark brown eyes. Hair, clothes and face are set per scene: dark ponytail and rust shirt with an olive duster (1), the shirt alone
# (2, 3, 4), a bob and a cream shirt at the hearth (5). The first `wears` undresses her, so the trousers are put back every time. Face: her own (two brows, smirk,
# blink); no mouth or lid step, they are not proven without the experimental facial mods.
# The scenes need Medieval Overhaul for the fat of picture 4 (pass "gallery" loads it). Played only where the Sanctuary is staged; skipped elsewhere.
@review @requires:nelim.sanctuarybacklot @requires:nelim.pickletools.screenshotstudio @requires:nelim.pickletools.camerazoom @requires:nelim.pickletools.stagedecor @requires:nelim.pickletools.colonistrace @requires:spino.megafauna @requires:sarg.alphaanimals @requires:dankpyon.medieval.overhaul
Feature: Workshop gallery

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And I close all dialogs
    And I set the weather to "Clear"

  Scenario: 1 dawn, the giants are at the fence
    Given I set the hour to 6
    And Nelim's Sanctuary: the sanctuary "enclosure-south" is emptied
    And Nelim's Sanctuary: the animals are removed from the sanctuary "enclosure-south"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (168, 84, 48)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Duster" dyed rgb (96, 104, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: "Nelim" stands at (150, 214) facing East
    And Nelim's Pickle Tools: an adult animal of kind "Arthropleura" named "Rhea" is spawned at (156, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Megascarab" named "Scara" is spawned at (159, 216)
    And Nelim's Pickle Tools: the animal "Rhea" stands at (156, 214) facing South
    And Nelim's Pickle Tools: the animal "Scara" stands at (159, 216) facing South
    When Nelim's Pickle Tools: I frame the area centred on (154, 214) at root size 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 30 ticks pass
    Then I take a screenshot "gallery-1-at-the-gate"

  Scenario: 2 morning, the hunt is over
    Given I set the hour to 9
    And Nelim's Sanctuary: the sanctuary "gravel-yard" is emptied
    And Nelim's Sanctuary: the animals are removed from the sanctuary "gravel-yard"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (168, 84, 48)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Insects Have No Bones Renew: a dead adult "Megaspider" lies at (171, 143)
    And Nelim's Pickle Tools: "Nelim" stands at (167, 143) facing East
    When Nelim's Pickle Tools: I frame the area centred on (169, 143) at root size 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 30 ticks pass
    Then I take a screenshot "gallery-2-the-carcass"

  Scenario: 3 late morning, the butcher table
    Given I set the hour to 11
    And Nelim's Pickle Tools: the area from (190, 232) to (198, 242) is emptied
    And Nelim's Pickle Tools: the animals are removed from the area from (190, 232) to (198, 242)
    And Nelim's Pickle Tools: I place the decor "TableButcher" at (194, 237)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (168, 84, 48)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Insects Have No Bones Renew: a dead adult "Megaspider" lies at (197, 237)
    And Nelim's Pickle Tools: "Nelim" stands at (192, 237) facing East
    When Nelim's Pickle Tools: I frame the area centred on (194, 237) at root size 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 30 ticks pass
    Then I take a screenshot "gallery-3-the-butcher-table"

  Scenario: 4 afternoon, the products in a row
    Given I set the hour to 14
    And Nelim's Sanctuary: the sanctuary "exhibition-zone" is emptied
    And Nelim's Sanctuary: the animals are removed from the sanctuary "exhibition-zone"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (168, 84, 48)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Insects Have No Bones Renew: the butcher products of a fresh adult "Megaspider" lie in a row from (214, 166)
    And Nelim's Pickle Tools: "Nelim" stands at (216, 168) facing South
    When Nelim's Pickle Tools: I frame the area centred on (216, 166) at root size 5
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 30 ticks pass
    Then I take a screenshot "gallery-4-the-products"

  Scenario: 5 dusk, the hearth
    Given I set the hour to 19
    And Nelim's Sanctuary: the animals are removed from the sanctuary "fire-pit"
    And Nelim's Pickle Tools: I place the decor "DR_StickLantern" at (183, 113)
    And Nelim's Pickle Tools: the decor "DR_StickLantern" at (183, 113) is lit
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bob"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (232, 224, 200)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: an adult animal of kind "AA_Aerofleet" named "Nimbus" is spawned at (178, 112)
    And Nelim's Pickle Tools: the animal "Nimbus" stands at (178, 112) facing South
    And Nelim's Pickle Tools: "Nelim" stands at (180, 114) facing South
    When Nelim's Pickle Tools: I frame the area centred on (180, 114) at root size 7
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 30 ticks pass
    Then I take a screenshot "gallery-5-the-hearth"
