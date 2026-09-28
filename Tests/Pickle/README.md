# Pickle suite for Insects don't have bones Renew

In-game scenarios for a mod that ships six XML patches and no code. **Written and checked offline; never played.**
`../../TESTING.md` says what is proved without the game and what only a running game can show; this suite is
the second half. Nothing in this folder is part of `Mod/`, which is what Steam receives whole.

## What is asserted

The mod patches abstract bases, so the result each concrete animal ends up with is only known once the game
has resolved inheritance and every other mod's patches. The suite asks the game for exactly that: it generates a
fresh adult of a pawn kind, asks for its butcher products the way the butchering job does
(`Pawn.ButcherProducts`, which Medieval Overhaul and Outland Core both patch), and reads the list.

| Feature | Passes | Asserts |
| --- | --- | --- |
| `01-the-mod-loads` | every pass but `incompat-original` | the mod is loaded and PickleTools' load audit finds nothing of it in the game log since startup |
| `02-minimal-pass` | `minimal` | neither integration nor animal mod is loaded; a vanilla insect still butchers into meat. Nothing about bones: with no bone mod there is nothing to suppress |
| `03-base-insects` | every integration pass | Megaspider, Megascarab and Spelopede yield meat and no bone; under Medieval Overhaul they keep their fat |
| `04-alpha-animals` | passes with Alpha Animals | six creatures, one per way the patch reaches one, yield meat and no bone; the two of the no-fat list yield no fat, the four of the fat list keep it (Medieval Overhaul only) |
| `05-megafauna` | passes with Megafauna | Arthropleura, Meganeura and Pulmonoscorpius yield meat and no bone, and keep their fat under Medieval Overhaul |
| `06-controls` | every integration pass | a muffalo and a cow still yield the bone mod's bone, and its fat under Medieval Overhaul: the proof that a missing bone elsewhere is the patch and not a bone mod that does nothing |
| `07-original-mod-incompatibility` | `incompat-original` | with the original beside it, the game still logs the class Medieval Overhaul renamed. Green means the declared incompatibility still holds |

Every butchering scenario asserts **meat first**: a bone can only be suppressed if it would have been produced,
and the bone mods only produce one for an animal that yields meat. Without that line a creature that yields
nothing would pass as "no bone" with the mod having done nothing.

Local steps, all prefixed "Insects Have No Bones Renew: ": `Source/ButcherSteps.cs` (six) and
`Source/LoggedMessageSteps.cs` (one, for the log). PickleTools' `LoadAudit` is the only shared tool.

## Passes

Five, one request each, language English (the mod owns no player-facing text, so there is no French pass).
Deposit each with `Rimworld-Ticket-Dispatcher/scripts/Submit-PickleRun.ps1 -Mod InsectsHaveNoBonesRenew
-Owner local_<session id> -Label "<what is tested>, <short sha>"` and the arguments below. **An exploration or a fix
plays as little as possible**, `-Filter '::<scenario name>'`; a first or final validation plays every scenario of
its pass. The exclusions below are not a subset chosen to save time: they keep out what makes no sense in that pass.
Read `../../../AUDIT.md` and `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` first: the machine has one RimWorld and no
session launches it.

```text
# minimal
-DepMap wsl-deps.minimal.map -Language English -Filter "Insects don't have bones Renew - Pickle tests,!@integration" -EvidenceDir InsectsHaveNoBonesRenew/Tests/Pickle/Evidence/minimal

# Medieval Overhaul, Alpha Animals, Megafauna
-DepMap wsl-deps.mo.map -Language English -Filter "Insects don't have bones Renew - Pickle tests,!@minimal-only" -EvidenceDir InsectsHaveNoBonesRenew/Tests/Pickle/Evidence/mo

# Outland Core, Alpha Animals, Megafauna: the fat scenarios are Medieval Overhaul's, so they are left out
-DepMap wsl-deps.outland.map -Language English -Filter "Insects don't have bones Renew - Pickle tests,!@minimal-only,!@mo" -EvidenceDir InsectsHaveNoBonesRenew/Tests/Pickle/Evidence/outland

# both integrations together
-DepMap wsl-deps.both.map -Language English -Filter "Insects don't have bones Renew - Pickle tests,!@minimal-only" -EvidenceDir InsectsHaveNoBonesRenew/Tests/Pickle/Evidence/both

# the original mod beside it
-DepMap wsl-deps.incompat-original.map -Language English -Filter '07-original-mod-incompatibility' -EvidenceDir InsectsHaveNoBonesRenew/Tests/Pickle/Evidence/incompat-original
```

Expected counts, each row of an `Examples` table counted as a scenario. Check them against what the report says it
discovered and played, and read `exitReason` before the counts.

| Pass | Plays | Skipped by requirement |
| --- | --- | --- |
| `minimal` | 3: `01`, `02` x2 | `07` |
| `mo` | 29: `01`, `03` x6, `04` x12, `05` x6, `06` x4 | `07` |
| `outland` | 15: `01`, `03` x3, `04` x6, `05` x3, `06` x2 | `07` |
| `both` | 29, as `mo` | `07` |
| `incompat-original` | 1: `07` | none |

A skipped scenario is not a passed one: `04` and `05` are skipped wherever their mod is not staged, and each has to
have run in a pass that gives it its condition. `07` is skipped in every pass but its own.

## Before the first run, and what nobody has checked

Written on 2026-09-28. Every line below is open until a run settles it.

- **Medieval Overhaul and Outland Core came from the WSL cache**, downloaded through `Use-Wsl.ps1` on 2026-09-28: the
  Windows Workshop folder no longer holds them. Their hard dependencies were read from their About.xml on that day
  and are in the maps (Vanilla Expanded Framework, [SYR] Processor Framework, Tabula Rasa); if a dependency of theirs
  changes, the staging stops on `no Workshop id known for ...`.
- **Outland Core's bone is recognised by a name.** A product whose `defName` contains "Bone". If it is named
  otherwise, `06-controls` goes red first. Medieval Overhaul's `DankPyon_Bone` and `DankPyon_Fat` come from its
  decompiled `DefOf` class (1.6 assembly, read on 2026-09-05).
- **The animal is butchered alive and unspawned**, not as a corpse, by a call to `Pawn.ButcherProducts`. Medieval
  Overhaul's consumer was read as a postfix on that method; Outland Core's was read only as far as its stat check.
  Whether both act on an unspawned live pawn was not observed.
- **The `test-colony` fixture** is assumed to exist in the installed Pickle, as other suites of this collection use it.
- **Outland Core's bone multiplier** is left at its default. `06-controls` asserts that a muffalo still yields a
  bone, which fails if the default multiplier makes it nothing.
- **Which creature yields meat.** Every Alpha Animals and Megafauna sample was chosen because the game generates
  meat for a flesh animal, not because it was seen. A red on `holds meat` means the sample cannot discriminate and
  should be replaced, not that the mod failed.

## Checks that need no game

```powershell
powershell.exe -ExecutionPolicy Bypass -File Tests/Pickle/Check-Steps.ps1
```

Every step line of every feature resolves to exactly one step, and every local pattern compiles (2026-09-28: 7
local patterns, 48 step lines, all resolved). Build the step assembly before a run, since Pickle loads it when the
game starts and a stale one tests the previous code:

```powershell
dotnet build Tests/Pickle/Source -c Release
```

The DLL lands in `Mod/Pickle/Assemblies/` and is not tracked. Passes, filters, evidence to keep and the conditions for
`tested` are in `../../TESTING.md`.
