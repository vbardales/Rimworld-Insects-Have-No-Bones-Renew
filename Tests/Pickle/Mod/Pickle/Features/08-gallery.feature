# Workshop gallery, "The day the giants came to the fence" (shotlist of 2026-10-26, replaces the plan of 2026-10-15; PUBLICATION.md, "Screenshots" and
# "Gallery subtitles"). NOT PLAYED. The scenarios below were written to this shotlist on 2026-10-26, with the steps NPT confirmed (see "Steps" at the end of this
# header). Scene 4 differs from its line: the dog stands (no gnawing job without the mammal bone def) and Nelim crosses without meat; both come back once
# the first run names the bone item. Every cell is unread: the run decides.
#
# STORY. One day in Nelim's Sanctuary, the only colonist (NSB's Nelim; no other colonist, owner rule 2026-10-25). Giant insects walked up to the
# bamboo fence overnight. Nelim meets them at dawn, the hunt is over by morning, the carcass is butchered, and the one thing the whole day shows is
# what the mod changes: an insect gives meat, fat and leather and no bone. Thread of the series: Shogun the Labrador (an animal of the fixture, spawned
# by name) sniffs the carcass in 2, watches the work in 3, finds the Muffalo bone and no spider bone in 4, sleeps by the fire in 5. Rhythm: one hour per
# image (6, 9, 11, 14, 19), the photographer's choice (GALLERY.md, 2026-10-14); same day, clear sky, lantern lit at dawn and again at dusk. Opening image 1
# (the place and the giants), closing image 5 (the hearth). Shots: wide (1), medium (2), medium-tight (3), tight (4), medium-wide (5).
#
# NELIM, continuity. Dark ponytail, rust shirt, dark trousers all day (never a hat: no hat-hair mod needed). Scene 1 adds an olive duster (cold dawn); it is
# off from scene 2 on (it warmed up: the plan says so). Scene 5: the shirt becomes cream for supper, hair unchanged. Face: her own (two brows, smirk, blink);
# no mouth or lid step, they are not proven without the experimental facial mods. The first `wears` undresses her: trousers are put back every time.
#
# SCENES (index, place, hour; subject; composition; living things; decor; what the picture says; subtitle). Estimate: 5, minus 0.5 per weak criterion.
# 1 workshop-1-dawn. enclosure-south, 06:00, Clear, +30 ticks. Nelim walks toward the gate; at the fence an Arthropleura facing the camera (the one
#   front-facing animal of the series) and a Megascarab side-on pressing the fence. Root size 6, Nelim in the left third and the foreground, Arthropleura
#   centre-back, low light. Decor: DR_StickLantern lit on the gatepost (removed after). Says: the giants came in the night. Moment: just after they
#   appear, just before she opens the gate. Gesture: `"Nelim" is forced to walk to (x, z)` then `I advance the paused game by exactly N ticks` (played, ticket 531b). Estimate 4.5
#   (j weak: the creatures, not yet the mod).
# 2 workshop-2-the-carcass. gravel-yard, 09:00. Nelim (no duster) walks up to a dead Megaspider; Shogun trots beside her, nose toward the carcass.
#   Root size 6, carcass lower right, Nelim centre-left, long morning shadows. Decor: three Plant_Daylily fully grown at the edge, a Stool. Says: the hunt
#   is over, the work begins. Moment: just after the kill, just before the knife. Gesture: forced walk for Nelim, Shogun stands facing her (played). 4.5 (j weak).
# 3 workshop-3-the-butcher-table. barn, 11:00. Nelim at the TableButcher (194, 237) with the knife, the carcass beside it, the products (meat, fat, leather)
#   piled on the table in the foreground; Shogun at the door watching. Root size 5, table centre, Nelim left, carcass right. Says: every cut comes away
#   clean. Moment: mid-cut. Gesture: bill + `forced into the job "DoBill"` on TableButcher, Meat beside it (compiled, never played; fallback: still). 4.0 (e, j weak).
# 4 workshop-4-the-products. barn east side, 14:00. Tight (root 4): left, the products of a Muffalo with its bone; right, those of the Megaspider, no
#   bone; Shogun in the foreground gnaws the Muffalo bone, head turned toward the spider's pile; Nelim crosses the frame behind carrying meat. Says: one
#   bone for the dog, none for the spider (the contrast carries the mod; not a catalogue plate because the dog and Nelim act). Risk: the bone item of a
#   mammal under Medieval Overhaul is NOT confirmed: the first run reads the Muffalo products, and the scene is redone if there is no bone item. 4.5 (e weak).
# 5 workshop-5-the-hearth. fire-pit, 19:00. Nelim (cream shirt, ponytail) at the hearth, warming her hands; Shogun lies by the fire; an Alpha Animals
#   AA_Aerofleet rests side-on near the wall; the hall's thrumbos are sent away (one subject: the supper). Root size 6, fire centre, Nelim right,
#   Shogun foreground. Decor: DR_StickLantern lit (183, 113), a PlantPot with Plant_Daylily. Says: supper by the fire, nothing left to pick out. Gesture:
#   a still pose (a hearth job is asked of NPT). 4.0 (e, j weak).
#
# Mods: the "gallery" map (wsl-deps.gallery.map): Sanctuary, bodies and faces, Medieval Overhaul (the fat and the bone contrast), Alpha Animals,
# Megafauna, Stick Lantern. Nothing staged ships with this mod. Colonists: Nelim only. Animals dressed: none.
# Steps (NPT answered 2026-10-26, nothing refused): forced walk + paused advance (played); DoBill at a butcher table, forced haul, lying animal, Ingest as a sniff (compiled, not played); the animal of the fixture "Shogun" stands at a cell facing a direction (played; spawn a named one if absent).
# 2026-10-26. On a refusal the owner arbitrates. Scenes keep a still-pose fallback (the estimates above assume it).
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
    And Nelim's Pickle Tools: I place the decor "DR_StickLantern" at (151, 216)
    And Nelim's Pickle Tools: the decor "DR_StickLantern" at (151, 216) is lit
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (168, 84, 48)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Duster" dyed rgb (96, 104, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: an adult animal of kind "Arthropleura" named "Rhea" is spawned at (156, 214)
    And Nelim's Pickle Tools: an adult animal of kind "Megascarab" named "Scara" is spawned at (159, 212)
    And Nelim's Pickle Tools: the animal "Rhea" stands at (156, 214) facing South
    And Nelim's Pickle Tools: the animal "Scara" stands at (159, 212) facing East
    And Nelim's Pickle Tools: "Nelim" stands at (147, 214) facing East
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (151, 214)
    When Nelim's Pickle Tools: I frame the area centred on (154, 214) at root size 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    Then I take a screenshot "gallery-1-at-the-gate"

  Scenario: 2 morning, the hunt is over
    Given I set the hour to 9
    And Nelim's Sanctuary: the sanctuary "gravel-yard" is emptied
    And Nelim's Sanctuary: the animals are removed from the sanctuary "gravel-yard"
    And Nelim's Pickle Tools: I place the decor "Stool" at (166, 141)
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (174, 146) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (175, 147) fully grown
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (173, 148) fully grown
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (168, 84, 48)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Insects Have No Bones Renew: a dead adult "Megaspider" lies at (171, 143)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (167, 146) facing East
    And Nelim's Pickle Tools: "Nelim" stands at (163, 144) facing East
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (167, 144)
    When Nelim's Pickle Tools: I frame the area centred on (169, 143) at root size 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
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
    And Insects Have No Bones Renew: the butcher products of a fresh adult "Megaspider" lie in a row from (192, 235)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (189, 233) facing East
    And Nelim's Pickle Tools: "Nelim" stands at (192, 237) facing East
    And Nelim's Pickle Tools: the building "TableButcher" at (194, 237) has the bill "ButcherCorpseFlesh"
    And Nelim's Pickle Tools: "Nelim" is forced into the job "DoBill" on the building "TableButcher" at (194, 237)
    When Nelim's Pickle Tools: I frame the area centred on (194, 237) at root size 5
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I advance the paused game by exactly 60 ticks
    Then I take a screenshot "gallery-3-the-butcher-table"

  Scenario: 4 afternoon, one bone for the dog
    Given I set the hour to 14
    And Nelim's Pickle Tools: the area from (198, 232) to (204, 242) is emptied
    And Nelim's Pickle Tools: the animals are removed from the area from (198, 232) to (204, 242)
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (168, 84, 48)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Insects Have No Bones Renew: the butcher products of a fresh adult "Muffalo" lie in a row from (199, 236)
    And Insects Have No Bones Renew: the butcher products of a fresh adult "Megaspider" lie in a row from (199, 239)
    And Nelim's Pickle Tools: the animal "Shogun" stands at (201, 234) facing East
    And Nelim's Pickle Tools: "Nelim" stands at (204, 241) facing West
    And Nelim's Pickle Tools: "Nelim" is forced to walk to (200, 241)
    When Nelim's Pickle Tools: I frame the area centred on (201, 238) at root size 4
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I advance the paused game by exactly 20 ticks
    Then I take a screenshot "gallery-4-the-products"

  Scenario: 5 dusk, the hearth
    Given I set the hour to 19
    And Nelim's Sanctuary: the animals are removed from the sanctuary "fire-pit"
    And Nelim's Pickle Tools: I place the decor "DR_StickLantern" at (183, 113)
    And Nelim's Pickle Tools: the decor "DR_StickLantern" at (183, 113) is lit
    And Nelim's Pickle Tools: I place the decor "Plant_Daylily" at (184, 116) fully grown
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytail"
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (60, 40, 30)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (232, 224, 200)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (70, 64, 60)
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Sanctuary: Nelim has her own face
    And Nelim's Pickle Tools: an adult animal of kind "AA_Aerofleet" named "Nimbus" is spawned at (178, 112)
    And Nelim's Pickle Tools: the animal "Nimbus" stands at (178, 112) facing East
    And Nelim's Pickle Tools: the animal "Shogun" lies at (181, 112) facing South
    And Nelim's Pickle Tools: "Nelim" stands at (180, 114) facing East
    When Nelim's Pickle Tools: I frame the area centred on (180, 114) at root size 6
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 30 ticks pass
    Then I take a screenshot "gallery-5-the-hearth"
