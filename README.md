# Conic records

**Explicit equations, with exact conic counts, for record quartic surfaces with 656, 664, 704, 736, 660 and 640 conics, and a conic map of Goursat's family**

Moki & Julio (AI-assisted) · 2026 · version 1.0 · DOI [10.5281/zenodo.24413371](https://doi.org/10.5281/zenodo.24413371)

> In 1994 Barth and Bauer proved that quartic surfaces with 16 disjoint conics exist, and wrote that they did not find their equations. Thirty years later Degtyarev picked out the record members by lattice data alone. Here are equations for six record surfaces, two of them Barth-Bauer quartics.

## In plain words

A quartic surface is the set of points in space that satisfy one polynomial equation of degree 4. Some smooth quartic surfaces contain conics: ellipses, parabolas and hyperbolas lying entirely inside the surface. In 2024 Alex Degtyarev proved that a smooth quartic holds at most 800 conics, and he listed, as patterns of lattice data, many surfaces that come close. For most of them no equation was known (none found at our search floor, 20-21 November 2026). One of them, with 656 conics, is also the real record: all 656 conics are real curves that you could draw, the most known on any real quartic. (A different surface with 656 conics, Veniani's Q56, already has a published equation; its transcendental lattice has determinant 60, not 244, so it is a different surface from the all-real one.) Degtyarev's theorem leaves the true real maximum somewhere between 656 and 718.

We turned six of these lattice patterns into equations. For each surface we wrote down every conic exactly, checked every conic identity in two independent computer algebra systems, and proved the count is exact (no more conics hide anywhere) with a lattice argument in exact arithmetic that needs no luck with random choices. (For 656 the input to that argument, the table of conic intersections, was decided by certified interval arithmetic.) The 704-conic and 640-conic surfaces belong to the class of quartics with 16 disjoint conics that Barth and Bauer proved to exist in 1994 and 1995 without finding equations; we show by an explicit match that our equations are Degtyarev's 704-conic and 640-conic Barth-Bauer quartics. The 736-conic and 640-conic surfaces have rational coefficients and sit at special points of the famous Dwork pencil whose parameter values were already in print; the surfaces themselves, with their lattices and conics, were not identified at our search floor.

Along the way we mapped the whole two-parameter family of surfaces in which the 656 record lives. That family was written down by Édouard Goursat in 1887. Eight curves in its parameter plane carry extra conics, the counts add up by a simple rule at every point we tested, and the record sits at the one point where three of those curves meet, inside the only region of the plane where all conics are real.

## Start here

1. Read [PAPER.md](PAPER.md). Every section opens with a paragraph in plain words.
2. Look at the gallery below, then at the scorecard of sealed tests.
3. Re-check a surface yourself: [code/README.md](code/README.md) has one command per step. Every number in the paper is in a shipped transcript next to the script that made it.

## The gallery

Notation: $q = x^2+y^2+z^2$, $p_4 = x^4+y^4+z^4$; in four variables, $`\Sigma x^4 = x^4+y^4+z^4+w^4`$ and $`\Sigma x_i^2x_j^2`$ is the sum of the six products of distinct squares.

| conics | equation | field of the equation | symmetries | real picture | status |
|---|---|---|---|---|---|
| **656** | $E w^4 - E q w^2 + q^2 + t p_4 = 0$, with $9t^3+48t^2+125t+122 = 0$ (real root $`t \approx -1.80081`$) and $`E = (1688-1140t-1044t^2)/361 \approx 0.98429`$ | cubic field of discriminant $-244$ ($x^3+x-6$); all conics over one field of degree 12 | 48 ($`C_2 \times S_4`$) | **all 656 conics real, all with real points** (the real record) | `EXACT` · `CERTIFIED` (reality and the intersection table) |
| **664** | $`\Sigma x^4 - \Sigma x_i^2x_j^2 + 3\sqrt{-5}\, xyzw = 0`$ | $`\mathbb{Q}(\sqrt{-5})`$; conics over $`\mathbb{Q}(i,\sqrt3,\sqrt5)`$ | 96 | two real forms: 32 real conics (12 with real points); 36 real (all with real points) | `EXACT` |
| **704** | $`\Sigma x^4 + \lambda(\Sigma x^2)^2 = 0`$, with $`52\lambda^2+36\lambda+9 = 0`$, $`\lambda = (-9 \pm 6i)/26`$ | $`\mathbb{Q}(i)`$; conics over a degree-8 field $`\mathbb{Q}(i,\sqrt{\varepsilon})`$, $`\varepsilon = (3+\sqrt{13})/2`$ | 192 ($`W(B_4)/\pm1`$) | a complex-conjugate pair; whether it has a real model is untested | `EXACT` · the Barth-Bauer 704 quartic (explicit lattice match) |
| **736** | $-x^4+y^4+z^4+9w^4+6xyzw = 0$ | $`\mathbb{Q}`$; conics over $`\mathbb{Q}(\zeta_{24})`$ | 384 | rational form: 20 real conics (10 with real points); other real form: 40 real (all with real points) | `EXACT` |
| **660** | $`6(x_1^4+\dots+x_5^4) + (x_1^2+\dots+x_5^2)^2 = 0`$ on $`x_1+\dots+x_5 = 0`$ | $`\mathbb{Q}`$; conics over $`\mathbb{Q}(i,\sqrt3,\sqrt5)`$ | 120 ($S_5$) | three real forms: 0, 0 and 32 real conics (0, 0 and 28 with real points); the given rational form has no real points at all | `EXACT` |
| **640** | $`\Sigma x^4 - \Sigma x_i^2x_j^2 + 10\,xyzw = 0`$ | $`\mathbb{Q}`$; conics over $`\mathbb{Q}(\zeta_{24})`$ | 384 | rational form: 32 real conics (16 with real points); best real form: 48 real (44 with real points) | `EXACT` · the Barth-Bauer 640 quartic (explicit lattice match) |

The 656 surface written with real coefficients in the form used by the counting runs is $`w^4 - e\,q\,w^2 + q^2 + t\,p_4 = 0`$ with $`e = +\sqrt E \approx 0.99211`$; it is the same real surface after the real rescaling $`w \mapsto E^{1/4} w`$. The 640 surface is the Hadamard image of the Dwork member $`\Sigma x^4 + 28\,xyzw = 0`$.

## Scorecard: the sealed tests

Every count below was predicted in a sealed file (written and hashed before the run, in [bars/](bars/)) and scored without moving the goalposts. Chips: `HOLD` all predictions passed · `FAILED` at least one prediction failed (kept and reported, never re-scored).

| sealed test | seal id | verdict | what it tested |
|---|---|---|---|
| BAR-656-COUNT (+ amendment) | d9712307b9 (amendment ba6da1440e) | `HOLD` 5/5 | the conic counter, calibrated before it touched any target: random quartic 0, Mukai quartic 800, two generic family members 392 each, 56 conics through the special point, two charts and a second engine agree |
| BAR-656-POINT | 5ab888ffae | `FAILED` (Q1, Q2 `HOLD`; Q3 `FAILED`) | the target point carries 656 conics at two primes and in a second chart (held). The control, a rational point on two of the three curves, was predicted at 512 and gave **560**. Reason, found afterwards and labelled POST HOC: that point is a node of one curve, so two branches of it each add 48 conics. The target prediction held; the bookkeeping rule behind the control did not |
| BAR-664-POINT | e891e02e23 | `HOLD` 5/5 | 664 at three fresh primes with two independent counters; controls 464 (generic) and 472 (special line) |
| BAR-704-POINT | 987d51a5a6 | `HOLD` 3/3 | 704 at two fresh primes with two counters; control 512 |
| BAR-736-POINT | e04e3c3432 | `HOLD` 3/3 | 736 at two fresh primes with the independent counter; control 608 |
| BAR-660-640 | 4baad3e0e3 | `HOLD` 5/5 | 660 and 640 at fresh primes with the independent counter; control 560 |

Sealed counts are counts modulo primes (`MODULAR`). The exact counts over the complex numbers come afterwards, from the certification chain in PAPER.md sections 3 to 6a.

## What each status means

`EXACT` exact arithmetic (our scripts or a named program) · `CERTIFIED` rigorous interval (ball) arithmetic: every sign or integer it reports is proved, not estimated · `MODULAR` exact arithmetic modulo primes · `NUMERICAL` floating point, used only to guide a search or as support · `CITED` published by others, named · `ARGUED` written argument, not machine-checked · `UNTESTED` a lead we noticed and did not test.

## What is ours and what is not

**Not ours.** The existence of all these surfaces, their lattices, their conic configurations and symmetry groups as abstract data, the 800 bound and the real bounds 656 to 718 are Degtyarev's (arXiv 2407.00493, 2108.11181). The existence of Barth-Bauer quartics is Barth and Bauer's (1994) and Bauer's (1995). The families the surfaces live in are classical or published: Goursat's octahedral surfaces (1887), the $W(D_4)$ net (Bonnafé-Sarti; Cheltsov-Sarikyan; the Heisenberg-invariant family of Eklund and Bouyer), the $W(B_4)$ pencil (Smith; Sarti), the Hashimoto pencil (Hashimoto; named by Dolgachev), and the Dwork pencil. The 800-conic Mukai quartic and its conics are Mukai's, Bonnafé-Sarti's, Roulleau's and Naskręcki's. The Dwork parameter values of the 736 and 640 surfaces are printed as CM points: by Ahmed and Ruehle (736, misprinted) and by Arora, Mondal, Nakagawa and Tu (both, correctly); the 640 value is Ramanujan's 1914 singular value. The symmetry rule we use is Veniani's.

**Ours** (prior-art searches dated 20 and 21 November 2026, arXiv included; see PAPER.md section 11): explicit equations of the 656, 664, 704 and 660 surfaces (explicit equation not found in the literature at our search floor), the identification of the 736 and 640 surfaces with printed Dwork parameters, exact lists of all conics on all six surfaces, the exact counts, the real pictures, the conic map of Goursat's family, and two corrections to the literature.

## How to re-check

From `code/`, run `bash stage.sh` once (it copies the data files next to the scripts that read them). Then, for example:

| step | command (from the folder named) | expected |
|---|---|---|
| 656: lattice census, exact count | `656/`: `gp -q lattice.gp` | rank 20, det $-244$, 656 classes of square $-2$ and degree 2, no lines (compare `lattice.out`) |
| 656: second-engine identities | `656/`: `python mksing.py && Singular -q replay.sing` | 30/30 identities reduce to 0 (compare `replay.out`) |
| 656: ball arithmetic | `656/`: `python arbcert.py` | certified signs and Gram (compare `arbcert.out`); needs python-flint |
| the other five | `664/`: `gp -q lattice664.gp`; `704/`: `gp -q lattice704.gp`; `736/`: `gp -q lattice736.gp`; `660-640/`: `gp -q lattice660.gp`, `gp -q lattice640.gp` | 664, 704, 736, 660, 640 classes; no lines |
| lattice match with Degtyarev | `704/`: `gp -q isocheck.gp`; `736/`: `gp -q isocheck736.gp`; `660-640/`: `gp -q isocheck660.gp`, `gp -q isocheck640.gp` | the explicit permutation maps one Gram onto the other |
| counter | `counter/`: `mkdir -p runs && bash count_pipeline.sh mukai 32003 1 test` | 800 |
| Lean | `lean/`: `lean Conic656Disc.lean` | accepted; the control file must fail |

The full list, with tool versions, is in [code/README.md](code/README.md).

## Folder map

| folder or file | contents |
|---|---|
| [PAPER.md](PAPER.md) | the write-up: problem, pipeline, the six surfaces, the Goursat map, untested veins, limits, credits, corrections, loose ends |
| [CORRECTIONS.md](CORRECTIONS.md) | our own errors, found and fixed, and two corrections to the literature |
| [bars/](bars/) | the sealed test files, byte-identical to the sealed versions |
| [references/](references/) | the four prior-art reports (656; 664 and 704; 736; 660 and 640 with the arXiv re-run), local lab paths removed |
| [scores/](scores/) | the scoring logs of all six sealed tests and the scripts that produced them |
| [data/](data/) | exact conics, certified Gram matrices, lattices, permutations, decoded configurations: [data/README.md](data/README.md) |
| [code/](code/) | every script needed to re-check, with its transcript: [code/README.md](code/README.md) |
| [PATCHES.md](PATCHES.md), [FILELIST.md](FILELIST.md), `MANIFEST.sha256` | every change made to a copied file (with the original's sha256); every file with its source; checksums |

## Credits

Degtyarev (the lattices, configurations, bounds and tables we decoded); Barth and Bauer (Barth-Bauer quartics); Goursat (the octahedral family); Smith and Sarti (the $W(B_4)$ pencil and its monodromy); Bonnafé and Sarti, Cheltsov and Sarikyan (the $W(D_4)$ net); Eklund and Bouyer (Heisenberg-invariant quartics); Hashimoto and Dolgachev (the Hashimoto pencil); Mukai, Roulleau and Naskręcki (the 800-conic quartic); Veniani (the symmetry rule and the symmetric-family method); Ahmed and Ruehle, and Arora, Mondal, Nakagawa and Tu (the Dwork CM points); Ramanujan, Zudilin, and Dembélé, Panchishkin, Voight and Zudilin (the CM value $1/7^4$); Pichon-Pharabod and Telen (certified generic counts); Combe (real topology of Goursat's family). Software: PARI/GP, Singular, GAP, msolve, python-flint (Arb), mpmath, sympy, NumPy, Lean 4.

## Loose ends

- **Cited K3 facts were not reopened.** The exact counts use standard facts (Picard number at most 20, even unimodular $H^2$, adjunction, Riemann-Roch, ampleness of the hyperplane class, Torelli, Nikulin's discriminant forms).
- **The 656 Gram match is exact on a numerical Gram.** The explicit vertex-for-vertex match with Degtyarev's (5.14) was run on the numerical Gram; the certified Gram has identical invariants, but the permutation was not re-run on it.
- **664's lattice match is by invariants.** No explicit isometry with the rebuilt Barth-Bauer 664 row was built; $T = [4,0,60]$ is not decided for the 664 model itself (it is decided for the 660 model of the same abstract K3 surface). For 656, $T$ is cited and argued.
- **Real structures are those induced by projective maps.** Real structures that do not preserve the hyperplane class were not studied, the topology of the real surfaces was not computed, the 704 surface's real model is untested, and for one 660 real form it is not decided whether it has any real points.
- **Clean-room rebuild, with gaps.** A fresh copy of this package was rebuilt with the documented commands only: the six lattice censuses, the configuration matches, the two-engine identities, the ball arithmetic, the decoder and both counters reproduced their transcripts. Not re-run from this layout: the Lean files (no Lean toolchain on the rebuild machine; they were checked in the working folder) and some later certification steps for 664, 704 and 736.
- **Not shipped.** The recognition and Gram-building scripts for 660 and 640 (their outputs are shipped; see code/README.md); the raw prior-art query logs and downloaded sources.
- **Completeness of the Goursat map is argued.** The eight special curves are found by a written argument plus tests at 23 points, not by a machine-checked proof that no ninth curve exists.
- **No pictures in this package.** An interactive 3D view of the 656 conics is in the viewer of the companion Y56 atlas release.

## Cite

Moki & Julio (AI-assisted), "Conic records: explicit equations for record quartic surfaces with 656, 664, 704, 736, 660 and 640 conics", version 1.0, 2026, DOI 10.5281/zenodo.24413371. See [CITATION.cff](CITATION.cff). Please also cite Degtyarev, "Conics on smooth quartic surfaces" (arXiv 2407.00493), for the configurations and bounds.

## Licence

Text, data, sealed files, references, score logs and transcripts: CC BY 4.0 ([LICENSE](LICENSE)). Code and program inputs: MIT ([LICENSE-CODE](LICENSE-CODE)).

Written with AI assistance.
