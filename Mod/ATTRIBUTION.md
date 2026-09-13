# Insects don't have bones — attribution

A 1.6 port of **Insects don't have bones**, by **SirMashedPotato** and **Hiroyan**
([2041677515](https://steamcommunity.com/sharedfiles/filedetails/?id=2041677515)).

## Status: public; explicit upstream permission

The original author's [Steam description](https://steamcommunity.com/sharedfiles/filedetails/?id=2041677515)
states: "Contents of this mod are free to use in other mods." The author also confirms
reuse in a November 21, 2024 comment. This permission was checked on 2026-09-13;
the web provider supplied a snapshot labelled as crawled eight months earlier.

The workflow classification is `open`, based on this explicit permission, rather
than `silent`. The installed source declares RimWorld 1.3, 1.4 and 1.5. The absence
of a standalone licence file does not erase the permission on the author's page.
This supersedes the earlier review that incorrectly reported no permission there.

MIT covers only this port's own contributions, as scoped in LICENSE. The original
material remains credited to SirMashedPotato and Hiroyan and is reused under the
statement above; it is not relicensed as MIT. The existing removal-on-request
commitment in LICENSE is retained. The author field preserves both original authors.

The original mod ships no assemblies, so nothing here was decompiled from it.

## What was carried over

Everything that makes the mod what it is:

- the idea — that a bone mod which does not know what an insect is will hand you bone from a
  megaspider — and the choice to solve it on the `BaseInsect` abstract rather than creature by
  creature;
- the distinction between **no bone** and **no bone and no fat**, which is the one real design
  decision in it: an insect has fat, a goo does not;
- **Hiroyan's Alpha Animals lists**, seventy-five creatures sorted into those two groups. That
  is the bulk of the mod by volume and all of its judgement. Not one creature was moved between
  groups.

## What changed in the port

### The class name every Medieval Overhaul patch used had been dead for a version

Medieval Overhaul renamed its namespace `DankPyon` → `MedievalOverhaul` in its 1.5 build.
Verified across all three of its shipped assemblies, by reading the metadata string heap and by
decompiling the type:

| | class in `<modExtensions>` |
|---|---|
| 1.4 `MedievalOverhaul.dll` | `DankPyon.ButcherProperties` |
| 1.5 `MedievalOverhaul.dll` | `MedievalOverhaul.ButcherProperties` |
| 1.6 `MedievalOverhaul.dll` | `MedievalOverhaul.ButcherProperties`; the string `DankPyon` does not occur in the assembly |

`hasBone` and `hasFat` are unchanged, both `true` by default, on an `internal class … :
DefModExtension`. The rename is the whole of it.

An independent living mod confirms the same migration on the same schedule: workshop item
`3109835541` ships `Class="DankPyon.ButcherProperties"` in its `1.4` folder and
`Class="MedievalOverhaul.ButcherProperties"` in `1.5` and `1.6`.

The consequence, traced through `Assembly-CSharp` 1.6, is worse than a patch that does nothing.
`DirectXmlToObject.ClassTypeOf` logs *Could not find type named …*, falls back to `typeof(T)` —
the abstract `DefModExtension` — `Activator.CreateInstance` throws,
`DirectXmlLoader.DefFromNode` catches and returns **null**, and the def is dropped. Since the
patch targeted the abstract `BaseInsect`, `XmlInheritance` passed the bad `<modExtensions>` down:
**every concrete insect in the game went with it.**

### Two dead Alpha Animals names, one of them fatal

`AA_PseudoBaseMechanoid` and `AA_WaywardMobileAssembler` exist in neither Alpha Animals 1.6 nor
1.5. Dropped. Rim of Madness - Bones Unofficial Fix, which maintains the same list for its own
stat, dropped exactly the same two — its 1.6 Alpha Animals list and this one are identical name
for name.

`Outland_Alpha Animals.xml` had `AA_PseudoBaseMechanoid` in its **third of seventy-nine**
operations, inside a `PatchOperationSequence`. That class returns on the first child that fails
instead of skipping it, so **seventy-seven operations had never run**. The Alpha Animals half of
the Outland Core support was doing two things out of seventy-nine.

Both lists are now grouped by the value written rather than one operation per creature, so a
name going missing upstream no longer silences the rest of the file.

### `loadFolders.xml`, twice over

The file was spelled with a lower-case `l`. RimWorld looks for `LoadFolders.xml` and nothing
else; on a case-sensitive filesystem the file is not found at all and every folder in it is
ignored. Renamed.

Its `<v1.3>` and `<v1.5>` blocks listed only `Mods/…` subfolders.
`ModContentPack.InitLoadFolders` calls `AddFolders` on the matching block — or, absent an exact
match, on the highest defined block `<=` the current version — and **returns**; the mod root and
`Common/` are added only on the no-`LoadFolders` fallback path. So `Common/Patches/` had never
loaded, on any supported version. Moot, per the section below.

### Guards now test defs instead of display names

`PatchOperationFindMod` compares `ModMetaData.Name` — the display name, by plain string equality
in `ModLister.HasActiveModWithName`. "Megafauna" and "Alpha Animals" are still exact today, but
that name belongs to the upstream author and changes the day a mod is renamed or continued.
Replaced by `PatchOperationConditional` on a def the operation is about to touch, which is silent
when the dependency is absent (`match` set, `nomatch` absent → returns `true`).

## What was dropped from the published folder

- **`Mods/ROM_Bones/`**, all three files. [Rim of Madness - Bones Unofficial Fix](https://steamcommunity.com/sharedfiles/filedetails/?id=3252977437)
  (`sihv.rombonesPort`) declares 1.6 and ships the same patches itself: `Patches/BonelessInsects.xml`
  and `Patches/BonelessMegafauna.xml` at its root, `1.6/Patches/BonelessAlphaAnimals.xml` in its
  version folder. Its `LoadFolder.xml` is misspelled — no `s` — so RimWorld ignores it and takes
  the fallback path, which is why the root files load on every version. A living mod covering it
  makes this one's copy redundant; two mods writing the same value to the same def is only a way
  to get it wrong twice.
- **`Common/`**, both files. They were the same Rim of Madness patches, and they had never
  loaded.
- **`About/PublishedFileId.txt`**, for the obvious reason: it names SirMashedPotato's Workshop
  item.
- **`About/Preview.png`**. It is the original author's own artwork and carries a **1.4** badge in
  the corner, which would be a lie on a 1.6 page.

## What was deliberately left alone

Alpha Animals 1.6 has 64 animals that neither the abstract bases nor Hiroyan's list reaches.
Almost all are vertebrates and should have bones; a few are arguable (`AA_Locusts`,
`AA_SmallButterfly`, `AA_OcularCactus`, `AA_MycoidColossus`). Deciding which creature has a
skeleton is the original authors' call, not a porter's. The roster is unchanged.

Likewise the `hasFat` values: Medieval Overhaul 1.6 gives an `Insectoid`-fleshed animal neither
bone nor fat on its own, so the 37 insectoid entries in this mod now read as *giving the fat
back*. That is what the original said, and it stands.

## Adoption

If I do not answer within a reasonable time after being contacted, anyone may freely update this
or any other of my mods, including publishing a continuation of it. All credit must be preserved.
