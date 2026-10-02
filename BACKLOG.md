# Backlog

What remains for this mod, in three kinds: `defect` (a known fault left unfixed), `feature` (something a
first release could still have) and `unverified` (something that could not be checked). Last reviewed
2026-10-02. Nothing here is a claim that the item was done.

## Unverified

- **Pickle passes still to play** (`TESTING.md`, "State of the passes"): `02-minimal-pass` in `minimal`, then
  `04-alpha-animals` with its new `AA_RedSpore` samples in `mo` and `outland`, as small tickets; then the five
  passes whole, together, on the final revision (non-regression, last). Nothing is deposited yet beyond the
  tickets listed in `STATUS.md`.
- The 16 combinations of `TEST_SCENARIOS.md` are covered offline by `Tests/Audit-PatchEngine.ps1`; the rows that
  are neither automated nor applicable are none (see its "Disposition" table).

## Defects

- **The About description** has no line pointing to `ATTRIBUTION.md` and the licence, and the mods it names
  (Medieval Overhaul, Outland Core, Alpha Animals, Megafauna, Rim of Madness - Bones Unofficial Fix) carry
  no Workshop link. It was sent as it stood when the item was created; from now on the page description
  comes from `PUBLICATION.md`.

## To do before publishing

- `PUBLICATION.md` is drafted (2026-09-29): description, dependencies, manual validations, 1.0.0 change
  note, five thank-you drafts. Two open questions left for the owner inside it (inline Workshop links in
  the description; whether a gallery is worth making). Nothing posted, nothing added to the shared
  `WORKSHOP_COMMENTS.md` registry yet.
- Post the thank-you comments once the item is public, then add their rows to `WORKSHOP_COMMENTS.md` and
  Medieval Overhaul's `Covers` column (`3219596926`, already `posted` for another mod).
- GitHub topics (`rimworld`, `rimworld-mod`, `mod`) and the social preview image.
- Generate the publish workflow once the mod is `tested`, dry-run the exact commit, then publish.
- Check that `Mod/desktop.ini` (a local Explorer folder icon, ignored by git) is not uploaded: Steam
  sends `Mod/` as it stands on disk.

## Features, optional

- Alpha Animals 1.6 has 64 animals that neither the abstract bases nor Hiroyan's list reach. Nearly all are
  vertebrates and should keep their bones; four are arguable (`AA_Locusts`, `AA_SmallButterfly`,
  `AA_OcularCactus`, `AA_MycoidColossus`). Which creature has a skeleton is the original authors'
  judgement, so the roster is unchanged.

## Not applicable

- **Pull request to the original.** It has no public repository (see `ATTRIBUTION.md`). If one appears, the
  fixes go there first.
- **Settings, translations, build.** The mod owns no setting and no player-facing text, and ships no code.
