# Insects don't have bones 1.6

Port of **SirMashedPotato and Hiroyan's Insects don't have bones** to RimWorld 1.6.

**I am not the author of this mod.** The idea, and the long lists of Alpha Animals creatures
that are the bulk of it, are theirs — all I did was the work needed to make it run on 1.6 and
repair what the port turned up. Credit goes to them; mistakes in the port are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=2041677515 — declares 1.3,
1.4 and 1.5, and nothing further. The page is still online; the mod is abandoned, not withdrawn.
It ships no code, so nothing here was decompiled from it.

## What the mod does

Medieval Overhaul and Outland Core both add bone as a butchering product. Neither of them, left
alone, has any reason to think a megaspider is different from a muffalo — so a colony butchering
an insect infestation ends up with a pile of bone.

This takes the bone away: from the base game's insects, from anything a mod builds on top of the
`BaseInsect` abstract, and from the creatures in Megafauna and Alpha Animals that no other rule
reaches. Under Medieval Overhaul the insects keep their **fat**, which is the distinction the
original was making and which the mod's own name understates.

| | Medieval Overhaul | Outland Core |
|---|---|---|
| base game insects, and everything inheriting `BaseInsect` | no bone, fat kept | no bone |
| Alpha Animals insectoids and pseudo-mechanoids (59 + 2 abstract bases) | no bone, fat kept | no bone |
| Alpha Animals goo, spores, jellies, carnivorous plants (16) | no bone, no fat | no bone |
| Megafauna's Arthropleura, Meganeura, Pulmonoscorpius | no bone, fat kept | no bone |

Neither Medieval Overhaul nor Outland Core is required. Install one, the other, or both, and the
matching folder loads on its own through `LoadFolders.xml`. Megafauna and Alpha Animals are
optional inside each: every patch that touches them is guarded, so having neither installed does
nothing and errors at nothing.

Safe to add to a save, and safe to remove: the mod writes nothing into one.

## What it deliberately does not cover

**Rim of Madness - Bones.** The original shipped a third set of patches for it, and they are
gone. [Rim of Madness - Bones Unofficial Fix](https://steamcommunity.com/sharedfiles/filedetails/?id=3252977437)
(`sihv.rombonesPort`) is alive in 1.6 and ships the same three files itself — `BonelessInsects.xml`,
`BonelessMegafauna.xml` at its root, and `BonelessAlphaAnimals.xml` in its `1.6` folder. Its
Alpha Animals list was compared name by name against this one: **identical**, down to the same
two creatures dropped. Two mods writing `<BoneAmount>0</BoneAmount>` onto the same defs is only a
way to get it wrong twice.

**New Alpha Animals creatures.** Alpha Animals 1.6 has 64 animals that neither the abstract bases
nor Hiroyan's list reaches. Nearly all of them are vertebrates — lions, yaks, ravens, mice — and
ought to have bones. A handful are arguable (`AA_Locusts`, `AA_SmallButterfly`, `AA_OcularCactus`,
`AA_MycoidColossus`). Which creature has a skeleton is the original authors' judgement call, not
a porting decision, so the roster is unchanged.

## What changed in the 1.6 port

Short version: **the mod had been broken since Medieval Overhaul's 1.5 build**, and one of its
two remaining folders had been running three operations out of seventy-nine.

### `DankPyon.ButcherProperties` no longer exists

Medieval Overhaul renamed its namespace from `DankPyon` to `MedievalOverhaul` when it shipped
1.5. Checked against all three of its assemblies:

| | class named in `<modExtensions>` |
|---|---|
| Medieval Overhaul 1.4 | `DankPyon.ButcherProperties` |
| Medieval Overhaul 1.5 | `MedievalOverhaul.ButcherProperties` |
| Medieval Overhaul 1.6 | `MedievalOverhaul.ButcherProperties` — the string `DankPyon` does not appear in the assembly at all |

The fields did not move: `hasBone` and `hasFat`, both defaulting to `true`, on a class deriving
from `DefModExtension`. Only the namespace changed.

**This is not a silent failure, it is a loud one in the wrong place.** Traced through
`Assembly-CSharp` 1.6: `DirectXmlToObject.ClassTypeOf` logs *Could not find type named …* and
falls back to `typeof(T)` — here the abstract `DefModExtension` — `Activator.CreateInstance` then
throws, `DirectXmlLoader.DefFromNode` catches it, logs *Exception loading def from file …*, and
returns **null**. The def is dropped.

The patch was applied to `BaseInsect`, which is abstract, so `XmlInheritance` handed the bad
`<modExtensions>` to every concrete insect below it. Megaspider, megascarab, spelopede and every
modded insect deriving from `BaseInsect`: all dropped, for anyone running Medieval Overhaul.

`scripts/Check-XmlClasses.ps1` finds this on its own, given a type list built from the 1.6
assemblies — it names the dead type and proposes `MedievalOverhaul.ButcherProperties`.

### Two Alpha Animals defs that no longer exist, and a sequence that stops

`AA_PseudoBaseMechanoid` and `AA_WaywardMobileAssembler` are in neither Alpha Animals 1.6 nor
1.5. Both are dropped.

Where they sat mattered:

- **`Outland_Alpha Animals.xml`** put `@Name="AA_PseudoBaseMechanoid"` in its **third** operation
  of seventy-nine, all of them inside one `PatchOperationSequence`.
  `PatchOperationSequence.ApplyWorker` returns on the first child that fails rather than skipping
  it, so **seventy-seven operations never ran**. The whole Outland Core / Alpha Animals patch was
  doing two things out of seventy-nine, and had been for at least a version.
- **`MO_Alpha Animals.xml`** got away with the same name because it was one clause of an `or`
  inside a single xpath, which still matched the other two. `AA_WaywardMobileAssembler` was
  seventy-fifth of seventy-seven there, so only the last two operations were lost —
  `AA_Wildpawn` and `AA_Wildpod`.

The two lists are now **grouped by the value they write** rather than being one operation per
creature: two operations for Medieval Overhaul, one for Outland Core, each an xpath with an
`or` clause per `defName`, one per line so they stay greppable and diffable. A predicate that
matches at least one node succeeds, so a creature disappearing upstream no longer takes the rest
of the file with it. The trade is that such a disappearance is now quiet — which is why every
name was checked against the shipped 1.6 files rather than trusted.

Same fix as the one in *Extinguish Refuelables Compatibility Patch 1.6*, for the same reason:
`<success>Always</success>` on the sequence would have silenced the report without restoring the
skipped run.

### `loadFolders.xml` never loaded the `Common` folder

The original declared `<v1.3>` and `<v1.5>` blocks, each listing only `Mods/…` subfolders.
`ModContentPack.InitLoadFolders` takes the matching version block — or, failing an exact match,
the highest defined block `<=` the current version, which for 1.6 was `<v1.5>` — calls
`AddFolders` and **returns**. The mod root and a `Common/` folder are added only on the fallback
path taken when there is no `LoadFolders` at all. `CommonFolderName` is never consulted otherwise.

So `Common/Patches/Races_Animal_Insect.xml` and `Common/Patches/Megafauna.xml` had never loaded,
on any version this mod supported. It happened not to matter — they were the Rim of Madness
patches, which the living unofficial fix ships anyway — and they are gone with the rest of that
support.

The file is also renamed **`LoadFolders.xml`**, with the S. RimWorld looks for that name and no
other; on a case-sensitive filesystem — a Steam Deck, any Linux box — `loadFolders.xml` is simply
not found and every folder in it is ignored. On Windows it happened to work.

### Guards test defs, not display names

Every `PatchOperationFindMod` is replaced by a `PatchOperationConditional` whose xpath tests one
of the defs the patch is about to touch — `AA_AlphaBaseInsect` for Alpha Animals, `Arthropleura`
for Megafauna.

`PatchOperationFindMod.ApplyWorker` calls `ModLister.HasActiveModWithName`, which is a plain
string equality against `ModMetaData.Name` — the mod's **display name**, not its `packageId`.
Both names were verified exact against the installed 1.6 mods ("Megafauna", "Alpha Animals"), so
the guards would have worked today; they would stop working the day either mod is renamed or
continued under a new title. Testing the def tests what the operation actually needs.
`PatchOperationConditional` with a `match` and no `nomatch` returns `true` when the xpath misses,
so an absent dependency is silent.

### What Medieval Overhaul now does by itself

Worth knowing, because it changes what the Medieval Overhaul half of this mod is *for*.
`Pawn_ButcherProducts` in Medieval Overhaul **1.4** gave bone and fat to every fleshy animal
unless a `ButcherProperties` said otherwise. Since **1.5** it reads:

```csharp
if (butcherProperties != null)      { flag = …hasBone; flag2 = …hasFat; }
else if (__instance.RaceProps.Insect) { flag = false; flag2 = false; }
else                                  { flag = true;  flag2 = true; }
```

An `Insectoid`-fleshed animal already gets neither bone nor fat. Of the creatures this mod names,
37 are `Insectoid` and 38 are not — the goos, jellies, aerofleets, mits and pseudo-mechanoids,
which inherit `AnimalThingBase` and default to normal flesh. **Those 38 are what the Medieval
Overhaul patches still do that nothing else does**, plus handing the fat back to the insects the
original authors wanted fatty.

Outland Core has no such rule: `Outland_BoneAmount` has a `defaultBaseValue` of 35 and a
`StatPart_BodySize`, and the only `StatPart` it adds is a settings multiplier. Its half of the
mod is load-bearing throughout.

## Validation

Everything below was checked against the files actually installed, not against memory.

- `scripts/Check-DefRefs.ps1` — well-formed XML, no dangling def reference, every `ParentName`
  resolved. Clean.
- `scripts/Check-XmlClasses.ps1` — every `Class="…"` resolves, against a type list built from
  RimWorld 1.6 plus the Medieval Overhaul and Outland Core 1.6 assemblies. Clean here; on the
  **unported source** it reports `DankPyon.ButcherProperties` and proposes the replacement.
- `scripts/Check-XmlFields.ps1` — every element maps to a real 1.6 field, `hasBone` and `hasFat`
  included. Clean.
- Every xpath in the six patch files was **run** against a merged `XmlDocument` built from the
  real 1.6 def files of Core, Alpha Animals and Megafauna, in four combinations (Core alone,
  +Alpha Animals, +Megafauna, both). Counts came out exactly as intended — 61 and 16 for the
  Medieval Overhaul lists, 77 for Outland Core's, 3 for each Megafauna operation, 1 for each
  `BaseInsect` operation — and every guard correctly skipped when its dependency was absent.
- `PatchOperationAdd` on `…/statBases` only matches a def that declares `<statBases>` **itself**,
  because patches run before inheritance. All 77 Alpha Animals targets and all three Megafauna
  targets were checked to have their own. So does Core's `BaseInsect`.
- `Outland_BoneAmount` confirmed present in Outland Core 1.6 (`1.6/Defs/StatDefs/Stats_Bones.xml`).

Not yet done: **testing in game.** That is nelim's, on her own machine.

## Credits

- **SirMashedPotato** — the original mod.
- **Hiroyan** — the Alpha Animals lists, which are most of it.
- **SirLalaPyon** for Medieval Overhaul, **Neronix17** for Outland Core, **Sarg Bjornson** and
  the Alpha team for Alpha Animals, **Spino** for Megafauna, the **Rim of Madness team** for Rim
  of Madness - Bones and **Sihv** for keeping it alive.

The original author explicitly permits reuse on the linked Steam page. MIT covers only
the port contributions described in LICENSE. See [ATTRIBUTION.md](ATTRIBUTION.md) for
the permission statement, credits and removal-on-request commitment.
