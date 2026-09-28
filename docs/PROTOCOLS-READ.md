# Protocol documents read

The rules this mod is worked under live outside this repository. A rule that has moved since it was
read is only visible if the version read is written down, so this file records it. Read the documents
again at the start of a session and after every compaction of the context, then compare with the tables
below: if a document's version has not changed, skip it; if it has, read what changed. **Documents marked
"not useful" are not to be read again unless their trigger happens.**

A version is the last commit that touched the file. The protocol documents live in the protocols
repository, whose git directory sits beside the monorepo with the monorepo as its work tree; the others
live in their own repositories. The blob is `git hash-object` of the content actually read. A working copy
is clean unless `git status --short -- <file>` says otherwise.

## Read on 2026-09-28

Heads at the time: protocols `87c3c78`, PickleTools `c4236b4`, Release-Admin `a6c3038`, Ticket-Dispatcher
`c17ede9`, this repository `ffa185d`.

### Useful

| File | Version read | Blob | Working copy | What I took from it |
| --- | --- | --- | --- | --- |
| `AGENTS.md` | `3a1d2cb` (24/09 12:08) | `134b2b60f9` | modified, not committed | The three ordered gates, the evidence policy (one report per scenario and revision, history as one line per run in `docs/runs/`, never delete what `STATUS.md` points to), publication goes through the CI |
| `AUDIT.md` | `c5ca0c0` (26/09 22:35) | `e9a564da92` | modified, not committed | The chain of stages, the new conditions for `tested` (no `@wip`, every conditional scenario ran, no manual test left), the step back to `preTest` for a `done` mod with no Pickle suite and no written reason, the `0.1.0` changelog convention, the session title, the machine rules (never launch the game, deposit a request) |
| `PUBLISHING.md` | `95c6dfd` (28/09 08:54) | `06c4976f1e` | modified, not committed | Description rules and the single Markdown source in `PUBLICATION.md`, licence suffixes, the pull request to an original repository, the two ATTRIBUTION copies, `desktop.ini` and `.ico` never tracked, git pitfalls of a shared repository |
| `MOD_SETTINGS.md` | `b83933b` (23/09 20:46) | `a61cd54192` | clean | `not_applicable` needs an inventory of behaviour and payload, and a check that there is neither an empty page nor a shortcut |
| `TRANSLATIONS.md` | `f5c2d9d` (25/09 19:19) | `fac8188128` | clean | `not_applicable` needs an inventory proving no player-facing text; the plural rule is moot here, no number is displayed |
| `PickleTools/Authoring/README.md` | `8d3ca6d` (26/09 22:38) | `a6e3e2eac0` | clean | What belongs in Gherkin and what stays offline, the pass matrix, `wsl-deps` maps, the incompatibility pass that asserts the symptom, filters, what to read before touching `STATUS.md` |
| `PickleTools/TESTING.md` | `650adce` (25/09 19:56) | `f88f15c373` | clean | Only the section "What to keep after a test, and what to delete": the evidence table |
| `Rimworld-Ticket-Dispatcher/docs/WELCOME.md` | `77ca9d7` (27/09 23:26) | `1bdd1eed63` | clean | One request per pass, the request carries no SHA, the dispatcher wakes the session, no `Mod/desktop.ini` or `.ico` in a commit, and how to read the version of a protocol document |

### Partly useful

| File | Version read | Blob | Working copy | Read it again for |
| --- | --- | --- | --- | --- |
| `Rimworld-Ticket-Dispatcher/docs/SUBMIT.md` | `d07b2b8` (26/09 18:25) | `7ab5e437d4` | clean | The day a run is deposited: every option, the exit codes, `-Label` with the SHA, `-EvidenceDir` |
| `Rimworld-Release-Admin/docs/OPERATIONS.md` | `3c03f51` (26/09 23:20) | `347a0d63b9` | clean | Publication, once the mod is `tested`: the dry-run, the full SHA, who approves, the first-publication chapter |
| `WORKSHOP_COMMENTS.md` | `5dcb0c7` (28/09 11:28) | `4a82b8782b` | modified, not committed | The register and "Writing a comment", when the thank-you drafts are written for `prepublished` |
| `PickleTools/README.md` | `c771bef` (25/09 19:37) | `495a6ba602` | clean | The catalogue of shared steps; `LoadAudit` is the one that matters here |
| `PickleTools/docs/steps.md` | `09f9c0e` (28/09 17:11) | `7ade22f664` | clean | The `LoadAudit` and `DefFieldSteps` tables, when the suite is written. It is generated: never edit it |
| `PickleTools/Headless/README.md` | `ed4e73a` (26/09 22:52) | `c023a674fb` | clean | **Only its headings were read.** Read the sections on filter terms, passes and "What happens to your report" before the first request |
| `STYLE_RIMWORLD.md` | `7311308` (25/09 15:50) | `f64a8fa446` | modified, not committed | Only the sections on the `(prohibited)` and `(unofficial)` tags, on checking a ModIcon, and on Windows folder icons |

### Not useful for this mod: do not read again unless the trigger happens

| File | Version read | Blob | Trigger |
| --- | --- | --- | --- |
| `scripts/SEARCHING.md` | `372c447` (23/09 21:01) | `45f0fa13cc` | Searching the mod corpus for a defName, a class or a texture path. Only its first third was read; nothing here needed the corpus |

## This mod's own documents, same day

`STATUS.md` (local, ignored by git), `README.md`, `CHANGELOG.md`, `ATTRIBUTION.md`, `LICENSE`,
`TEST_SCENARIOS.md`, `Mod/About/About.xml` were read. `TESTING.md` and `BACKLOG.md` did not exist and were
written that day. Not yet existing: `PUBLICATION.md`, `NOTES.md`, `BUGS.md`, `docs/runs/`, `Tests/Pickle/`.
