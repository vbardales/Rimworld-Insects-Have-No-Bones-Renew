# Publication

What the Workshop page needs and the rest of the repository does not hold. It serves twice: for the
first release, and for whoever takes the mod over.

**Status: drafted, 2026-09-29.** Workshop item `3806768044` was created private by the `0.1.0`
prepublication of 2026-09-23 and its `PublishedFileId.txt` is committed and pushed. No Git tag and no
GitHub release exist, and none is made by hand: the CI creates them after a successful upload. Nothing
below has been posted or pasted anywhere. The stage is `done` (see `STATUS.md`), not `prepublished`.

## What blocks the publication

Not restated from `AUDIT.md`; only what is specific to this mod.

- The Pickle suite (`Tests/Pickle/`, 32 scenarios, 5 passes) has never run green: the first ticket
  (`minimal`) found `wsl-deps.*.map` all missing a trailing newline, which silently dropped each
  map's last line from staging; fixed (`9d8d917`), a targeted re-check is out (2026-09-29).
- `TEST_SCENARIOS.md`'s manual checks in game are not run.
- The gallery does not exist (see below).
- The rollback target is not chosen (see "Fail fast").
- No dry-run of the publish workflow has run: no `.github/publish-tag.yml` exists yet, generated
  after `tested`.
- The page still carries the description `0.1.0` sent (the current `Mod/About/About.xml`), which
  is already the description below — no change is needed at first publish, only the pointer to
  `ATTRIBUTION.md` and the licence, and Workshop links on the mods it names, which the block below adds.

## Description

This mod has no `Mod/README.template.md`: the description lives directly in `Mod/About/About.xml`,
already close to final BBCode (plain text, one `[url=...]` line). The block below is what
`update_description=true` sends; it differs from the live `0.1.0` page only by adding the pointer to
`ATTRIBUTION.md` and the licence, and a Workshop link on each named mod.

```
[b]Insects don't have bones Renew[/b]

A 1.6 port of SirMashedPotato and Hiroyan's Insects don't have bones. I am not the author of this mod; the work here is what it took to make it run on 1.6, and to repair what the port turned up.

Butcher a megaspider in a colony running Medieval Overhaul or Outland Core and you get bone. An insect does not have bones. This takes them away, for the base game's insects, for anything a mod builds on top of BaseInsect, and for the creatures in Megafauna and Alpha Animals that no other rule reaches.

[b]What it covers[/b]

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3219596926]Medieval Overhaul[/url]: the base game's insects keep their fat and lose their bone. [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1541721856]Alpha Animals[/url]' insectoids the same; its goo, spores, jellies and carnivorous plants lose both. [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1055485938]Megafauna[/url]'s Arthropleura, Meganeura and Pulmonoscorpius lose their bone.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2755501685]Outland Core[/url]: the same creatures, through the Outland_BoneAmount stat.

Neither Medieval Overhaul nor Outland Core is required — install one, the other, or both, and the matching folder loads on its own. Megafauna and Alpha Animals are optional inside each: the patches test for the defs they touch, so having neither installed does nothing and errors at nothing.

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=3252977437]Rim of Madness - Bones Unofficial Fix[/url] is deliberately NOT covered. It already ships the same insect, Megafauna and Alpha Animals patches itself, and it is alive in 1.6. Two mods writing the same stat onto the same defs is only a way to get it wrong twice.

[b]What changed in the 1.6 port[/b]

Medieval Overhaul renamed its namespace from DankPyon to MedievalOverhaul in its 1.5 build. Every Medieval Overhaul patch in this mod named DankPyon.ButcherProperties, a type that has not existed since. RimWorld cannot resolve the class, falls back to the abstract DefModExtension, fails to construct it, and drops the def that was being loaded. Because the patch was applied to the abstract BaseInsect, every insect in the game went with it — megaspider, megascarab, spelopede and every modded insect below them. That was already true in 1.5, and it is what makes this a repair rather than a version bump.

The Alpha Animals patches named AA_PseudoBaseMechanoid and AA_WaywardMobileAssembler, neither of which exists in Alpha Animals any more. In the Outland Core file the dead name was the third of seventy-nine operations inside a sequence, and a sequence stops at the first operation that fails rather than skipping it — so seventy-seven of them had never run.

The operations are now grouped by the value they write instead of being one per creature, so a name going missing upstream no longer takes the rest of the file with it. Every remaining name was checked against the 1.6 files of Alpha Animals, Megafauna, Medieval Overhaul and Outland Core.

The mod's loadFolders.xml also never listed its own Common folder, so the two files in it had never loaded on any version. They were the Rim of Madness patches, and they are gone for the reason above.

Safe to add to a save, and safe to remove: it writes nothing into one.

[b]If I go quiet[/b]

If I do not answer within a reasonable time after being contacted, anyone may freely update this or any other of my mods, including publishing a continuation of it. All credit must be preserved.

[b]AI-generated[/b]

This port was done with Claude Code (Anthropic) under human direction and review. Stated openly: working with these tools is my job. The preview illustration was generated with OpenAI image generation and composed with a text overlay. Automated validation is documented in the repository; final in-game validation is pending.

[b]Thanks[/b]

[url=https://steamcommunity.com/sharedfiles/filedetails/?id=2041677515]SirMashedPotato[/url], who wrote the original, and Hiroyan, who wrote the Alpha Animals lists. SirLalaPyon for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3219596926]Medieval Overhaul[/url], Neronix17 for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=2755501685]Outland Core[/url], Sarg Bjornson and the Alpha team for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1541721856]Alpha Animals[/url], Spino for [url=https://steamcommunity.com/sharedfiles/filedetails/?id=1055485938]Megafauna[/url], the Rim of Madness team for Rim of Madness - Bones and Sihv for keeping [url=https://steamcommunity.com/sharedfiles/filedetails/?id=3252977437]Rim of Madness - Bones Unofficial Fix[/url] alive.

See ATTRIBUTION.md and LICENSE in the repository for the full rights picture: this port's own contributions are MIT, the original credits and reuse permission are unchanged.

[url=https://github.com/vbardales/Rimworld-Insects-Have-No-Bones-Renew]Source code on GitHub[/url]
```

**Open question for the owner:** whether to keep the Workshop links inline (above) or move to a plain
"Credits" list without links, matching the current About.xml style more closely. The block above adds
one link per named mod, which the current defect note in `BACKLOG.md` asks for.

## Images

- **Preview** (`Mod/About/Preview.png`, 896x504): the mod's name engraved with the "Renew" mark in
  secondary ink, the "1.6" corner badge kept. AI-generated background, composed with a text overlay
  (see `STATUS.md` for the render history). Since 2026-09-29 (owner convention) it also carries
  `Mod/About/ModIcon.png` cut out (`Art/cutout-icon.cjs`, background flood-filled transparent from the
  border), bottom-right, `-15deg`.
- **ModIcon** (`Mod/About/ModIcon.png`, 128 px): legible at 32 px (checked in `STATUS.md`).

The gallery folder `Art/Workshop/` holds `00-preview.png`, a byte-identical copy of the Preview, per the
2026-09-29 rule that every gallery starts there. It is regenerated by hand whenever the Preview is; nothing
checks that they still match.

This mod ships no code and no new texture: it has nothing of its own to photograph beyond the Preview.

## Screenshots, in this order

**Not settled, and possibly not needed** beyond `00-`. The mod's whole effect is the absence of one item in
a butchering result — a before/after pair of the butcher output list is the only image that shows
anything the description does not already say. Candidates for `01-`, `02-`:

| Order | What it should show | Why there |
|---|---|---|
| 1 | A megaspider's butcher products under Medieval Overhaul: meat and fat, no bone | The one thing this mod changes, shown |
| 2 | The same creature's products with the mod removed, for comparison (a `before` shot) | Makes the difference visible without reading |

Both need a colony with Medieval Overhaul running and a butchered megaspider; the Pickle suite's `03-base-insects`
scenario proves the same fact without a screenshot. Whether to bother with a gallery at all for a mod this
small is the owner's call.

## Dependencies and DLCs

**No DLC is required, and no mod.** `supportedVersions` declares 1.6 only.

| Declared | Identifier | Actually required |
|---|---|---|
| `incompatibleWith` | `SirMashedPotato.InsectsHaveNoBones` | Same patches on the same abstract bases: the original still names `DankPyon.ButcherProperties` and logs the resulting error beside this mod. The Pickle pass `incompat-original` plays them together and asserts the log line |
| `loadAfter` | `Ludeon.RimWorld`, `DankPyon.Medieval.Overhaul`, `Neronix17.Outland.Core`, `sarg.alphaanimals`, `Spino.Megafauna` | Soft: the mod does nothing if none of Medieval Overhaul or Outland Core is present, and nothing extra if Alpha Animals or Megafauna are absent. Never a hard `modDependencies` |
| `modDependencies` | none | The mod needs nothing and reads nothing from another mod at load time |

## Manual validations of the owner

`AUDIT.md` asks for none at `tested` that a test could carry, and lists "the owner's manual validations"
among the things a `publish` does not skip without saying which. This is a proposal drawn from `TESTING.md`
and `PUBLISHING.md`; it is hers to change.

| # | What to look at | Why a test cannot |
|---|---|---|
| 1 | Butcher a megaspider by hand under Medieval Overhaul and under Outland Core, look at the result panel | The Pickle step reads `Pawn.ButcherProducts` directly; the player-facing panel is never opened by a test |
| 2 | Add the mod to an existing save with a butchering job already in the queue, then remove it | `TESTING.md` item 3: adding/removing on a live save |
| 3 | Subscribe to item `3806768044`, start a game with the installed copy | The installed copy is what players get; the suite plays the working tree |
| 4 | The gallery, if one is made: which captures, in which order | A composition is a choice, and whether to have a gallery at all is open above |
| 5 | The description read once more, on the page after the publish | The dry-run cannot read a private page |
| 6 | Then, and only then, the visibility, the comments subscription and "Watch all activity" of the mod and of Medieval Overhaul, Outland Core, Alpha Animals, Megafauna (`PUBLISHING.md`) | Steam, by hand, by the owner |

## Mature content checkboxes

**None of them.** The mod ships no new texture and no new content: it removes one butcher product from
existing creatures.

## Steam change notes

Written at upload time, in the Change Notes tab. Unlike the description they go out again on every update.
The workflow sends the block below as written (BBCode), read from this file at the pinned commit. **The
version stands alone on the first line**, as `PUBLISHING.md` asks.

### 1.0.0

```
[b]1.0.0[/b]

First release. Unofficial 1.6 port of SirMashedPotato and Hiroyan's "Insects don't have bones".

[list]
[*]Fixed: Medieval Overhaul renamed its namespace from DankPyon to MedievalOverhaul in 1.5; the original mod's patches named the old type, which dropped every insect's ButcherProperties extension since, including the base game's.
[*]Fixed: the Alpha Animals and Outland Core patches named two Alpha Animals classes that no longer exist, which stopped a sequence of 79 operations at its third step; 77 of them had never run.
[*]Fixed: loadFolders.xml never activated the mod's own Common folder, so its two Rim of Madness patches never loaded on any version. Removed, since Rim of Madness - Bones Unofficial Fix already covers the same ground and is alive in 1.6.
[*]Patches are now grouped by the value they write instead of one per creature, so a name missing upstream no longer silently drops the rest of a file.
[/list]

Compatible with Medieval Overhaul, Outland Core, Alpha Animals and Megafauna. Incompatible with the original mod. Safe to add to or remove from an existing save.
```

## Fail fast: the rollback target

A rollback is a **new publication**, not an unpublication: the workflow is dispatched with `ref` = the full
SHA of the last good commit and the next patch number, and the change note reads "Rolls back to <what>,
because <what failed>". The version numbers only go up and a tag that exists is refused. The CI never sends
visibility: making the item private again is a manual act of the owner on Steam.

`AUDIT.md`, `prepublished -> published`: before the `publish`, every scenario that failed has a green replay,
the gallery is done (or the owner decides against one) and the owner's manual validations are made. The
regression pass may follow.

- Scenarios that failed and were replayed green: none yet, since the suite has never played to completion.
- **The rollback target is not chosen.** The only earlier upload is the private `0.1.0` prepublication, made
  from the folder as it stood on 2026-09-23 and not from a tagged commit, so it cannot be reproduced. The
  first real target is the SHA of the `1.0.0` that passes its dry-run, written here at that moment.

## Comments on other mods' pages

`WORKSHOP_COMMENTS.md` decides; it is keyed by Workshop id. Under 1,000 characters each, a bare URL on the
last line, to post **only after item 3806768044 is public**. None of the rows below exist yet in the shared
registry: add them there when posting, not before.

| Recipient | Id | State | Reason |
|---|---|---|---|
| Medieval Overhaul | 3219596926 | already `posted` (for Flavor Text Extended - Français) | Only its `Covers` column needs this mod added; no new comment |
| Outland Core | 2755501685 | drafted below | The other bone-removal integration this mod targets |
| Alpha Animals (Sarg Bjornson) | 1541721856 | drafted below | Optional integration; high-traffic page (7,000+ comments), re-read the last page before posting |
| Megafauna | 1055485938 | drafted below | Optional integration |
| Rim of Madness - Bones Unofficial Fix | 3252977437 | drafted below | Cited by name in the description as deliberately not duplicated |
| Insects don't have bones (SirMashedPotato) | 2041677515 | drafted below | The mod this one is a port of, declared incompatible and played by the pass `incompat-original` |

### Outland Core, 2755501685

```
Hello Neronix17! 🦴

Thank you for Outland Core: I ported SirMashedPotato and Hiroyan's "Insects don't have bones" to 1.6 as Insects don't have bones Renew (unofficial), and it uses your Outland_BoneAmount stat to keep insects boneless the same way it already worked for Medieval Overhaul. Your code is unchanged; this is only a patch that targets it.

Credited to you throughout, and if you would rather it did not exist, just say so and it comes down. Thank you for the framework 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806768044
```

### Alpha Animals, 1541721856

```
Hello Sarg Bjornson! 🦂

Thank you for Alpha Animals: I ported SirMashedPotato and Hiroyan's "Insects don't have bones" to 1.6 as Insects don't have bones Renew (unofficial), which keeps Hiroyan's original list of your goo, spores, jellies and carnivorous plants boneless under Medieval Overhaul and Outland Core. Nothing of your mod is changed; only a patch targets it.

Credited to you and the Alpha team throughout, and if you would rather it did not exist, just say so and it comes down. Thank you for the animals 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806768044
```

### Megafauna, 1055485938

```
Hello Spino! 🦂

Thank you for Megafauna: I ported SirMashedPotato and Hiroyan's "Insects don't have bones" to 1.6 as Insects don't have bones Renew (unofficial), which keeps your Arthropleura, Meganeura and Pulmonoscorpius boneless under Medieval Overhaul and Outland Core, the same rule the base game's insects get. Nothing of your mod is changed; only a patch targets it.

Credited to you throughout, and if you would rather it did not exist, just say so and it comes down. Thank you for the creatures 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806768044
```

### Rim of Madness - Bones Unofficial Fix, 3252977437

```
Hello Sihv! 💀

Thank you for keeping Rim of Madness - Bones alive: I ported SirMashedPotato and Hiroyan's "Insects don't have bones" to 1.6 as Insects don't have bones Renew (unofficial), and it deliberately leaves your Rim of Madness patches out — you already cover the same insects, Megafauna and Alpha Animals, so my mod's description tells players to use yours instead of running both.

Credited to you and the Rim of Madness team, and if you would rather it did not exist, just say so and it comes down. Thank you for keeping the fix alive 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806768044
```

### Insects don't have bones, 2041677515

```
Hello SirMashedPotato! 🐛

Thank you for Insects don't have bones: I ported it to 1.6 as Insects don't have bones Renew (unofficial). Medieval Overhaul renamed the class your patches target back in its 1.5 build, which had been silently dropping every insect's ButcherProperties since; I fixed the namespace, repaired two other dead references in the Alpha Animals and Outland Core files, and grouped the patches so one broken name can no longer take the rest down with it.

Credited to you and Hiroyan throughout, and if you would rather it did not exist, just say so and it comes down. Thank you for the mod 💛

https://steamcommunity.com/sharedfiles/filedetails/?id=3806768044
```
