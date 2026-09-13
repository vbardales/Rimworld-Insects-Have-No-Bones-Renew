# Changelog

All notable changes to this mod are documented here.

## [Unreleased]

- Add the 128px mod icon and 896x504 Workshop preview, preserving source artwork,
  prompts and reproducible preview composition.
- Add native XML patch-loader tests, passing results and final in-game scenarios.
  In-game validation remains pending.
- Add the final source repository link and accurate artwork attribution to About.
- Establish the standalone repository while preserving the existing public history.
- Correct the rights documentation to cite the original author's explicit reuse
  permission; preserve the limited MIT scope, credits and removal commitment.
- Record the workflow audit and add reproducible XML selector checks. No gameplay
  behavior or patch payload changed.

## [1.0.0] — 2026-09-05

First release. Port of SirMashedPotato and Hiroyan's **Insects don't have bones** to RimWorld 1.6.

### Fixed

- **`DankPyon.ButcherProperties` → `MedievalOverhaul.ButcherProperties`** in all three Medieval
  Overhaul patch files. Medieval Overhaul renamed its namespace in its 1.5 build; the string
  `DankPyon` does not occur anywhere in its 1.6 assembly. The fields did not move — `hasBone` and
  `hasFat`, both `true` by default, on a class deriving from `DefModExtension`.

  This was not a patch quietly doing nothing. `DirectXmlToObject.ClassTypeOf` logs *Could not
  find type named …*, falls back to `typeof(T)` — the abstract `DefModExtension` —
  `Activator.CreateInstance` throws, `DirectXmlLoader.DefFromNode` catches it and returns
  **null**, and the def is dropped. The patch targeted the abstract `BaseInsect`, so
  `XmlInheritance` handed the bad `<modExtensions>` to every insect below it: **megaspider,
  megascarab, spelopede and every modded insect deriving from `BaseInsect` were dropped** for
  anyone running Medieval Overhaul. True since 1.5, not new in 1.6.
- `AA_PseudoBaseMechanoid` and `AA_WaywardMobileAssembler` removed: neither exists in Alpha
  Animals 1.6, nor in 1.5. Rim of Madness - Bones Unofficial Fix, which keeps the same list for
  its own stat, dropped exactly the same two — its 1.6 Alpha Animals list and this one now match
  name for name.
- In `Outland_Alpha Animals.xml`, the dead `AA_PseudoBaseMechanoid` was the **third of
  seventy-nine** operations inside a `PatchOperationSequence`, which returns on the first child
  that fails rather than skipping it. **Seventy-seven operations had never run.** In
  `MO_Alpha Animals.xml` the same name was one clause of an `or` and survived; there it was
  `AA_WaywardMobileAssembler`, seventy-fifth of seventy-seven, that cost the last two operations
  (`AA_Wildpawn`, `AA_Wildpod`).
- `loadFolders.xml` renamed to **`LoadFolders.xml`**. RimWorld looks for that name and no other;
  on a case-sensitive filesystem — a Steam Deck, any Linux box — the lower-case file is not found
  and every folder in it is ignored.

### Changed

- `<supportedVersions>` set to 1.6, and `LoadFolders.xml` rewritten to a single `<v1.6>` block
  listing the mod root plus the two guarded dependency folders.
- `packageId` from `SirMashedPotato.InsectsHaveNoBones` to `nelim.insectshavenobones`, with the
  original declared in `<incompatibleWith>`: both patch the same defs.
- The two Alpha Animals lists are **grouped by the value they write** instead of being one
  operation per creature — two operations for Medieval Overhaul (bone/fat, then bone/no-fat), one
  for Outland Core. Each is an xpath with an `or` clause per `defName`, one per line so the file
  stays greppable and diffable. An xpath matching at least one node succeeds, so a creature
  disappearing upstream no longer takes the rest of the file with it. `<success>Always</success>`
  on the sequence was **not** the fix: it is read in `PatchOperation.Apply`, clears
  `neverSucceeded`, and stops `Complete()` reporting anything without restoring the skipped run.
- Every `PatchOperationFindMod` replaced by a `PatchOperationConditional` testing a def the
  operation is about to touch — `AA_AlphaBaseInsect` for Alpha Animals, `Arthropleura` for
  Megafauna. `PatchOperationFindMod` compares `ModMetaData.Name`, the **display name**, by plain
  string equality; both names were verified exact against the installed 1.6 mods, but that name
  belongs to the upstream author and changes the day a mod is renamed or continued.
  `PatchOperationConditional` with a `match` and no `nomatch` returns `true` when its xpath
  misses, so an absent dependency stays silent.
- Patch folders flattened and files renamed: `Mods/MedievalOverhaul/Patches/MO/MO_Alpha Animals.xml`
  → `Mods/MedievalOverhaul/Patches/MO_AlphaAnimals.xml`, and likewise for the rest. No spaces in
  filenames, no redundant `MO/` level.

### Removed

- **`Mods/ROM_Bones/`**, all three files, and **`Common/`**, both files — the same Rim of Madness
  patches by another route. [Rim of Madness - Bones Unofficial Fix](https://steamcommunity.com/sharedfiles/filedetails/?id=3252977437)
  (`sihv.rombonesPort`) declares 1.6 and ships them itself: `Patches/BonelessInsects.xml` and
  `Patches/BonelessMegafauna.xml` at its root, `1.6/Patches/BonelessAlphaAnimals.xml` in its
  version folder. Two mods writing `<BoneAmount>0</BoneAmount>` onto the same defs is only a way
  to get it wrong twice.

  The `Common/` pair had never loaded in any case: `ModContentPack.InitLoadFolders` calls
  `AddFolders` on the matching version block and **returns**, and the original's blocks listed
  only `Mods/…` subfolders. The root and `Common/` are added only on the fallback path taken when
  a mod has no `LoadFolders` at all.
- `About/PublishedFileId.txt`: it names SirMashedPotato's Workshop item.
- `About/Preview.png`: the original author's own artwork, carrying a **1.4** badge in the corner.

### Unchanged

- Which creatures are covered, and which of the two groups each one is in. Hiroyan's Alpha
  Animals lists are the bulk of the mod and all of its judgement; not one creature was moved.
- The `hasFat` values. Medieval Overhaul 1.6 gives an `Insectoid`-fleshed animal neither bone nor
  fat by itself — new in its 1.5 build, where 1.4 gave both to every fleshy animal — so the 37
  insectoid entries here now read as handing the fat back. That is what the original said.
- Alpha Animals' 64 other animals are still not covered. Nearly all are vertebrates; the few
  arguable ones (`AA_Locusts`, `AA_SmallButterfly`, `AA_OcularCactus`, `AA_MycoidColossus`) are
  the original authors' call, not a porter's.
