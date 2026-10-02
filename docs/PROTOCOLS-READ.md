# Protocol documents read

The rules this mod is worked under live outside this repository. A rule that has moved since it was read is
only visible if the version read is written down, so this file records it. At the start of a session, compare
the versions below with the files: if a document's version has not changed, skip it; if it has, read what
changed (`git diff <version read> HEAD -- <file>` in the repository that owns it). **Documents marked "not
useful" are not to be read again unless their trigger happens.**

A version is the last commit that touched the file, in the repository that owns it: the protocol documents
(`AGENTS.md`, `AUDIT.md`, `PUBLISHING.md`, `MOD_SETTINGS.md`, `TRANSLATIONS.md`, `STYLE_RIMWORLD.md`,
`WORKSHOP_COMMENTS.md`, `scripts/SEARCHING.md`) live in `rimworld-protocols.git`, beside the monorepo with the
monorepo as its work tree; the others in their own repositories. The blob is the first ten characters of
`git hash-object <file>` of the content actually read; it also tells an uncommitted edit from a commit.

## Read on 2026-10-02

Heads at the time: protocols `91f4a85`, PickleTools `b7620cb`, Release-Admin `d5282af`, Ticket-Dispatcher
`dcbecf7`, this repository `6ccb5b0` (plus the work of this session).

### Useful

| File | Version read | Blob | What I took from it |
| --- | --- | --- | --- |
| `AGENTS.md` | `7fd7475` (29/09) | `44dddcbc8f` | The three ordered gates; the evidence rule (keep the latest report per scenario and revision, one line per run in `docs/runs/`, never delete what `STATUS.md` points to, list what goes and what stays first); the reports folders are shared by every mod |
| `AUDIT.md` | `d1fdbe1` (02/10 15:16) | `daab030ccf` | The chain of stages; the `tested` conditions (no `@wip`, every conditional scenario ran, no manual test left); the order of tickets (what never ran or is red first, non-regression all together at the end, 02/10); the machine rules (never launch the game, deposit a request, no watcher); the `0.1.0` changelog convention; the session title `<packageId without nelim.> / <workflow_stage>` |
| `PUBLISHING.md` | `4e8f11a` (02/10, uncommitted edit on top) | `e29afeb827` | Read to line 760 of 789; the rest is git pitfalls of the shared monorepo. Taken: description rules, the gallery folder `Art/Gallery/` with `0-` a byte-identical copy of the Preview (single digit since 29/09), the ModIcon is the owner's alone to generate, a pull request to the original is systematic when it has a repository, thanks comments go through `WORKSHOP_COMMENTS.md`, the fail-fast rules before `publish` |
| `MOD_SETTINGS.md` | `b83933b` (23/09) | `a61cd54192` | Unchanged since the last read (28/09): `not_applicable` needs an inventory of behaviour and payload, and a check that there is neither an empty page nor a shortcut |
| `TRANSLATIONS.md` | `af8427f` (02/10) | `7b4d9a23bd` | `not_applicable` needs an inventory proving no player-facing text; this mod displays none, so the plural rule, the French neutral grammar and `FRENCH_REVIEW.md` do not apply |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `d07b2b8` (26/09) | `7ab5e437d4` | Every option of `Submit-PickleRun.ps1`: `-DepMap` is a file name, `-Filter` is one string, `-Label` carries the SHA, `-EvidenceDir` is relative to the rimworld root and an existing folder is never overwritten, no `-Then` here |

### Partly useful: read again for

| File | Version read | Blob | Read it again for |
| --- | --- | --- | --- |
| `STYLE_RIMWORLD.md` | `c105a43` (01/10, uncommitted edit on top) | `773961397c` | Only the diff since the last read, headings and the sections "Le ModIcon détouré sur la vitrine", "L'image 0 de la galerie Workshop" and "Icônes des dossiers Windows". The rest is about generating images, which a session of this mod never does |
| `WORKSHOP_COMMENTS.md` | `91f4a85` (02/10) | `5fa322bf01` | The registry rows of the recipients (Medieval Overhaul `3219596926` is `posted`; Outland Core, Alpha Animals, Megafauna and Rim of Madness - Bones Unofficial Fix are not covered by this mod's row yet) and "Writing a comment", when the thank-you drafts are posted |
| `PickleTools/README.md` | `ff20d89` (29/09) | `1d28b27e67` | Read as a diff since `c771bef`: only a pointer to `docs/FIXTURES.md` was added (what each fixture holds) |
| `PickleTools/Authoring/README.md` | `a47799f` (29/09) | `75329decf2` | Read as a diff since `8d3ca6d`: the same pointer to `docs/FIXTURES.md`. Not needed here: the suite already exists and uses `test-colony` |
| `PickleTools/docs/steps.md` | `da7c3b0` (28/09) | `8639a06971` | Read as a diff since `09f9c0e`: two new shared steps (select a thing by def at a cell, click a gizmo by key), neither used. Generated: never edit |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `3c03f51` (26/09) | `347a0d63b9` | Unchanged; publication, once the mod is `tested`: the dry-run, the full SHA, who approves, the first-publication chapter |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `77ca9d7` (27/09) | `1bdd1eed63` | Unchanged; first registration with the dispatcher and how to choose what to play |
| `PickleTools/Headless/README.md` | `ed4e73a` (26/09) | `c023a674fb` | Unchanged; only its headings were ever read. Read the sections on filter terms, passes and "What happens to your report" if a ticket behaves in a way `SUBMIT.md` does not explain |

### Not useful for this mod: do not read again unless the trigger happens

| File | Version read | Blob | Trigger |
| --- | --- | --- | --- |
| `scripts/SEARCHING.md` | `50de695` (28/09) | `45f0fa13cc` | Searching the mod corpus for a defName, a class or a texture path. Not read again on 02/10: the blob is the one read on 28/09, nothing here needed the corpus |
| `PickleTools/TESTING.md` | `650adce` (25/09) | `f88f15c373` | Its evidence table was read on 28/09 and is now in this mod's `TESTING.md`; unchanged |

## This mod's own documents, 2026-10-02

Read: `STATUS.md` (local, ignored by git), `README.md` (title only checked), `CHANGELOG.md`, `ATTRIBUTION.md`
(upstream section), `LICENSE` (unchanged), `PUBLICATION.md`, `TESTING.md`, `BACKLOG.md`, `TEST_SCENARIOS.md`,
`docs/runs/`, `Tests/Pickle/`, `Mod/About/About.xml`. `NOTES.md` and `BUGS.md` do not exist: the mod has no notes
or known defects beyond `BACKLOG.md`.
