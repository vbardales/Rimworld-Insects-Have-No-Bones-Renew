# Final functional validation

Status (2026-10-02): **no row below is left as a manual check.** Each is either played by the Pickle suite
(`Tests/Pickle/`, five passes, see `TESTING.md`) or listed as not applicable with its reason, in the
"Disposition" table at the end of this file. The table is kept as the statement of what the suite and the
exclusions must cover. The automated offline checks do not certify it on their own: a row counts only once its
Pickle scenario has a green report on the revision being tested (`STATUS.md` says where each stands).
Record game/dependency versions, mod order, language, save provenance, actual results
and log evidence for each run. Use copied saves and record results outside Mod/.

## Preconditions

- RimWorld 1.6; this mod after each installed integration and animal mod.
- Install each integration's own mandatory dependencies. Disable the original
  Insects Have No Bones. Use a minimal mod list before broader compatibility runs.
- Exercise Medieval Overhaul only, Outland Core only, both, and neither. For each,
  exercise Alpha Animals absent/present and Megafauna absent/present (16 combinations).
- Keep dependency settings identical between baseline and mod-enabled runs. For
  Outland use a nonzero bone multiplier so the comparison has a meaningful control.
- Generate fresh adult corpses with usable meat and butcher them under controlled
  efficiency. Compare against a baseline without this mod; repeat if randomness
  could obscure the result. Do not infer behavior from the stat display alone.

| Scenario | Actions | Expected result |
| --- | --- | --- |
| Startup and guards | Start each combination; inspect startup log and spawn supported animals. | No errors attributable to this mod; absent integrations are skipped; vanilla insects remain available. |
| Vanilla insects | Butcher megaspider, megascarab and spelopede. | No MO or Outland bones from installed integrations; MO fat retained when the dependency's flesh/meat conditions permit it. Ordinary meat remains. |
| Inherited insects | With Alpha Animals active, butcher an animal inheriting AA_AlphaBaseInsect and one inheriting BaseInsect2; record exact defNames. | Effective inherited values agree with the patch rule; no bones and MO fat retained for eligible animals. |
| Explicit fat group | With Alpha Animals active, butcher AA_AngelMoth and AA_Agaripawn. | No integration bones; MO fat retained when eligible. |
| No-fat group | With Alpha Animals active, butcher AA_Aerofleet and AA_GreenGoo. | No integration bones and no MO fat; compare ordinary products to baseline. |
| Megafauna | Butcher Arthropleura, Meganeura and Pulmonoscorpius. | No integration bones; MO fat retained when eligible. |
| Non-target controls | Butcher a muffalo and cow with otherwise identical setup. | This mod does not change their products; bone-generating dependency remains functional. |
| Both integrations | Repeat representative insect, no-fat and control cases with both loaded. | Neither integration restores bone for patched animals; unrelated products remain consistent with baseline. |
| No integrations | Load with neither MO nor Outland and compare animals/products to baseline. | No effective changes and no patch errors. |
| English/French | Repeat startup and representative butcher cases in English and French. Inspect mod options and main buttons. | No empty settings page or shortcut from this mod; no unresolved owned strings. Dependency-owned text issues recorded separately. |
| New colony | Run representative cases in a new colony with the mod active from creation. | Expected behavior and clean relevant logs. |
| Existing save | On a copy, load a save created without this mod, enable it, repeat cases, save/restart/reload, then remove it and reload another copy. | No save-load errors attributable to this mod; changes apply while enabled and baseline behavior returns after removal. No mod-owned persistent settings exist. |
| Broader mod list | After minimal-list success, repeat representative cases under the intended normal mod list and order. | No later patch or duplicate/inherited extension defeats the expected effective values; failures identify the conflicting mod/order. |

## Evidence and automated scope

`Tests/Audit-Xml.ps1` checks selectors against installed Def files.
`Tests/Audit-PatchEngine.ps1` executes actual game patch methods on those files,
with operations loaded through native DirectXmlToObject and profiling disabled only in the
test process. It checks folder activation, payloads and untouched control Defs.
Neither test deserializes complete Def objects, applies all dependency patches,
resolves inheritance, runs the butchering pipeline or starts the game.

Example invocation (supply actual installation directories):

```powershell
./Tests/Audit-PatchEngine.ps1 -Game <game-directory> -Workshop <workshop-294100-directory>
```

## Disposition of each row (2026-10-02)

The rows above name `AA_Agaripawn` and `AA_GreenGoo`; both failed the "holds meat" precondition in the game and
were replaced in the suite (`Tests/Pickle/README.md`, `04-alpha-animals.feature`). A row below is
**automated** when a Pickle scenario asserts it, and **not applicable** when nothing a test could add remains,
with the reason.

| Row | Disposition | Where |
| --- | --- | --- |
| Startup and guards | Automated | `01-the-mod-loads` in every pass (PickleTools `LoadAudit`: nothing the mod owns in the log since startup). Folder activation and guards for all 16 combinations: `Tests/Audit-PatchEngine.ps1`, offline |
| Vanilla insects | Automated | `03-base-insects`, passes `mo`, `outland`, `both` |
| Inherited insects | Automated | `04-alpha-animals`: `AA_Animalisk` (`AA_AlphaBaseInsect`), `AA_BlackSpider` (`BaseInsect2`) |
| Explicit fat group | Automated | `04-alpha-animals`: `AA_AngelMoth`, `AA_Bumbledrone` keep their fat (passes with Medieval Overhaul) |
| No-fat group | Automated | `04-alpha-animals`: `AA_Aerofleet`, `AA_RedSpore` yield no fat (passes with Medieval Overhaul) |
| Megafauna | Automated | `05-megafauna`, passes with Megafauna |
| Non-target controls | Automated | `06-controls`: a muffalo and a cow still yield the bone mod's bone |
| Both integrations | Automated | pass `both` |
| No integrations | Automated | pass `minimal` (`02-minimal-pass`) plus the offline engine test with both folders inactive |
| English/French | Not applicable | The mod owns no player-facing text, no setting and no shortcut (`STATUS.md`, settings and translation inventories). There is nothing to display in a language, so the suite has no French pass |
| New colony | Not applicable | The patches act when Defs load, before any colony exists; a new colony and a loaded one read the same Defs. The suite loads a fixture colony and generates its own pawns |
| Existing save | Not applicable | The mod adds a `DefModExtension` to Defs and sets a stat value on Defs. It adds no Def, no `Comp`, no `Hediff`, no saved field; a save has nothing to read from it and nothing to lose when it goes. Adding and removing is the same Def-load difference as starting a new game |
| Broader mod list | Not applicable | No repeatable test: "the intended normal mod list" is not a defined set. The `both` pass already loads all four optional mods together. A conflict from a later patch shows as a failed scenario or a player report, not as a case to enumerate |
