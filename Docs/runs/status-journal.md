# STATUS journal (moved from STATUS.md, 2026-10-11)

## Historical sweep notes (preserved)

Read by a sweep across every mod, rather than by asking each thread in turn. It lives at the
root, never inside `Mod/`, so Steam never receives it.

The fields above were read off the disk on 2026-09-12. Four cannot be, and wait for whoever
holds this mod:

- **`stage`** — one of `port`, `showcase`, `preTest`, `done`, `tested`, `published`. Filled in
  from the session group where one exists; confirm it.
- **`tested_on`** — the date of the last run in game. Empty means never.
- **`dependencies`** — `declared` when every mod this one needs is named in the About's
  `modDependencies`, `to check` when a non-vanilla `loadAfter` suggests a dependency that is not
  declared, `none` when the mod needs nothing. An undeclared dependency is not cosmetic: on
  2026-09-11 Reequilibrage animaux took 47 vanilla animals down with it, Muffalo included, because
  the class it injects belongs to a mod that was not declared and not loaded.
- **`remaining`** — what is left, in three kinds: `feature` for something missing from a first
  release, `defect` for a known fault left unfixed, `unverified` for what could not be checked.
  The line already there is true of nearly the whole repository; replace it once it stops being.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source,
`alive` no licence but a living source, `forbidden` a written refusal, `original` owing nothing
to anyone — not a name, not an idea traceable to one mod, not a value derived from its assets.


## Workflow audit — 2026-09-13

Audited monorepo HEAD: `7845c3f59b59534972aaebc8a6e976838d94eb85`.
Scope: `C:\Users\nelim\Documents\rimworld\InsectsHaveNoBones`; delivered folder: `Mod/`.
`git rev-parse --show-toplevel` resolves to `C:/Users/nelim/Documents/rimworld`,
not this mod directory. No standalone `.git` exists here. The installed RimWorld
`Mods/InsectsHaveNoBones` junction points to this exact `Mod` folder.
Before the audit, the only local change within this mod was STATUS.md: three
unchecked localization fields. It is preserved and updated by this audit. Other
monorepo changes were left untouched. This audit changes STATUS.md and adds only
Tests/Audit-Xml.ps1, its results and an SHA-256 manifest of the eight delivered XML
files. No delivered mod file was edited, no image generated, no commit or publication made.

Previous stage: empty (undeclared), not a certified advanced stage.
Retained stage: `dansMonoRepo`, using the requested literal workflow vocabulary.
Order: dansMonoRepo -> horsMonoRepo -> ModIcon generated -> Preview generated ->
preOptions -> options -> l10n -> preTest -> done -> tested. This replaces the old
sweep's suggested codes for this audit. Later independent checks do not advance
past an unmet earlier gate.

| Transition | Result and evidence |
| --- | --- |
| dansMonoRepo -> horsMonoRepo | Not passed: the delivered project is still in the monorepo, without its own Git checkout/remote. GitHub existence, visibility and initial pushed commit remain unverified, not absent by inference. English README, ATTRIBUTION, LICENSE and CHANGELOG exist; delivered LICENSE and ATTRIBUTION are byte-identical to root copies. The licence explanation is inconsistent with explicit upstream permission (below). |
| horsMonoRepo -> ModIcon generated | Not passed: Mod/About/ModIcon.png absent. Build and compiled artifacts are not applicable: six XML patches, no C# source, project or assemblies. Full current integration correctness is not certified by the selector tests. |
| ModIcon generated -> Preview generated | Not passed: Mod/About/Preview.png absent. No visual inspection claimed. |
| Preview generated -> preOptions | Description is English, and the packageId is version-free and coherently identifies this folder/repository; literal equality of their names is unnecessary. Defect: description ends with credits, not the required `[url=...]Source code on GitHub[/url]`. Its URL and About/url identify the same intended repository only through the latter; an autonomous remote cannot yet be compared. Preview palette, title typography and linking-word treatment cannot be inspected without an image. No `unofficial` suffix is required under the corrected open classification. |
| preOptions -> options | Independently passed as justified settings_audit: not_applicable; see inventory below. |
| options -> l10n | Independently passed as justified not_applicable for all three fields; see inventory below. |
| l10n -> preTest | Metadata/conditional-folder audit passed independently. No unconditional third-party requirement: inactive integrations load no patches. Current runtime class resolution remains a technical verification pending below. |
| preTest -> done | Not passed: automated XML selector checks executed successfully, but full patch application/class-field verification remains unverified and final functional scenarios are absent. Historical README claims retained, not promoted to current results. |
| done -> tested | Not verified: no game run, log review, FR/EN interaction, new-game or existing-save scenario executed in this audit. |

### Repository and rights

`gh repo view vbardales/Rimworld-Insects-Have-No-Bones-Renew --json nameWithOwner,isPrivate,url,defaultBranchRef`
could not read the GitHub CLI configuration in the sandbox. The read-only escalation
was rejected by automatic approval review, which reported a usage limit; no GitHub
result was returned. `visibility: public` is the documented intended classification,
not a verified remote setting. A missing monorepo remote is not used as a defect.

The [original author's Steam page](https://steamcommunity.com/sharedfiles/filedetails/?id=2041677515)
was retrieved during the audit (the web provider labels its snapshot as crawled eight
months ago). Its description explicitly says: “Contents of this mod are free to use
in other mods.” The author also confirms reuse in the displayed November 21, 2024
comment. This establishes an explicit permission rather than silence under
PUBLISHING.md; `licence: open` records that workflow category, not an invented MIT
licence for the original. Keep the original authors' credits and the existing
removal commitment. The installed source About.xml lists 1.3/1.4/1.5 and has no URL.

Confirmed documentation defect: root and delivered ATTRIBUTION claim that the Steam
body contains no permission, and LICENSE commentary says none can be granted. These
claims conflict with the retrieved author statement and must be reconciled, including
the adoption/permission scope where necessary. MIT remains limited to the port's own
contributions; upstream permission does not turn third-party lists into MIT work.
ATTRIBUTION also claims a removal clause exists in About's description; it does not
(the commitment is present in LICENSE). No unsupported consent disclaimer should be
added merely to preserve the obsolete silent classification.

### Settings audit

Inventory covers all eight XML documents and all six conditional patches. Their
only behavior is adding MedievalOverhaul.ButcherProperties with fixed hasBone/hasFat
values, or setting Outland_BoneAmount to zero on selected animal definitions.
These values implement the mod's single advertised rule; they are not an existing
manual configuration interface. Optional behavior is selected by installed mods via
LoadFolders and def-presence guards. No meaningful separate player setting was
identified. The patch payloads contain no UI or inherited settings implementation;
no source/assembly, settings page, MainButtonDef or shortcut is shipped.

Decision: not_applicable. This is based on behavior and full payload inventory,
not merely absence of C#. Settings defaults, input bounds, persistence, shared access
and RIMMSQOL tests are therefore not applicable. No customization integration was
tested or claimed. Per the user's overriding rule, game interaction is not required
to pass this no-settings gate. Actual patch behavior still awaits game validation.

### Translation audit

After the settings inventory, inspect every loaded patch payload: only booleans,
a stat value, class names and def identifiers are added. No labels, descriptions,
messages, generated strings or other player-facing text are added or changed.
The stat's name belongs to Outland and is not replaced by this mod. No owned keys,
format parameters, grammar tokens or DefInjected paths exist to validate.
About metadata and English repository documentation are excluded by TRANSLATIONS.md.
Thus localization, translation_en and translation_fr are not_applicable; creating
redundant language files would not add coverage. Check-DefInjected is inapplicable.
FR/EN game checks remain unverified for the final tested gate.

### Dependencies and executed checks

Installed metadata checked directly: Alpha Animals 1541721856, Megafauna 1055485938,
Outland Core 2755501685 and Medieval Overhaul 3219596926 (declares mod version 1.6.2.2).
All declare RimWorld 1.6; package IDs match About/loadAfter, and the two integration
IDs match LoadFolders/IfModActive. All three declared load folders exist. Alpha and
Megafauna are optional def-guarded integrations; the original mod is incompatible.
No mandatory dependency on Harmony or a customization mod is introduced by this
XML-only mod. Dependency requirements of the optional mods remain theirs.
Outland_BoneAmount exists in Outland's 1.6/Defs/StatDefs/Stats_Bones.xml.

Executed:

- XML parsing of all eight files and compilation of all eleven XPath expressions: pass.
- `../scripts/Check-DefRefs.ps1 -ModPath <this mod>/Mod -Brief`: pass; zero owned defs,
  no malformed XML, unresolved ordinary references or ParentName. This script's clean
  result alone does not verify XPath strings or third-party classes.
- `Tests/Audit-Xml.ps1`: pass, 24 file/combination checks against real Core, Alpha Animals
  1.6 and Megafauna 1.6 Def XML, before inheritance. With both optional animal mods,
  matches are 61/16 for MO Alpha, 77 for Outland Alpha, 3 for Megafauna and 1 for
  BaseInsect. Absent optional animal defs yield zero matches in the guarded selectors.
  Outland selectors include /statBases, verifying those target nodes actually exist.
  See `Tests/Audit-Xml-results.txt`. This does not execute PatchOperation.Apply,
  inheritance, third-party patches, extension selection or butchering behavior.
- SHA-256 of the eight delivered XML artifacts: `Tests/Audit-artifacts.json`.
- Root/distributed LICENSE and ATTRIBUTION hashes: equal. `git diff --check -- .`: pass.

Check-XmlClasses and Check-XmlFields were inspected but not executed with current
complete dependency metadata. Their historical success remains in README; it is not
current class/field validation. No runtime defect is inferred from missing execution.
The game is installed; an interactive game test session was not performed.

### Strict next transition and optional recommendations

To reach horsMonoRepo: establish the standalone repository serving the delivered mod,
configure its GitHub remote, verify repository visibility and a pushed first commit,
and reconcile the rights documentation with the author's explicit permission,
keeping required distributed copies synchronized. Do not treat an inaccessible remote
as a nonexistent repository; inspect it before deciding whether creation is needed.
Images and in-game testing belong to later transitions, not this immediate gate.

Optional recommendation: retain the reproducible selector regression check and rerun
it when the relevant upstream animal definitions change. No visual reserve is raised
about images that do not exist, and no historical generation report is required.

## Detachment completed — 2026-09-13

Current stage: `horsMonoRepo` (previously `dansMonoRepo`). This section supersedes
repository and rights blockers in the historical audit above. Image and functional
verification gates remain pending; no gameplay files changed during detachment.

- Verified with authenticated `gh repo view`: the existing repository is public,
  `vbardales/Rimworld-Insects-Have-No-Bones-Renew`, default branch `main`.
- Preserved its existing published commit
  `72e4870867e9422dadb956cd517adf1854fe38ea`. Before documentation edits, every
  tracked file in this checkout matched that remote tree; STATUS and Tests were
  local audit additions. No history rewrite or repository recreation was needed.
- Installed the existing Git history in this directory. `git rev-parse --show-toplevel`
  now resolves to the mod itself; `origin` points to the exact repository above.
- Removed this mod from monorepo tracking and added its ignore rule, in isolated
  monorepo commit `643e3791c280f338643c2f09244c232c9781a087`. No physical move:
  the game junction continues to resolve to this mod's `Mod` directory.
  Unrelated staged and unstaged monorepo work was excluded from that commit.
- Corrected root/distributed ATTRIBUTION and LICENSE and README to cite the
  author's explicit permission, preserve attribution and removal on request,
  and keep MIT limited to the port's own contributions. Copies were verified equal.
  The licence remains `open`; no unofficial disclaimer is warranted by these rights.
- Added repository-local ignore and text/binary rules, and documented the changes
  in CHANGELOG. Historical audit findings remain above, with their original date.

Validation: reran Tests/Audit-Xml.ps1 successfully; checked all eight delivered XML
SHA-256 values against the audit manifest; checked required document copies and
`git diff --check`. Settings and translation inventories remain valid because no
patch, UI or player-facing text changed. The first published commit already meets
the pushed-commit criterion; the documentation/audit update is committed on top.

Next transition: complete current integration/class-field verification as applicable,
then generate and install a conforming Mod/About/ModIcon.png. No image generation
or final game test was included in this detachment step.

Public handoff: automatic approval review rejected publishing local machine paths. STATUS.md and the local absolute-path artifact manifest are retained locally and ignored by Git. The public selector test now requires explicit Game and Workshop paths. Only portable tests/results and mod documentation are included in the public update. The workflow status remains available in this local STATUS.md.


Delivery verified: commit 5418b10146c7763fe1b8f06ff6e26ed9c88ebf36 pushed to origin/main; git ls-remote returns the same SHA. The tracked standalone working tree is clean. STATUS.md and Tests/Audit-artifacts.json remain local and ignored. The sanitized public push passed automatic approval review.

## Technical verification continued — 2026-09-13

Revision: `5418b10146c7763fe1b8f06ff6e26ed9c88ebf36`, plus new test/scenario files.
Delivered XML hashes still match Tests/Audit-artifacts.json: no runtime payload edits.
Stage remains `horsMonoRepo`: this work does not supply the missing ModIcon.
The following results supersede the earlier pending class/field checks, but do not
certify the complete runtime loading or butchering pipeline.

Environment: installed RimWorld `1.6.4871 rev590`; Medieval Overhaul declares 1.6.2.2.
Game, MedievalOverhaul.dll and Outland.dll SHA-256 values are recorded locally in
`build/audit/assembly-hashes.json`. Upstream DLLs and decompiled snippets stay local.

### Completed controls

- Ran Check-XmlFields.ps1 with the installed MO and Outland assemblies: zero
  unknown fields. Crucial limitation: this checker skips Patch roots. Therefore
  its Walk function was also invoked explicitly on every ButcherProperties payload;
  zero payload field problems. Reflection confirms the DefModExtension base and
  both boolean fields. The installed type has defaults true/true by code inspection.
- Built a type-name inventory from the loaded game/dependency assemblies and ran
  Check-XmlClasses.ps1: all five XML-referenced classes resolved. Unrelated types
  that could not load outside the game were not treated as evidence of completeness;
  all five actually referenced types were resolved.
- Added and ran Tests/Audit-PatchEngine.ps1 against real Core/Alpha Animals/Megafauna
  Def XML. All 16 integration/animal combinations passed, totalling 48 top-level
  calls to the installed game's PatchOperation.Apply. Nested conditional and sequence
  operations use the real game methods too. Verified folder activation, absence
  guards, written bone/fat values, no duplicate direct extension/stat on the selected
  targets and unchanged Muffalo/Cow control definitions. With no integration active,
  the entire input XML remains unchanged. Results: Tests/Audit-PatchEngine-results.txt.
- Initial harness attempt reached the game profiler, which accesses uninitialized
  live preferences outside RimWorld. Disabled DeepProfiler.enabled only in the test
  process and reran successfully; no game configuration or assembly was modified.
  Objects are populated through reflection rather than the native XML object loader.
- Inspected installed consumer methods: MO reads ButcherProperties for bone/fat
  eligibility (subject to flesh/meat checks); Outland returns without adding bones
  when computed Outland_BoneAmount is nonpositive. The installed Outland stat's
  ShouldHaveBones part is commented out, so merely finding that class in the assembly
  does not establish active insect handling. These are code-inspection findings,
  not observed butcher products. Local snippets: build/audit/*Butcher.cs and
  build/audit/Outland-ShouldHaveBones.cs.
- Rechecked all eight delivered XML hashes and git diff --check: passed.
- Wrote TEST_SCENARIOS.md with preconditions, actions and expected outcomes for
  the 16 combinations, representative animals, non-target controls, FR/EN,
  new colony, existing-save addition/removal/reload and broader mod lists.

### Remaining and exclusions

Native object deserialization, final XML inheritance, the combined upstream patch
order, live butcher products, saved games and UI were not exercised. No in-game
run or log inspection is claimed. Scenarios are written, not passed. Settings and
localization remain justified not_applicable; no player-facing content changed.
The known missing images and final description link remain separate earlier gates.
Build remains not_applicable because this mod ships XML only.

No new gameplay defect was established by these controls. Tests and scenario files
remain local working-tree additions; this verification request did not publish them.
An unrelated untracked Assets/ directory appeared during work and was left untouched.

## User-provided ModIcon and native patch loading — 2026-09-13

The user supplied Mod/About/ModIcon.png. It is a valid PNG, 1254 x 1254 pixels,
1,195,226 bytes. Its hash equals Assets/insects-have-no-bones-mascot.png; the source
is therefore preserved. Direct inspection of the full image and a 32-pixel review
thumbnail confirms the orange insect mascot remains recognizable. No visual
regeneration is warranted by this review. The crossed-bone detail is small at 32px,
but the subject silhouette remains legible.

Confirmed packaging defect: the distributed file is still the full-resolution
source, not the required 128 x 128 icon. It must be reduced for delivery. No hard
Preview size limit is being incorrectly applied to ModIcon; the dimensions are the
blocking criterion, and the unnecessary 1.20 MB is additional evidence of source
packaging. The user artwork and distributed icon were left unchanged. Local QA:
build/audit/icon-32.png and build/audit/icon-hashes.json. Preview is still absent.

Stage remains horsMonoRepo: the ModIcon transition has not yet passed its required
format/dimension check. Earlier remarks that both images are absent are superseded
by this section. Build remains not_applicable for this XML-only mod.

Further technical checks: native Verse.DirectXmlToObject.ObjectFromXml<PatchOperation>
successfully deserialized all six patch roots to their expected classes. Updated
Tests/Audit-PatchEngine.ps1 to use that native loader instead of reflection-built
operations and reran the complete matrix: all 16 combinations passed, with 48
successful top-level PatchOperation.Apply calls and expected payload/control results.
The new results are in Tests/Audit-PatchEngine-results.txt; the previous reflection
run remains in build/audit/patch-engine-results.txt. TEST_SCENARIOS.md now reflects
the stronger automated scope. DeepProfiler is disabled only within the test process.

This resolves native patch-operation deserialization, not complete Def object loading,
final inheritance or upstream patch ordering. Those, actual butcher products,
saves and FR/EN UI still require the corresponding checks. No game run is claimed.
No runtime mod XML was changed and no new files were committed or pushed this turn.

## ModIcon packaging fixed — 2026-09-13

Current stage: `ModIcon générée` (literal requested workflow state), previously
`horsMonoRepo`. The user authorized fixing the oversized delivered icon.

Resampled the existing source deterministically to 128 x 128 with high-quality
bicubic filtering; no regeneration or design change. Mod/About/ModIcon.png is
now a valid 128 x 128 PNG, 22,080 bytes. Inspected the final rendered image directly:
the insect mascot and crossed-bone emblem remain clear. The original source in
Assets/insects-have-no-bones-mascot.png is unchanged (SHA-256 checked).

This supersedes the oversized-icon blocker above. No gameplay changes were needed;
the completed technical checks remain applicable, and build is not_applicable for
this XML-only mod. Full in-game validation remains pending at its later gate.
Next transition: supply and inspect Mod/About/Preview.png. No Preview was generated
or publication performed during this packaging correction.

## Preview generated and verified — 2026-09-13

Current stage: `Preview générée`, previously `ModIcon générée`. Generated through
the built-in image_gen workflow; exact prompt in Art/generation-prompt.txt. The
original illustration is preserved in Art/Preview.png. Art/preview.html and
Art/render-preview.cjs compose the final image in Chrome through Playwright,
using Art/preview-palette.json as the single palette source.

Delivered Mod/About/Preview.png: 896 x 504 PNG, 534,144 bytes, below 1 MB.
Direct inspection covered the source, final image and 268-pixel-wide thumbnail.
The overhead camera, floor grid and low table front fit the intended framing;
no concrete camera defect was observed. The insect and butcher products are
identifiable; no bones are depicted. Title and badge remain identifiable at
thumbnail size. The summary is for full-size viewing, as permitted by the style guide.

The dark slate veil follows the floor; the blue-slate secondary follows the dominant
scene family; the amber accent follows lamp and wood lighting. Secondary and accent
are visibly distinct. Segoe UI is installed, checked, and document.fonts.ready was
awaited. The title preserves the About name, with the version suffix reduced and
secondary-colored. No linking word needs reduction; no licence tag applies.

Measured on the actual no-ink background across complete text rectangles:
minimum primary contrast 8.53:1, secondary 6.95:1, badge 8.73:1. All pass 4.5:1.
No clipped text or badge digits; the two-line title does not obscure the subject.
Local QA: build/audit/preview-no-ink.png, preview-268.png and preview-qa.json.

No mod XML, gameplay or icon changed. Independent settings, localization and patch
checks remain valid. No game run, commit or publication occurred in this turn.
The next preOptions gate still has the known missing final Source code on GitHub
link in About/description. The Preview itself and its palette are now validated.

## Ready for final in-game validation — 2026-09-13

> **Replaced on 2026-09-28.** The stage `done` recorded below no longer holds: see "Workflow audit — 2026-09-28" at the end of this file. The text is kept as history.

Current stage: `done`, previously `Preview générée`. Under the user's explicit
workflow, done means ready for final functional validation; tested requires actual
successful game scenarios. The current change is About description metadata only,
plus local records; no gameplay XML changed. Base revision remains
5418b10146c7763fe1b8f06ff6e26ed9c88ebf36 plus the documented working-tree additions.

| Newly traversed gate | Evidence |
| --- | --- |
| Preview -> preOptions | Existing image/palette QA retained. English description now ends after credits with the exact Source code on GitHub BBCode link. Target equals About/url and origin with the .git suffix normalized. Added accurate generated-preview attribution and explicit pending game validation, preserving credits and the original tools statement. |
| preOptions -> options | Prior behavior inventory remains applicable: no useful settings, no empty settings page, no MainButtons shortcut; settings_audit not_applicable. |
| options -> l10n | No owned in-game text; all three localization fields remain not_applicable. About metadata follows the English publishing rule and does not introduce translation keys. |
| l10n -> preTest | Prior installed dependency/package/version/conditional-folder checks remain applicable; integration IDs and load order unchanged. |
| preTest -> done | TEST_SCENARIOS.md supplies preconditions, actions and expected results. Both executable suites and their successful output are present: 24 selector/combination checks and 16 native-loader/engine combinations with 48 top-level Apply calls. Class and payload-field checks already passed. Build is not_applicable for XML-only content. |

Reran Audit-Xml.ps1 after the metadata change: all eight XML documents, eleven XPath
expressions and 24 selector checks passed. Verified all seven other XML hashes
against the earlier manifest: unchanged, so the native-engine tests were not
invalidated and were not needlessly repeated. Confirmed 16 successful combination
results in the native-loader log. Rechecked icon 128x128 and Preview 896x504 under
1 MB. Updated the local artifact manifest, preserving its previous version in
build/audit/artifact-hashes-before-description.json. git diff --check passed.

Complete Def loading, final inheritance and upstream patch ordering are now listed
with the final game scenarios; they are not extra undocumented gates before done.
They remain unverified, not passed or not_applicable. No game launch, save mutation,
log review or FR/EN runtime check was performed. tested_on remains empty.

Next required transition: execute TEST_SCENARIOS.md in RimWorld, inspect logs and
English/French UI, cover new colony and existing-save addition/removal/reload, and
rerun affected regressions after any fix. No commit or remote push in this turn.

## Commit and push — 2026-09-13

User-requested delivery completed: fab337275df025f6c331ebc7b3d5a2a8a459d0bd on origin/main. Remote SHA verified equal to local HEAD; tracked working tree clean. Includes artwork, composition, About metadata, native patch tests/results and game scenarios. STATUS and local audit metadata remain ignored. Removed the personal reference-file path from the public mascot prompt; original retained in build/audit/mascot-prompt-original.txt. Stage remains done; game validation pending.

## Workflow audit — 2026-09-28

Audited revision: mod repository `ffa185d` (the commit that adds `Mod/About/PublishedFileId.txt`), plus
uncommitted work by this audit: `.gitignore`, `CHANGELOG.md`, both `ATTRIBUTION.md` copies, `TESTING.md`,
`BACKLOG.md`, `docs/PROTOCOLS-READ.md`. Protocol documents read, with their versions:
`docs/PROTOCOLS-READ.md`. Previous stage `done` (2026-09-13) -> retained `showcase`
(`workflow_stage: Preview générée`), by AUDIT step 12: the first transition that fails fixes the state.

**Folder.** The project folder was renamed `InsectsHaveNoBones` -> `InsectsHaveNoBonesRenew`. A rename was
refused by the system (folder held open), so it was copied with `robocopy` (129 files, 73 folders, `HEAD`
identical on both sides, `git status` identical) and the old contents removed; an empty shell of the old
folder remains, held by a process. The game junction `Mods/InsectsHaveNoBonesRenew` points at
`InsectsHaveNoBonesRenew\Mod`. `About.xml` lists no path, so nothing published changes.

**Pre-publication.** `Mod/About/PublishedFileId.txt` exists (`3806768044`, written 2026-09-23 16:45) and is now
committed (`ffa185d`, not pushed). `CHANGELOG.md` opens with `## [Unreleased]` above `## [0.1.0] — 2026-09-23`
(the `publishIdFile` creation; `Mod/` unchanged since `e8487e7`). The `1.0.0` that used to be dated
2026-09-05 was never released and is folded into `0.1.0`.

| Transition | Result | Evidence |
| --- | --- | --- |
| dansMonoRepo -> horsMonoRepo | Passed | Standalone repository, `origin` on the public repository (`gh search repos` lists it), STATUS, English documents. Root and `Mod/` copies of `LICENSE` and `ATTRIBUTION.md` compared by SHA-256: identical. **Defect**: the repository description is stale (see `remaining`) |
| horsMonoRepo -> ModIcon | Passed | `Mod/About/ModIcon.png`, 128x128, 22 KB, inspected at 32 px: the silhouette (antennae, round body) reads, the crossed-bone emblem is only a few pixels. No build: XML only |
| ModIcon -> Preview | Passed | `Mod/About/Preview.png`, 896x504, 522 KB, inspected: title, badge and subject readable |
| Preview -> preOptions | **Failed** | The name breaks the naming convention: ` 1.6` where the convention is ` Renew`. The description is English and ends with `[url=...]Source code on GitHub[/url]` whose target equals `About/url` and `origin` |
| preOptions -> options | Passed independently | Inventory of 8 XML documents and 6 patches unchanged: no setting, no page, no shortcut |
| options -> l10n | Passed independently | No player-facing text added or changed; no number is displayed, so the plural rule is moot |
| l10n -> preTest | Passed independently | `loadAfter` and `LoadFolders` use the ids of the four optional mods, none a hard dependency, so `modDependencies` is rightly absent; `dependencies` is `none` |
| preTest -> done | Would fail | No Pickle suite and no written reason: the effective result of butchering is only visible in a running game, so the absence cannot be justified. The offline tests are green (below) |

**Offline tests, replayed.** `Tests/Audit-Xml.ps1`: passed on 2026-09-28 (26 lines, no failure, same combinations
as the committed results). `Tests/Audit-PatchEngine.ps1`: **not replayable today**: the Workshop folders of
Medieval Overhaul (`3219596926`) and Outland Core (`2755501685`) are absent from disk, although
`appworkshop_294100.acf` still lists the first; `MedievalOverhaul.dll` cannot be loaded. Its results of
2026-09-13 stand for the six patch files and `LoadFolders.xml`: their SHA-256 match `Tests/Audit-artifacts.json`.
`About.xml` differs from that manifest, from the metadata commit `e8487e7` of 2026-09-20. Check-DefRefs,
Check-XmlClasses and Check-XmlFields are those of 2026-09-13 and were not rerun.

**Rights.** `licence: open`, unchanged. The original has no public repository: the author's GitHub account
was listed on 2026-09-28 and holds none for this mod (only the separate companion `Insects-Have-Chitin`,
not read). So no fork and no pull request; recorded in `ATTRIBUTION.md`.

**Other.** `.dds`: none exists, tracked or on disk; the rule `*.dds` is now in `.gitignore`. Pickle evidence:
none exists (`Tests/Pickle/` is absent), so nothing was deleted or minified; the folders are ignored and
`TESTING.md` says what to keep. `desktop.ini` and `*.ico` are now ignored. No game was launched, no run was
deposited, nothing was pushed.

**To reach the next state (`preOptions`).** Settle the name: change `<name>` and the README title, and
re-engrave the Preview title, or keep ` 1.6` by the owner's decision. Everything after that: the Pickle suite
and its companion step (`TESTING.md`), the replay of `Audit-PatchEngine.ps1` once the two mods are back, then
`PUBLICATION.md`.

### Correction, same day (2026-09-28)

The owner ruled on the two open points. The `packageId` stays without `renew`; the `<name>` is
`Insects don't have bones Renew`. `About.xml` and the README title were changed, and the Preview title
re-engraved from `Art/preview.html` (` 1.6` -> `Renew` in the secondary ink; the corner badge keeps `1.6`, the
game version). Delivered `Mod/About/Preview.png`: 896x504, 524 KB, inspected; the suffix ends well inside the
text column, and its ink is the unchanged secondary colour (7.29:1 on the veil colour, above 4.5:1; the
script's full-image contrast check was not rerun, its Playwright dependency being absent, so the page was
rendered with headless Chrome instead). The GitHub repository description was replaced.

`Preview -> preOptions` now passes, so the retained state is **`preTest`** (`workflow_stage: preTest`): the only
failing transition left is `preTest -> done`. `Art/Preview.ico` (a local Explorer icon derived from the old
preview) was not regenerated.

### Pickle suite written — 2026-09-28

`Tests/Pickle/` now holds the suite `preTest -> done` asked for: seven features (thirty-two scenarios by count
of `Examples` rows), five pass maps, a companion `About.xml`, and a local step assembly (`ButcherSteps.cs`, six
steps that butcher a fresh adult of a pawn kind and read the products; `LoggedMessageSteps.cs`, one). Checked
offline: `dotnet build` clean against the 1.6 reference stubs and the Pickle reference; `Check-Steps.ps1`
resolves all 48 step lines to exactly one step (7 local patterns, 207 others in the namespace) and every local
pattern compiles. Nothing was played. Its README lists what nobody has checked: none of the dependency mods is in
the WSL cache, the hard dependencies of Medieval Overhaul and Outland Core are not named in their maps,
Outland Core's bone is recognised only by a name, and the animal is butchered alive and unspawned.

Effect on the stage: the Pickle criterion of `preTest -> done` is met (written, scope justified in
`TESTING.md`). The state stays `preTest` because the other criterion, automated tests replayed and green, is
not established: `Tests/Audit-PatchEngine.ps1` cannot load Medieval Overhaul while its Workshop folder is
absent. It becomes `done` when that script is replayed green, and `tested` only after the five passes have
played, with the conditions listed in `TESTING.md`. No game was launched, no request was deposited.

### Patch-engine test replayed, stage `done` — 2026-09-28

The last thing keeping `preTest -> done` from passing was the replay of `Tests/Audit-PatchEngine.ps1`, which
could not load Medieval Overhaul while its Workshop folder was absent. Medieval Overhaul and Outland Core were then
downloaded into the WSL cache (`Use-Wsl.ps1`, exit 0), and the script was replayed against a temporary Workshop
root holding that copy of `MedievalOverhaul.dll` (334,336 bytes, the size read on 2026-09-05) and the Workshop
folders of Alpha Animals and Megafauna: **17 PASS lines, identical to the committed
`Tests/Audit-PatchEngine-results.txt`** (16 combinations, 48 top-level `Apply` calls). `Tests/Audit-Xml.ps1` was
replayed earlier the same day, also green. The six patch files and `LoadFolders.xml` are unchanged since the
manifest (SHA-256).

`preTest -> done` is now met on every criterion: scenarios written (`TEST_SCENARIOS.md`, `TESTING.md`), automated
tests and XML tests replayed and green on the delivered version, the Pickle suite written with its scope justified.
Stage **`done`**, `workflow_stage: done`. It becomes `tested` only when the five passes have played and the
conditions listed in `TESTING.md` hold. The first request (`minimal`) was deposited on `2845a64`; the others follow
once the maps are committed.

### First five tickets: two bugs found, both outside `Mod/` — 2026-09-29

`minimal-2845a64`: `nelim.pickletools.loadaudit` was never staged despite being the only line in
`wsl-deps.minimal.map`. Cause: every `wsl-deps.*.map` was missing its trailing newline, and
`scripts/stage-pickle-wsl.sh` reads the map with `while read pid wid _ < $DEPMAP`, which drops a file's
last line silently when it has no trailing `\n` (`read` still fills the variables but returns non-zero at
EOF, so the loop body never runs). Every map's last line was its most important one. Fixed, all five maps
(`9d8d917`).

`mo-0220807` and `outland-0220807` (ran before that fix reached disk): 3 and 2 failures, all on the same
"holds meat" precondition, for `AA_Agaripawn` and `AA_GreenGoo`. Both carry a
`CompProperties_AnimalProduct`/`CompProperties_DropOnDeath` comp (read in Alpha Animals' own 1.6 files,
Workshop `1541721856`) that replaces or supplements the normal butcher yield with a named resource
instead of ordinary meat — exactly the failure mode `Tests/Pickle/README.md` had already named as
possible. Replaced with `AA_Bumbledrone` and `AA_Mantrap`, same lists, same
`ParentName="AnimalThingBase"` shape and no such comp, the same shape as `AA_Aerofleet` which already
produced meat in the same runs (`6b8e4b5`). Not replayed yet.

`both-0220807` (ran before both fixes): 28 of 29 played scenarios failed with `Accessing map pawns off
main thread`, thrown inside `RimWorks.Pickle.Runtime.SuiteRunner` itself (`Player.log`, a
`System.Threading.Tasks` continuation stack, not this suite's own `ButcherSteps.cs`). Read as a Pickle
engine matter, not a mod defect: every failing scenario used the same step code that passed cleanly in
`mo-0220807` and `outland-0220807`, and the one passing scenario (`the mod is loaded...`) does not touch
`Find.CurrentMap`. Not investigated further here; worth a plain re-run once the map fixes are in, since it
may not reproduce.

Both `9d8d917` (maps) and `6b8e4b5` (feature samples) are pushed. Re-checks deposited: `minimal-2845a64` ->
`20260929-110204-920-3e48` (feature 01 only); `mo-0220807` -> `20260929-112031-303-dee7` (filtered on tags
that do not exist on the other features, so it plays all 29 rather than only feature 04 — a scoping
mistake, not corrected by re-depositing); `outland-0220807` -> `20260929-115928-999-ce82` (feature 04's
Alpha Animals scenario only); `both-0220807` -> `20260929-115930-003-57f0` (full pass, to see whether the
thread error reproduces). `incompat-original-0220807` was queued with the same broken map but ran after the
map fix reached disk (staged from the working tree at play time, not the map's own SHA): 1 passed, 0
failed, green on the first try. `Player.log` confirms the original mod was staged and still logs `Could not
find type named DankPyon.ButcherProperties`, so the declared incompatibility holds. No re-check needed.

### Preview carries the cut-out icon, gallery `00-` created — 2026-09-29

New owner convention (`PUBLISHING.md`): the Preview now carries `ModIcon.png` cut out, in a corner (the
emptier one, its side and bottom edges flush with the window edge, as if stepping out of it), and every
gallery starts with `00-`, a byte-identical copy of the Preview. `Art/cutout-icon.cjs`
(adapted from `ManyHappyReturns/_tools/cutout-icon.cjs`) flood-fills `Mod/About/ModIcon.png`'s near-black
background from its border inward (9,747 of 16,384 pixels, 59.5%, the mascot's own outline untouched) into
`Art/ModIcon-cutout.png`.

The bottom-left corner is emptier on the bare background (`Art/Preview.png`: plain floor, no crate), but
that scene's title and paragraph occupy `x:50-480, y:54-285.5`, which a flush bottom-left icon
(`left:0;bottom:0`, `+15deg`) overlaps: the render's own QA (`Art/render-preview.cjs`) caught it, contrast
collapsing to 1.24 against the 4.5 floor. Placed bottom-right instead, the only corner this scene's text and
badge both leave clear (a small crate there is now covered): `right:0;bottom:0;transform:rotate(-15deg)`,
240x240, `drop-shadow`, no manual bleed offset — the rotation alone carries the corners past the frame.
Re-rendered: font ok, contrast 8.52 primary / 6.05 secondary / 8.73 badge (all above 4.5), 563,165 bytes.
`Mod/About/Preview.png` replaced; `Art/Workshop/00-preview.png` created as its byte-identical copy (`cmp`,
identical). No other gallery image exists yet (`PUBLICATION.md`'s screenshots section is still open).

## Workflow audit — 2026-10-02

Revision `9a1cc56` (mod repo, one commit ahead of `origin/main` before it, not pushed). Protocol versions read:
`docs/PROTOCOLS-READ.md`. Retained state unchanged: **`done`** (`workflow_stage: done`). Nothing before `tested`
fails: name, Preview (also `Art/Gallery/0-preview.png`, byte-identical, renamed from `Art/Workshop/00-preview.png`),
settings and translation `not_applicable`, dependencies `none` and `loadAfter` as before. `tested` is not reached.

**`done -> tested`, condition by condition.**
- No `@wip` scenario: met (none in the features).
- Every conditional scenario ran: **not met**. `@requires` Alpha Animals and Megafauna ran in `mo`, `outland`, `both`
  (`6b8e4b5`, `6ccb5b0`), but the Alpha Animals samples of feature 04 are being replaced for the fourth time:
  `AA_Agaripawn`, `AA_GreenGoo` (0220807), `AA_Mantrap` (6b8e4b5), `AA_InfectedAerofleet` (6ccb5b0, leather only, no
  meat) failed "holds meat". Replacement `AA_Cactipine` (`useMeatFrom` Pig, no product comp) is unplayed.
- Never played: `02-minimal-pass` (2 scenarios of the `minimal` pass).
- No manual test left: met by `TEST_SCENARIOS.md` "Disposition": nine rows automated, four justified not applicable
  (languages, new colony, existing save, broader mod list).
- Non-regression (the five passes whole on the final revision): to deposit last.

**Tickets deposited** (small, never-run first, per AUDIT.md), owner `local_8f7db577-...`: `20261002-171129-941-4f5a`
minimal / `02-minimal-pass`; `-171130-586-f208` mo / `04-alpha-animals`; `-171131-357-c07c` outland / `04-alpha-animals,!@mo`.
Evidence: `Tests/Pickle/Evidence/{minimal-02,mo-04,outland-04}-9a1cc56`. Queue ahead: about forty tickets of other mods.
The `both` pass needs a `04` replay too; it is left to the final non-regression whole pass, which includes it.
Keep the working tree of `Mod/` and `Tests/Pickle/Mod` unchanged until the three `RUN_DONE`.

**Evidence.** `Tests/Pickle/Evidence` went from 117 MB to 2.3 MB: deleted `outland-0220807` (superseded by
`outland-retry`), every `screenshots/`, `report.html`, `messages.ndjson` (no scenario is `@review`, so no capture is
evidence). Kept six folders, trimmed to verdict files; nothing in git (no `.dds`, no evidence, `.gitignore` covers
both). History: `docs/runs/history.md`. No `pickle-reports-archive` entry of this mod was found.

**Origin.** Re-checked: the author's 64 repositories hold no repository of this mod; `Insects-Have-Chitin` read, it
is the separate chitin companion. No fork, no pull request possible (`ATTRIBUTION.md`).

**Not done:** `Art/Preview.ico` is stale (made from the pre-29/09 Preview), left to the owner's tooling; nothing pushed;
Audit-Xml and Audit-PatchEngine not replayed (no patch file, LoadFolders or About changed since 28/09).

## Preview source migration — 2026-10-03

Preview generation now uses the shared renderer with `Art/Preview.config.json`. Canonical sources and publishable outputs were preserved; transient QA belongs in ignored `Art/.render/`.
