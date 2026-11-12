# Run history

One line per run: date, revision, pass, verdict, evidence folder (`Tests/Pickle/Evidence/`, on disk, ignored by
git). Written 2026-10-02 from the reports and from `STATUS.md`; the long prose of the earlier sessions stays in
git. "Superseded" means a later line replaces it for every scenario it played.

| Date | Revision | Pass | Verdict | Evidence |
| --- | --- | --- | --- | --- |
| 2026-09-29 | `0220807` | `minimal` | infrastructure fault, nothing proved: the map lacked its trailing newline, so `loadaudit` was never staged | deleted |
| 2026-09-29 | `0220807` | `mo` | 3 red on "holds meat" (`AA_Agaripawn`, `AA_GreenGoo`, one more): samples replaced | deleted |
| 2026-09-29 | `0220807` | `outland` | 2 red on "holds meat" (`AA_Agaripawn`, `AA_GreenGoo`), 13 green, 1 skipped; superseded by `outland-retry` | deleted |
| 2026-09-29 | `0220807` | `both` | 28 of 29 red, `Accessing map pawns off main thread` inside Pickle's runner; did not reproduce on `6b8e4b5` | deleted |
| 2026-09-29 | `0220807` | `incompat-original` | green, 1 of 1: the original mod still logs `Could not find type named DankPyon.ButcherProperties`. Scenario and map unchanged since | `incompat-original-0220807` |
| 2026-09-29 | `9d8d917` | `minimal`, feature 01 only | green, 1 of 1. `02-minimal-pass` (2 scenarios) has never been played | `minimal-fix-9d8d917` |
| 2026-09-30 | `6b8e4b5` | `mo`, full | 27 green, 2 red (`AA_Mantrap`: butchers into `AA_CactusMeat`, not flagged meat), 1 skipped. Sole proof of `01`, `03`, `05`, `06` and the `04` rows other than `AA_Mantrap` under Medieval Overhaul | `aa-fix-6b8e4b5` |
| 2026-09-30 | `6b8e4b5` | `both`, full | 27 green, 2 red (same `AA_Mantrap`), 1 skipped. Only report of the `both` pass | `both-fix-6b8e4b5` |
| 2026-10-01 | `6ccb5b0` | `mo`, `04` only | 6 green, 2 red: `AA_InfectedAerofleet` yields leather only, no meat. Replaced by `AA_RedSpore` | `aa-fix-6ccb5b0` |
| 2026-10-01 | `6ccb5b0` | `outland`, full | 14 green, 1 red (`AA_InfectedAerofleet`, same cause), 1 skipped. Latest report of the pass | `outland-retry` |
| 2026-10-02 | `9a1cc56` | `minimal`, `02-minimal-pass` | green, 2 of 2, `exitReason: passed`. First play of these scenarios | `minimal-02-9a1cc56` |
| 2026-10-02 | `9a1cc56` | `mo`, `04` only | 10 green, 2 red: `AA_RedSpore` yields leather only (a spore has no flesh). Replaced by `AA_Cactipine` | `mo-04-9a1cc56` |
| 2026-10-02 | `9a1cc56` | `outland`, `04` only | 5 green, 1 red: `AA_RedSpore` yields `Leather_Light` only. Replaced by `AA_Cactipine` | `outland-04-9a1cc56` |
| 2026-10-11 | `5492c53` | `mo`, `04` only | 10 green, 2 red: `AA_Cactipine` yields `AA_CactusMeat` (not meat), like `AA_Mantrap`. Sample dropped; `AA_Aerofleet` alone covers the "neither" list | `mo-04-5492c53` |
| 2026-10-12 | `5492c53`+edit | `outland`, `04` only | green, 5 of 5, `exitReason` passed, without `AA_Cactipine` | `outland-04-nocactipine` |
| 2026-10-12 | `5492c53`+edit | `both`, `04` only | green, 10 of 10, `exitReason` passed, `setName` both, without `AA_Cactipine`. Report written 2026-10-12 18:38, read 2026-10-14; the sample drop was committed afterwards (`b25eabe`) | `both-04-nocactipine` |
