# Testing

This mod ships XML patches and no code. Almost everything about it can be proved without starting the
game, and that part is done. What remains is what only a running game can show, and it is planned here
but **not written and not played yet**. Nothing below is a claim that a pass has run.

`TEST_SCENARIOS.md` is the human-readable list of the final in-game checks. This file says which of them
become Pickle scenarios, in how many passes, and what to keep afterwards.

## What is established without the game

| Check | Command | What it proves | What it does not |
| --- | --- | --- | --- |
| `Tests/Audit-Xml.ps1` | `./Tests/Audit-Xml.ps1 -Game <RimWorld> -Workshop <workshop 294100>` | All 8 XML documents parse, the 11 XPath expressions compile, and every selector matches the intended number of nodes in the real 1.6 Def files of Core, Alpha Animals and Megafauna (24 checks, 4 combinations) | Patch application, inheritance, butchering |
| `Tests/Audit-PatchEngine.ps1` | same parameters | The patches deserialize through the game's own loader and apply through the game's own `PatchOperation.Apply` (16 combinations, 48 top-level calls): folder activation, payloads, no duplicate extension or stat, untouched control Defs | Complete Def loading, final inheritance, other mods' patches, butchering |
| `scripts/Check-DefRefs.ps1`, `Check-XmlClasses.ps1`, `Check-XmlFields.ps1` | run from the monorepo, against this `Mod/` | No dangling reference, the five referenced classes resolve, every element maps to a 1.6 field | Runtime behaviour |

Both scripts need the Medieval Overhaul and Outland Core assemblies and the two animal mods installed in
the Workshop folder. Results are kept in `Tests/Audit-Xml-results.txt` and
`Tests/Audit-PatchEngine-results.txt`. A result is only valid for the delivered patch files: the local
manifest `Tests/Audit-artifacts.json` (ignored by git) holds their SHA-256, and a result older than a
change to one of them proves nothing.

## What only a running game can show

1. **The effective result of butchering.** Whether a megaspider, an Alpha Animals goo, an Arthropleura
   actually yields no bone under Medieval Overhaul (and no fat where the rule says so), and no bone under
   Outland Core, with ordinary meat unchanged. The consumers were read in the assemblies; the products were
   never observed.
2. **Final inheritance.** The patch is applied to abstract bases, so what each concrete Def ends up
   with, after every other mod's patches, is only known once the game has resolved it.
3. **Adding and removing the mod on an existing save.**

Everything else is offline. The game's own reaction to a declaration (the incompatibility warning, the
load order it computes) is not tested: the mod answers for what it declares, which is checked in the sources.

## Pass plan: five passes

`Tests/Pickle/wsl-deps.<name>.map` files are written, none played; each pass is one request to the dispatcher
(`Submit-PickleRun.ps1 -DepMap wsl-deps.<name>.map`), language English. Workshop ids: Medieval Overhaul
`3219596926`, Outland Core `2755501685`, Alpha Animals `1541721856`, Megafauna `1055485938`, the original
mod `2041677515`. The hard dependencies of Medieval Overhaul and Outland Core themselves are not copied by
the staging script and are to be named in the map when it is written.

| # | Pass | Mods mounted with this one | What it covers |
| --- | --- | --- | --- |
| 1 | `minimal` (no `-DepMap`) | none | The mod alone: it loads clean, both integration folders stay inactive, vanilla insects are unchanged |
| 2 | `mo` | Medieval Overhaul, Alpha Animals, Megafauna | The `ButcherProperties` rule on base insects, both Alpha Animals groups, the three Megafauna arthropods, and the non-target controls |
| 3 | `outland` | Outland Core, Alpha Animals, Megafauna | The `Outland_BoneAmount` rule on the same animals, with a non-zero bone multiplier so the comparison has a meaningful control |
| 4 | `both` | Medieval Overhaul, Outland Core, Alpha Animals, Megafauna | Neither integration restores bone for patched animals when both are loaded |
| 5 | `incompat-original` | Medieval Overhaul, the original mod | Whether the declared incompatibility still holds: the original still names `DankPyon.ButcherProperties`. The scenario asserts the symptom (an error matching the missing type, tagged `@allow-errors`), so green means "still behaves as declared" |

Not run, with the reason: a pass per absent-animal-mod combination (the 16 combinations are covered offline by
`Tests/Audit-PatchEngine.ps1`, and the guards are a def test, not a game behaviour); a French pass and a
restart pass (the mod owns no player-facing text and no setting, see `STATUS.md`, so there is nothing to
translate or persist); a pass without a DLC (nothing here depends on one).

## The Pickle suite

Written on 2026-09-28 in `Tests/Pickle/`, **not played**: seven features, thirty-two scenarios, one local C# step
assembly (six butcher steps and one log step) and five pass maps. Its `README.md` has the passes' filters, the
expected counts and the list of what nobody has checked. `Tests/Pickle/Check-Steps.ps1` proves offline that every
step line resolves to exactly one step. The one real piece of work in it is the step that butchers a pawn and
reads the products, since none existed. It asserts meat first, so a suppressed bone is never confused with an
animal that yields nothing, and a muffalo and a cow as controls, so a missing bone is never confused with a bone
mod that does nothing.
## When this mod can be called `tested`

Cumulative conditions, on top of the ordinary ones in `AUDIT.md`:

- No scenario is left in `@wip`: a set-aside scenario is repaired and replayed, or deleted with its reason.
- Every conditional scenario ran. Each `@requires:<packageId>` had its own pass, with the mod mounted, and
  its report was read (`setName`, suite name and scenario names checked before quoting it: the report folder
  is shared by the whole machine). A scenario skipped for lack of its condition is not a passed scenario.
- No manual check is left to tick: each is either automated and green, or listed as not applicable with
  its reason. `@review` captures still get looked at, but they only show what a scenario already asserted.
- `exitReason` is read before the counts, and scenarios played are compared with features discovered.

## Evidence to keep

Launch with `-EvidenceDir Tests/Pickle/Evidence/<date>-<short sha>-<pass>`. That folder is ignored by git
and lives on disk only; the disk is short and a shared report folder has reached gigabytes.

Keep, per pass and per scenario, **only the latest report for the revision now in the repository**, plus an
older one only if it is the sole proof of a check the latest run did not repeat.

| Keep | Why |
| --- | --- |
| `summary.json`, `summary.md`, `junit.xml`, `Player.log`, `evidence-complete.txt` (or `no-report.txt`) | The verdict and the per-step outcome; read `exitReason` first |
| `@review` captures that were actually opened, minified to JPEG | The human review outcome |
| One line in `docs/runs/` | The history: date, SHA, pass, verdict, folder |

Delete: `report.html` and `messages.ndjson` of a stale build, any `screenshots/` folder copied whole, a
report of a failed or infrastructure-error attempt once its cause is written in `STATUS.md`, a report
superseded by a newer one for the same scenario and revision, and any report of a superseded build. Never
delete a report a `STATUS.md` field still points to: repoint it first. Take what you need from your own
run's archive in `pickle-reports-archive/`, then delete that archive.
