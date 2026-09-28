# Backlog

What remains for this mod, in three kinds: `defect` (a known fault left unfixed), `feature` (something a
first release could still have) and `unverified` (something that could not be checked). Last reviewed
2026-09-28. Nothing here is a claim that the item was done.

## Unverified

- **The Pickle suite is written and has never been played.** `Tests/Pickle/` holds seven features, a local step
  assembly that butchers a pawn and reads the products, and five pass maps; `Check-Steps.ps1` and the build are
  green. Its README lists what nobody has checked: the dependency downloads in the WSL cache, the hard
  dependencies of Medieval Overhaul and Outland Core, Outland Core's bone name, and butchering a live unspawned
  pawn. The 16 combinations of `TEST_SCENARIOS.md`, the existing-save add/remove and a log read have never been
  played in a game.

## Defects

- **The About description** has no line pointing to `ATTRIBUTION.md` and the licence, and the mods it names
  (Medieval Overhaul, Outland Core, Alpha Animals, Megafauna, Rim of Madness - Bones Unofficial Fix) carry
  no Workshop link. It was sent as it stood when the item was created; from now on the page description
  comes from `PUBLICATION.md`.

## To do before publishing

- Write `PUBLICATION.md`: the `## Steam description` Markdown block (ending with the source link), the
  gallery order, the thank-you drafts, the dependencies to declare (none are hard), the answer to the
  adult-content boxes, and the `### 1.0.0` change note.
- Thank-you comments, one recipient page each, checked against `WORKSHOP_COMMENTS.md`: Medieval Overhaul
  (`3219596926`) is already `posted`, so only its `Covers` column gets this mod; Outland Core, Alpha
  Animals, Megafauna, Rim of Madness - Bones Unofficial Fix (`3252977437`) and the original page
  (`2041677515`) have no row yet.
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
