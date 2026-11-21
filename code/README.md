# code/

Moki & Julio (AI-assisted) · version 1.0

## In plain words

Every script that produced a number in PAPER.md is here, next to the transcript (`.out` or `.log`) it printed when it was originally run. To re-check, stage the data once, run a script, and compare its output with the shipped transcript. The scripts read their inputs by bare file name, as they did originally, so `stage.sh` copies the data files into place first.

## Set-up

```
cd code
bash stage.sh          # copies data/ files next to the scripts that read them (never overwrites)
```

Tools (the versions used): PARI/GP (from the passagemath wheels; scripts call `gp`), Singular, GAP 4 (IdGroup), msolve 0.10.1, Python 3 with sympy, mpmath, NumPy and python-flint 0.9.0 (Arb balls), Lean 4 `v4.36.0-rc2` for `lean/`. The `run_gp.sh`, `run_sing.sh` and `run_gap.sh` wrappers in each folder set a memory limit and a timeout and call the program on one file; put the programs on `PATH` or set `SAGE_BIN` to their folder (it must contain `gp`, `Singular`, `gap` and `msolve`). The counter `counter/count_pipeline.sh` runs `msolve` under bash and calls Python through `$PY`: set `PY` to an interpreter that has sympy (for example `PY=python3` if your python3 has sympy). Every `python` in the tables means a Python 3 with the listed packages; run each script from its own folder, since inputs are read by bare file name. The `run_gap.sh` used by the 656 group step is `656/run_gap.sh`; `grp.out` holds the gp step output followed by the GAP step output. Large Gram files need a big PARI stack: the scripts set `parisizemax` themselves.

Running a script overwrites its shipped transcript only if the script writes one by name (for example `arbcert.py` writes `arbcert.out`); compare against `MANIFEST.sha256` afterwards.

## The certification chain, surface by surface

Each surface has the same steps: exact identities (two engines), Gram matrix, lattice census (the exact count), match with Degtyarev's lattice, symmetry, real picture.

### 656/ (configuration (5.14))

| step | command | transcript | expected |
|---|---|---|---|
| smoothness over the cubic field | `bash run_sing.sh smooth.sing` | `runs/smooth.out` | dimension 0 |
| the three curves and their meeting point | `bash run_sing.sh meet.sing`; `bash run_gp.sh exactpts.gp` | `meet.out`, `exactpts.out` | the factor $9t^3+48t^2+125t+122$ |
| discriminant of the family | `bash run_sing.sh disc.sing` | `disc.out` | seven factors |
| NL1 checks | `python nl1_check.py` | (console) | identities hold |
| lattice-side group | `bash run_gp.sh grp_export.gp` (writes `grp48_v2.g`), then `bash run_gap.sh grp_id.g`; `bash run_gp.sh nl_groups.gp` | `grp.out`, `nl_groups.out` | (48,48), (24,12), (96,226); NL classes A, NL1, B |
| exact recognition and PARI identities | `bash run_gp.sh recog2.gp` | `recog2_final.out` | 30/30 pass |
| fields | `bash run_gp.sh fields.gp` | (console) | $N_{12}$ and its subfields |
| Singular replay | `python mksing.py && bash run_sing.sh replay.sing` | `replay.out` | 30/30 identities 0; control fails 30/30 |
| ball arithmetic and certified Gram | `python arbcert.py 300` | `arbcert.out` | all signs certified; 0 undecided Gram entries; writes `gram_cert.gp` |
| lattice census | `bash run_gp.sh lattice.gp` | `lattice.out` | NS = S, 656 classes, no lines |
| decoded-Gram invariants | `bash run_gp.sh snf.gp` | (console) | rank 20, Smith form $`1^{18}\cdot2\cdot122`$ |
| match with (5.14) | `python iso.py runs/dec_s1_gram.gp GR runs/fam_minus_gram.gp G out.npy` (after `stage.sh`; finds $`\pi`$ with `B[pi,pi] == A` and saves it; A and B are the Gram files and the names of their matrix variables) | `data/656/perm_dec1_to_famminus.npy` | entrywise match |
| node of $`\mathrm{NL}_B`$ (the 560) | `bash run_gp.sh node.gp` | (console) | gradient 0, Hessian determinant $< 0$ |
| numerical conics and real forms (support only) | `python numconics.py <kind> <seed> <starts> out.json ...`, then `python realforms.py out.json` | `runs/lead_realcheck_e.out` | 656 real, 656 with real points on the real form |

### 664/

| step | command | transcript |
|---|---|---|
| smoothness | `bash run_sing.sh sing1.sing` | (console) |
| NL elimination on the line $b = -a$ | `bash run_sing.sh mknl.sing` | (writes msolve inputs) |
| recognition, PARI identities, closure and Gram | `bash run_gp.sh run_exact_all.gp` (that is `exact.gp` followed by `gramx.gp`) | `exact.out` |
| Singular replay | `python mksing664.py && bash run_sing.sh replay664.sing` | `replay664.out` |
| balls | `python ballcert.py`, then `bash run_gp.sh compare.gp` | `ballcert.out`, `compare.out` |
| lattice census | `bash run_gp.sh lattice664.gp` | `lattice664.out` |
| group and real structures | `python group.py` | `group.out` |
| real picture | `bash run_gp.sh realpic.gp`, then `python ballreal.py` | `realpic.out`, `ballreal.out` |

### 704/

| step | command | transcript |
|---|---|---|
| smoothness | `bash run_sing.sh smooth704.sing` | `smooth704.out` |
| E-form equivalence | `bash run_gp.sh eform.gp` | `eform.out` |
| recognition and PARI identities | `bash run_gp.sh recog704.gp` | `recog704.out` |
| fields | `bash run_gp.sh fields704.gp` | (console) |
| Singular replay | `bash run_gp.sh mksing704.gp && bash run_sing.sh replay704_regen.sing` (the generator writes a fresh file; `cmp replay704_regen.sing replay704.sing` shows it equals the shipped one) | `replay704.out` |
| closure and exact Gram | `bash run_gp.sh gram704.gp` | `gram704.out` |
| lattice census | `bash run_gp.sh lattice704.gp` | `lattice704.out` |
| $T$ | `bash run_gp.sh disc704.gp` | (console; the label "[8,8,28]" it prints is a label bug for the Gram $[8,4;4,28]$) |
| symmetry | `bash run_gp.sh sym704.gp`, `bash run_gp.sh geo704.gp`, then `bash run_gap.sh sym704gap.g` | `sym704.out`, `geo704.out`, `sym704gap.out` |
| Degtyarev's 704 row | `bash run_gp.sh hit704.gp` (uses `bb.gp`, `bbext.gp`), `bash run_gp.sh degtgram.gp` | (writes `degt704.gp`, `gd704.gp`) |
| explicit match | `bash run_gp.sh isocheck.gp` (checks the shipped permutation `iso704_perm.gp`) | console prints `PI is a permutation of 1..704: 1` and `Gd[PI,PI] == Gc (exact, PARI): 1` |

### 736/

| step | command | transcript |
|---|---|---|
| smoothness | `bash run_sing.sh smooth736.sing` | `smooth736.out` |
| CM value | `python rho.py` | (console: $-16/9$) |
| recognition and PARI identities | `bash run_gp.sh recog736.gp` | `recog736.out` |
| Singular replay | `bash run_gp.sh mksing736.gp && bash run_sing.sh replay736_regen.sing` (fresh file; compare with `replay736.sing`) | `replay736.out` |
| Gram | `bash run_gp.sh gram736.gp`, then `bash run_gp.sh gramfix736.gp` | `gram736.out`, `gramfix736.out` |
| lattice census | `bash run_gp.sh lattice736.gp` | `lattice736.out` |
| lattice-side group and $T$ | `bash run_gp.sh grp736.gp`; `bash run_gp.sh disc736.gp` | (console) |
| geometric group | `bash run_gap.sh sym736.g` | `sym736.out` |
| match with (5.10) | `bash run_gp.sh degtgram736b.gp`, then `bash run_gp.sh isocheck736.gp` | `degtgram736b.out`, `isocheck736.out` |
| real picture | `bash run_gp.sh realpic736.gp` | `realpic736.out` |

### 660-640/

| step | command | transcript |
|---|---|---|
| Singular replay | `bash run_gp.sh mksing660.gp && bash run_sing.sh replay660_regen.sing` (same for 640; fresh files, compare with the shipped `replay660.sing`, `replay640.sing`) | `replay660.out`, `replay640.out` |
| lattice census | `bash run_gp.sh lattice660.gp`, `bash run_gp.sh lattice640.gp` | `lattice660.out`, `lattice640.out` |
| match with (5.13) and the 640 row | `bash run_gp.sh isocheck660.gp`, `bash run_gp.sh isocheck640.gp` | `isocheck660.out`, `isocheck640.out` |
| $T$ | `bash run_gp.sh discown.gp` | `discown.out` |
| Hadamard identity (640 = Dwork $`\mu = 28`$) | `bash run_gp.sh had640.gp` | `had640.out` |
| symmetry | `bash run_gap.sh sym660.g`, `bash run_gap.sh sym640.g` | `sym660.out`, `sym640.out` |
| real pictures | `bash run_gp.sh realpic660.gp`, `bash run_gp.sh realpic640.gp` | `realpic660.out`, `realpic640.out` |

The recognition and Gram scripts for 660 and 640 are not included in this candidate; the exact data they produced are in `data/660/` and `data/640/`, and every downstream check above reads them.

## decoder/

| script | command | output |
|---|---|---|
| `c656.py` | `python c656.py <seed> <trials> conics656.json` | configuration (5.14): 656 conics, rank 20, det 244 |
| `c736.py` | `CFG=5.10 python c736.py <seed> <trials> out.json` (`CFG` = 5.14, 5.13, 5.10, 5.8) | 656, 660, 736 or 800 conics |
| `decode514.py` | `python decode514.py <seed> <outstem>` | the independent decoding of (5.14) (different Golay construction) |

## counter/

The modular conic counter calibrated in BAR-656-COUNT, and the independent Singular counter that scored the later bars.

```
cd counter && mkdir -p runs
bash count_pipeline.sh <kind> <p> <seed> <tag> [params]     # e.g. kind mukai -> 800; random -> 0
FULL=1 bash count_pipeline.sh ...                            # also the distinct count (msolve -P 0; slower)
```

`count_pipeline.sh` runs `conic_count.py` (chart: random $`T \in GL_4(\mathbb{F}_p)`$, centre on $X$), then msolve `-g 1` and `vdim_lead.py` (count with multiplicity), optionally msolve `-P 0` and `msout_info.py` (distinct count: read the degree of the eliminating polynomial, not the header). `conics_through_P.py` counts conics in planes through $(0{:}0{:}0{:}1)$ on Goursat's family. Variants with more surface kinds (same chart and formulation): `variants/efam/conic_count_f.py` (E-form and a 35-coefficient custom quartic), `variants/abcde_diag/conic_count.py` (the $W(D_4)$ net and diagonal forms), `variants/s5_dwork/conic_count.py` (the $S_5$ pencil and Dwork forms); copy one over `conic_count.py` to use it.

Independent counter (Singular only, no shared code): `referee/rcount.sing`, driven by `referee/mk.sh <tag> <p> <seed> <dolex> '<F>'` and `referee/run.sh <tag> <timeout>`. `referee/runs/` holds the inputs and outputs of every sealed score it produced (`lead664_*`, `lead704_V1`, `lead736_*`, `lead660_*`, `lead640_*`) and of the referee's own checks (`tgt_*`: 656 at two primes; `gen_*`: 392; `mukai_*`: 800).

`ppt/` reproduces six certified rows of Pichon-Pharabod and Telen: `ppt_members.py` builds the invariant members; `ppt_batch1.log`, `ppt_batch2.log` are the counts.

## family/ and mirror/

| script | command | transcript |
|---|---|---|
| the eight curves and the discriminant | `family/curves.gp` (read by the others) | - |
| all pairwise meets | `bash ../656/run_gp.sh meet2.gp` from `family/` (or `gp -q meet2.gp`) | `meet2.out` |
| genus of the curves | `gp -q genus.gp` | (console) |
| no hidden symmetry (index 1) | `mirror/`: `bash run_gp.sh m1.gp` | `m1.out` |
| discriminant in Goursat's chart | `mirror/`: `bash run_sing.sh disc.sing` | `disc.out` |
| anisotropy of $`T_{\mathrm{gen}}`$ | `mirror/`: `bash run_gp.sh iso.gp` | `iso.out` |

## lean/

`Conic656Disc.lean` kernel-checks the index-2 overlattice exclusion for the 656 lattice (10 theorems by `decide`; no imports). `Conic656DiscControl.lean` claims the false divisibility and must fail. Both are generated by `mklean.py` from `S20.txt`, `K2.txt`, `h.txt`, which `dump.gp` writes from `gram_cert.gp`.

```
cd lean
gp -q dump.gp                        # optional: regenerate S20.txt, K2.txt, h.txt
python mklean.py Conic656Disc.lean   # optional: regenerate both .lean files
lean Conic656Disc.lean               # must succeed (toolchain in lean-toolchain)
lean Conic656DiscControl.lean        # must FAIL
```

Written with AI assistance.

Note on the counter scripts: a comment in `counter/conic_count.py` and its variants mentions "Y56", the 56-line real quartic of Degtyarev, Itenberg and Sertöz, and its 636 conics (Degtyarev's count, arXiv 2407.00493). These scripts are pinned by sha256 in the sealed tests, so the comment is left as it was. That surface is the subject of the separate Y56 atlas release.

Scoring logs of the sealed tests, and the scripts that produced them, are in `../scores/`. PARI tip: run scripts as `gp -q script.gp < /dev/null` so gp exits when the script ends.
