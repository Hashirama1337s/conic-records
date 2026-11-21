# PATCHES

Moki & Julio (AI-assisted) · version 1.0

## In plain words

Most files in this package are byte-for-byte copies of the files our computations produced. A few copies had to be changed before release, because they named folders on the machine where they ran. Every such change is listed here, with the sha256 of the original file so the original can be identified. The original strings are not reproduced. Sources stay untouched in the working folder: everything was copied, nothing moved or deleted. Source paths are relative to the working folder (`LEAN/` is the lab's Lean project).

## Sanitised copies

| shipped file | source | original sha256 | change |
|---|---|---|---|
| `code/656/run_gp.sh` | `exactub/run_gp.sh` | `5c75f0ef6a4e4258f012b73d3edff47cc5574ff5a7e4c8f57156d1ecc1c75d1a` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/656/run_sing.sh` | `exactub/run_sing.sh` | `1a8189bc42ec3dbebffaf12c28bb429060f7fc38e9dc41f53e422da4ba969d5b` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/660-640/run_gap.sh` | `cert660/run_gap.sh` | `5258d6a69a1db51a63945a5b2c722146106c385dd94fb3ac5b08737703699b14` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/660-640/run_gp.sh` | `cert660/run_gp.sh` | `c3d6a1a49653912c7620c275e402f5aaf7a658497e288b503e9658db78fe8a02` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/660-640/run_sing.sh` | `cert660/run_sing.sh` | `bb183e513340081b436016a5b71f14fc35fbb4035291218d33ab67abee5db41d` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/664/run_gp.sh` | `cert664/run_gp.sh` | `918a7bb1c19d2eaae68ac8455c8c5c6cc6f6be14210e0779347f9d92b55888f1` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/664/run_sing.sh` | `cert664/run_sing.sh` | `f75542d4fbce5b6e63cfc0184bfe5357a479be2c8007a055922ad09da468638f` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/704/run_gap.sh` | `cert704/run_gap.sh` | `932df88485c40ac52f0f0312ff3b0f710d14107975faa5353bb3b2c1860f1529` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/704/run_gp.sh` | `cert704/run_gp.sh` | `1ec3663672bb72ae6f2f43daa8aa8564bf23f5a68234f097be5654fbd7356b7a` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/704/run_sing.sh` | `cert704/run_sing.sh` | `85bb6c7c325e12d64d966c1532cb38b64778f1ac280a2f1b556a6d8e1eafa11a` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/736/run_gap.sh` | `cert736/run_gap.sh` | `9b7f070d1d16740c7f472660a87c377b3b9f664edea5113f9b3bb5587383993d` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/736/run_gp.sh` | `cert736/run_gp.sh` | `a3455940a578ff34320dd6d3539b58111ae983c28d54f82c7a6d41e5ded379b1` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/736/run_sing.sh` | `cert736/run_sing.sh` | `40e0f253501990a1e456bf4092431426e684b485f485f5503e3be93e5ae8ecc2` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/counter/count_pipeline.sh` | `build/count_pipeline.sh` | `e23bba48ef8cf65613af5cd954f7c2cb1dfa8d08d91415551408b97ed5bb35fb` | local folder in a comment -> this folder x1; local memory-cap wrapper -> $PY (default python3) x1; local WSL call with absolute paths -> direct call in this folder x2 |
| `code/counter/ppt/ppt_batch1.log` | `familymap/runs/ppt_batch1.log` | `066cf930fa65149f1cbddf6863a75592fe480c88ab1a10bfc1f02ae9c1aa5f3d` | local WSL folder prefix in recorded log lines -> removed (paths now relative) x6 |
| `code/counter/ppt/ppt_batch2.log` | `familymap/runs/ppt_batch2.log` | `481a5b8b67a3397818c831618e9337cd2f9e64ef7b51d75cb7c75f4c8500558b` | local WSL folder prefix in recorded log lines -> removed (paths now relative) x12 |
| `code/counter/ppt/ppt_members.py` | `familymap/ppt_members.py` | `94a934680de18fdb318f0727c1190361817bb0f1131c84f17feec57a025bfb36` | local source path in a comment -> 'local copy of arXiv ...' x1 |
| `code/counter/referee/run.sh` | `referee/run.sh` | `cd441ef5160e693f87d25eef1d65d02b30a9ca02cd25a3efdb5fe5fca0692c37` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/counter/run_ms.sh` | `build/run_ms.sh` | `8912a4accb1f0a2cf6e7dc02a1d6bdbecf7e953fb69841940f56a5ac53c4444a` | local tool folder in PATH -> $SAGE_BIN x1 |
| `code/counter/run_msg.sh` | `build/run_msg.sh` | `b42091c1409dd738a6ee5cbb12e690f131b9d5be7e824ce8e55e1504e6742ecd` | local tool folder in PATH -> $SAGE_BIN x1 |
| `code/lean/dump.gp` | `lean656/dump.gp` | `3fd02981ef8b203587eb0b800a49a0caf1002e55cc919ab2a8a5fa1d651f9405` | input path -> staged copy in this folder (code/stage.sh) x1 |
| `code/mirror/iso.gp` | `mirror/iso.gp` | `2a6ec92fcf342b60e9002b5ba208a9dc00f0ee18472d4e2bf5ee87c52e6e3baa` | input path -> staged copy in this folder (code/stage.sh) x1 |
| `code/mirror/m1.gp` | `mirror/m1.gp` | `2ac4da89c73030037e42efeb56b6daa517422dcc0029eaed44fb772386529cbf` | input path -> staged copy in this folder (code/stage.sh) x1 |
| `code/mirror/run_gp.sh` | `mirror/run_gp.sh` | `e559dcf0e920d815b630efa994a930dfbbce3417ccc2e4174cb2b1a8f4df90cc` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `code/mirror/run_sing.sh` | `mirror/run_sing.sh` | `7c817f42b9ea3de4ae3d76ebed4bf76bb77f5c34bf1fa03aa87419484a07796e` | local tool folder in PATH -> $SAGE_BIN x1; local working-folder cd -> script folder x1 |
| `references/PRIOR-ART-660-640.md` | `gate/PRIOR-ART-660-640.md` | `afee666b0cae15b6d27a79a5f640b0a462f5d04490f98379c90a93c51005fbd5` | local lab-tool path -> tools/<name> x12; local project folder prefix -> removed (paths relative to the project) x21; local root folder prefix -> removed x1 |
| `references/PRIOR-ART-656-EQ.md` | `gate/PRIOR-ART-656-EQ.md` | `8c7b1349ff7c1b4cdf4abbd2cb2a065d5c52706040b48fe18d7a4cff504abf84` | local project, lab-tool and earlier-gate folder prefixes removed or replaced by a short label ("(earlier Y56 gate)", "<project>") |
| `references/PRIOR-ART-664-704.md` | `gate/PRIOR-ART-664-704.md` | `de516ee7d30534b4b848b010ef533b28a7c73f3881b274d00f9a6d0c79eeca02` | local project, lab-tool and earlier-gate folder prefixes removed or replaced by a short label ("(earlier Y56 gate)", "<project>") |
| `references/PRIOR-ART-736-QM.md` | `gate/PRIOR-ART-736-QM.md` | `5b8a4ff9ddc436908b241ad765f358bfa279fec9595e8a6dadab49539ec7882d` | local project, lab-tool and earlier-gate folder prefixes removed or replaced by a short label ("(earlier Y56 gate)", "<project>") |

## Notes

- `bars/BAR-656-POINT.md`: shipped byte-identical to the sealed file (sha256 5a89924c4500b23d06470d6907cd26005f3492be638d02d6661a791a9de11a73, seal 5ab888ffae). Its disclosure section names a lab working folder by a generic word that the release lint flags; that single lint finding is a documented exception, because editing a sealed file would break its hash.
- Shell wrappers (`run_*.sh`, `count_pipeline.sh`, `referee/run.sh`): the program folder in `PATH` is now `$SAGE_BIN` and the working-folder `cd` is now the script's own folder. In `count_pipeline.sh` the lab's memory-cap wrapper is now `$PY` (default `python3`) and the call through a Linux subsystem with absolute paths is now a direct call in the script's folder; the counting protocol itself is unchanged.
- `code/lean/dump.gp` and `code/mirror/m1.gp`, `iso.gp` read their input from the script's own folder, where `code/stage.sh` puts it.
- `references/PRIOR-ART-660-640.md`: local folder prefixes removed, so the paths it names are relative to the working folder; the files it cites from the working folder (query logs, downloaded sources, other gate reports) are not part of this package.

Written with AI assistance.

## Release fixes after the clean-room rebuild
The clean-room rebuild (a fresh copy run only from the documented commands) reproduced every shipped number; it found instructions that did not work as written. Fixed in the release files themselves (these are release scaffolding, not results): `code/656/run_gap.sh` added (copy of the 660-640 wrapper); `ulimit` lines in the wrappers made quiet when a lower limit is already set; the four Singular-replay generators (`mksing704.gp`, `mksing736.gp`, `mksing660.gp`, `mksing640.gp`) now write `replay*_regen.sing` instead of appending to the shipped replay files; `stage.sh` stages `fam_minus_gram.gp` and uses a portable no-overwrite copy; `code/README.md` gives the exact `iso.py` call, the 704 console output, the `PY` and `SAGE_BIN` requirements; the header comment of `arbcert.py` names its real output `conics_cert.json`. No result file changed.

## Release fixes after the hostile referee
The release referee (strongest tier, report kept in the working folder) judged the mathematics CORRECT and asked for wording fixes, all applied: the citation abstract now says which surfaces have explicit lattice matches (704, 736, 660, 640), which by invariants (664) and which on a numerical Gram (656); the headline about Barth and Bauer quotes what they wrote; every "nobody" sentence carries the search floor; Veniani's different 656-conic surface Q56 is named; a `CERTIFIED` label marks results from ball arithmetic; the eight-curve map is marked argued; the score logs and the remaining prior-art reports are now shipped (`scores/`, `references/`); determinant signs and "pairs of roots" corrected; added credits (Brandhorst-Hashimoto, Schur, Fu); the bars line in README no longer claims a changed word (none was changed).
