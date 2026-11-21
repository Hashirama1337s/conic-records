# Conic records: explicit equations for record quartic surfaces with 656, 664, 704, 736, 660 and 640 conics

Moki & Julio (AI-assisted) · version 1.0 · release candidate

Status labels used throughout: `EXACT` exact arithmetic · `CERTIFIED` rigorous interval (ball) arithmetic; every sign or integer it reports is proved · `MODULAR` exact arithmetic modulo primes · `NUMERICAL` floating point (guide or support only) · `CITED` published by others, named · `ARGUED` written argument, not machine-checked · `UNTESTED` noticed, not tested. Counts marked DEV are development runs, not sealed tests. Sealed tests are in `bars/`; their verdicts are in the README scorecard.

Notation: $q = x^2+y^2+z^2$ and $p_4 = x^4+y^4+z^4$ (three variables); $`\Sigma x^4`$ and $`\Sigma x_i^2 x_j^2`$ in four variables. A conic class is a class $v$ in the Néron-Severi lattice with $v^2 = -2$ and $`v\cdot h = 2`$, where $h$ is the hyperplane class.

---

## 1. The problem

**In plain words.** A smooth quartic surface can contain at most 800 conics, and only one surface reaches 800. Degtyarev proved this in 2024 by turning conics into vectors of special lattices and classifying all patterns with many conics. His tables describe each record surface by lattice data, not by an equation. For the real version of the question (real surfaces, real conics), he found a surface with 656 real conics and proved that no real quartic has more than 718. So the real record is somewhere from 656 to 718, and at our search floor (20-21 November 2026) nobody had written the 656 surface down. (A different 656-conic surface, Veniani's Q56 with $T = [4,2,16]$, has a published equation; it is not the all-real one.)

Degtyarev's paper (arXiv 2407.00493, `CITED`) proves that a smooth quartic carries at most 800 conics, attained only by the Mukai quartic $`\Sigma x^4 + 12xyzw = 0`$, and classifies the quartics with at least 720 conics (Theorem 1.1: 800, 736, 728, and Schur's quartic with 720). Section 5.3 of the same paper lists further configurations as pictographs in the Niemeier lattice $N(24A_1)$; configuration (5.14) has 656 conics and transcendental lattice $T = [2,0,122]$, and Addendum 1.3 states that its real member has all 656 conics real, irreducible and with real points. Hence, for the maximal number $`N_4(2;\mathbb{R})`$ of real conics on a real smooth quartic,

```math
656 \le N_4(2;\mathbb{R}) \le 718 .
```

Equations were known for 800 (Mukai), 728 (a Klein-curve quartic, printed with the right lattice by Brandhorst-Hashimoto) and 720 (Schur). For 736, 704, 664, 660, 656 and the rest, our prior-art searches found no published equation identified with the surface (for 736 and 640 the Dwork parameter values are printed as CM points, without the surface; sections 6 and 6a) (prior-art search of 20 November 2026). For the Barth-Bauer quartics (quartics with 16 disjoint conics) the authors said so themselves: Barth and Bauer (1994) prove existence and "do, unfortunately, not find their explicit equations" (Manuscripta Math. 85, §0).

This package gives explicit equations, with exact conic counts, for the configurations with 656 (the real record), 664, 704, 736, 660 and 640 conics, and a map of the conic counts over the family that contains the 656 record.

## 2. The method: from a lattice picture to an equation

**In plain words.** We start from Degtyarev's picture of a configuration, rebuild the lattice and its conic vectors, compute which symmetries a surface with that lattice must have, write down every quartic with those symmetries (a family with one or two dials), find the curves in the dial plane where extra conics appear, and go to the point where enough curves meet. Then we prove the count at that point is exact: we find every conic, check each one exactly, and use the lattice to show there is no room for any other conic.

The pipeline has seven steps. Steps 1 to 6 find the surface; step 7 certifies it.

1. **Decoder** (`code/decoder/`). Build the extended binary Golay code, the Niemeier lattice $N(24A_1)$ and the set $O_h$ of vectors $l$ with $l^2 = 4$, $`l\cdot h = 2`$ (5016 of them, `EXACT`). Filter by the pictograph's generators (Degtyarev's Convention 5.6 and (5.3)). Output: the conic set and the Gram matrix of the Néron-Severi lattice. Controls: a misread generator for (5.14) reproduced the numbers of (5.11) (728 conics, det 196); configuration (5.8) gives 800 and det 160. An independent decoder built from a different Golay construction (`code/decoder/decode514.py`) gives the same (5.14).
2. **Lattice.** Rank, determinant, discriminant group, absence of lines (the conic span is $h$-even), conic orbits.
3. **Symmetry.** Veniani's rule (arXiv 1708.01219, Prop. 3.1, `CITED`; used for conics, `ARGUED`): the projective symmetries are the isometries fixing $h$ that act as $`\pm1`$ on the discriminant group (when the Hodge isometries of $T$ are $`\pm1`$); the symplectic ones act as $+1$. Groups are identified with GAP.
4. **Family.** The symmetry group, read as a group of projective maps, gives a family of invariant quartics. Its dimension is $`\mathrm{rank}\,\mathrm{NS}^{\mathrm{Sp}} - 1`$.
5. **Noether-Lefschetz curves.** The conic orbits that are not present on the generic member of the family are grouped by their direction in the invariant lattice; each group is one curve in the parameter plane. Each curve is computed by elimination in a model that uses the stabiliser of the plane of one of its conics.
6. **Point.** The point where enough curves meet. Spurious points (singular members, other lattices) are removed by the conic counter.
7. **Certification.** Numerical conics (damped Gauss-Newton on $`F|_{\text{plane}} = Q_1 Q_2`$ from random starts), closed under the symmetry group; one representative per orbit polished to hundreds of digits; recognition of every coefficient in a number field (integer relations at 330 digits, held-out digits, and a perturbation null that must fail); then **exact** checks: the identity $`F|_{\text{plane}} = \mu Q_1 Q_2`$ in PARI/GP and again in Singular (whose normal form covers all conjugates at once), smoothness and distinctness of every conic, and the full intersection Gram matrix (exact over the number field, or by certified ball arithmetic).

**The lattice census is the exact upper bound.** Let $S$ be the lattice spanned by the classes of the conics we found. If $`\mathrm{rank}\,S = 20`$, then $S$ has finite index $k$ in $`\mathrm{NS}(X)`$ with $`k^2 \mid \det S`$. Every candidate even overlattice is either odd (impossible, $`\mathrm{NS}`$ is even) or contains a class $v$ with $v^2 = -2$, $`v\cdot h = 0`$ (impossible, $h$ is ample). So $`\mathrm{NS}(X) = S`$. Enumerating $S$ with the positive form $`2B(v) = -2v^2 + (v\cdot h)^2 \le 8`$ lists every class with $v^2 = -2$ and $`v\cdot h \in \{0, 1, 2\}`$. No class with $`v\cdot h = 1`$ means no lines, so every conic is a smooth rational curve with $v^2 = -2$, $`v\cdot h = 2`$, and distinct conics have distinct classes. The number of such classes is therefore an upper bound for the number of conics; when it equals the number found, the count is exact. This uses no prime, no chart and no floating point. Cited facts: $`\rho \le 20`$, $`H^2(X,\mathbb{Z})`$ even and torsion-free, adjunction, Riemann-Roch, $h$ ample.

**The counter** (`code/counter/`). Before the exact chain exists, counts come from a modular counter: a plane chart after a random coordinate change over $`\mathbb{F}_p`$ with its centre at a random point of $X$, $Q_1$ monic, the remainder of $F$ modulo $Q_1$ gives 9 equations in 8 unknowns; msolve's leading ideal gives the count with multiplicity and its parametrisation the distinct count. It was calibrated in BAR-656-COUNT (random quartic 0, Mukai 800, generic member 392, `HOLD` 5/5). An independent Singular counter (`code/counter/referee/rcount.sing`, different code, engine and normalisation) scored every later bar.

## 3. The 656 surface: the real record

**In plain words.** The 656 surface lives in Goursat's two-dial family of surfaces with the symmetries of a cube, plus a mirror. Three special curves in the dial plane meet at exactly one real point, with coordinates in a cubic number field. At that point the surface has 656 conics, every one of them real with real points. We wrote down all 656 exactly and proved there are no others.

**Lattice and symmetry** (`EXACT`). Decoded (5.14): 656 conics, rank 20, $`\det = -244`$, no lines, 328 planes each cut in two conics. $`|O_h(\mathrm{NS})| = 96`$; the projective symmetry group is $`C_2 \times S_4`$ = SmallGroup(48,48), with symplectic part $S_4$ = SmallGroup(24,12) (GAP IdGroup). Of the 656 conics, 392 lie in the generic sublattice (rank 18) and 264 are conditional.

**Family** (`ARGUED`, checked by the counts). The central involution is a reflection $`w \mapsto -w`$; $S_4$ acts linearly on $(x,y,z)$; invariance forces

```math
F(e,t) = w^4 + e\,q\,w^2 + q^2 + t\,p_4 ,
```

which is Goursat's octahedral family (1887; `CITED`). We write $E = e^2$. The generic member has 392 conics (sealed, `MODULAR`).

**Noether-Lefschetz curves** (`EXACT` equations; completeness of the model `ARGUED`). The 264 conditional conics fall into three classes: NL1 (+72), $`\mathrm{NL}_A`$ (+144) and $`\mathrm{NL}_B`$ (+48), with $392 + 144 + 72 + 48 = 656$:

```math
\mathrm{NL1}:\ E(t-1)^2 = 2(t+2)(3t+1)^2 ,
```

```math
\mathrm{NL}_A:\ (t+2)(73t+98)E^2 - 8(27t^3+237t^2+416t+196)E + 16(9t^2+21t+14)^2 = 0 ,
```

and $`\mathrm{NL}_B`$ is a curve of bidegree (2,6) in $(E,t)$, printed in `code/656/meet.sing`.

**The point** (`EXACT`). The three curves meet off the singular locus in exactly one Galois orbit, transversally:

```math
9t^3 + 48t^2 + 125t + 122 = 0, \qquad E = \frac{1688 - 1140t - 1044t^2}{361} .
```

The cubic field $`K = \mathbb{Q}(t)`$ has discriminant $-244$ (equal to $`-\det T`$, and to $\det S$), one real embedding, and reduced polynomial $x^3 + x - 6$. Real point: $`t^* = -1.80080644166\ldots`$, $`E^* = 0.98428735233\ldots`$.

**The equation.** Over $K$, the real record is

```math
X_{656}:\quad E\,w^4 - E\,q\,w^2 + q^2 + t\,p_4 = 0 ,
```

real-isomorphic (by $`w \mapsto E^{1/4} w`$) to $`w^4 - e\,q\,w^2 + q^2 + t\,p_4 = 0`$ with $`e = +\sqrt{E^*} = 0.99211257\ldots`$. Its twin $E w^4 + E q w^2 + q^2 + t p_4 = 0$ is the same complex surface with a different real structure and only 56 real conics.

**Verification chain.**

| step | result | label | evidence |
|---|---|---|---|
| smoothness | Jacobian ideal over $K$ has dimension 0 | `EXACT` | `code/656/smooth.sing`, `runs/smooth.out` |
| sealed count | 656 at $p = 40013$ and $40031$, second chart 656 | `MODULAR` (BAR-656-POINT Q1, Q2 `HOLD`) | `bars/` |
| independent counter | 656 distinct at $p = 20021$, 656 at $20029$; generic 392, Mukai 800 | `MODULAR` | `code/counter/referee/runs/` |
| more primes | 656 at 40013 (all three roots), 50023, 50033 (three roots), 50047 | `MODULAR` | development transcripts (not shipped) |
| exact conics | 30 orbit representatives recognised over a field $N_{12}$ of degree 12; $`F\vert _{\text{plane}} = \mu Q_1 Q_2`$ identically, both conics smooth and distinct | `EXACT` (PARI) | `code/656/recog2.gp`, `recog2_final.out`, `data/656/exact_conics.txt` |
| second engine | 30/30 identities reduce to 0 in Singular over $`\mathbb{Q}[s_1,s_2,u]`$ modulo the field relations (all conjugates); negative control fails 30/30 | `EXACT` | `code/656/mksing.py`, `replay.sing`, `replay.out` |
| balls | all $d_j > 0$ (every conic real), no conic definite (every conic has real points), 328 planes pairwise distinct (separation $`\ge 0.0476`$), two distinct conics per plane | `CERTIFIED` (ball arithmetic, 300 bits) | `code/656/arbcert.py`, `arbcert.out` |
| Gram | every one of the $`656 \times 656`$ intersection numbers decided; values $-2$ ×656, 0 ×96432, 1 ×236160, 2 ×96432, 4 ×656 | `CERTIFIED` (ball arithmetic); the census below is then `EXACT` on this integer matrix | `data/656/gram_cert.gp` |
| census | $S$ rank 20, det $-244$, Smith form $`1^{18}\cdot2\cdot122`$; the three index-2 candidates have $x^2 = -3, -3021/2, -3045/2$, none in $`2\mathbb{Z}`$, so $`\mathrm{NS} = S`$; exactly 656 classes $[-2,2]$, none $[-2,1]$ or $[-2,0]$ | `EXACT` | `code/656/lattice.gp`, `lattice.out` |
| Lean | the index-2 exclusion (symmetry of $S$, $h^2 = 4$, the three $v S v$ values, none divisible by 8) kernel-checked, 10 theorems, plain Lean core with `decide`; a control claiming divisibility fails. That these three are the only index-2 candidates ($S/2S$ kernel of dimension 2) is computed in PARI, not in Lean | `EXACT` (kernel-checked) | `code/lean/` |
| configuration | explicit vertex-for-vertex match of the conic Gram with the decoded (5.14) Gram, checked entrywise | `EXACT` match on a `NUMERICAL` Gram | `code/656/iso.py`, `data/656/perm_dec1_to_famminus.npy` |

**Result.** $X_{656}$ has **exactly 656 conics over $`\mathbb{C}`$, all smooth, all real, all with real points, and no lines** (`EXACT`, given the cited K3 facts). All conics are defined over $`N_{12} = K(\sqrt{\gamma}, \sqrt{61})`$ with $`\gamma^3 - \gamma^2 - 36 = 0`$; seven orbits need only a sextic subfield. This is consistent with Schütt's field-of-definition theorem (arXiv 0804.1558): the conics cannot all live over the cubic field.

**Which real surface it is** (`CITED` + `ARGUED`). Degtyarev's (5.14) lists $T = [2,0,122]$ with one real member and $[10,4,26]$ with one complex-conjugate pair. A real quartic cannot belong to a conjugate pair, so our real surface has $T = [2,0,122]$.

**The failed control.** BAR-656-POINT also predicted 512 conics at the rational point $(e,t) = (28/19, -10/9)$, on NL1 and $`\mathrm{NL}_B`$. It gave 560 and the bar is `FAILED`. Afterwards (POST HOC) we found that this point is a node of $`\mathrm{NL}_B`$ (gradient exactly zero, Hessian determinant negative, `EXACT`), so two branches of $`\mathrm{NL}_B`$ pass through it and each adds 48: $392 + 72 + 48 + 48 = 560$. The 560 is supported over $`\mathbb{C}`$ by a numerical count (numerical count over $`\mathbb{C}`$: 560; on the real form all 560 are real with real points, `NUMERICAL`). The member is $`w^4 - \tfrac{28}{19} q w^2 + q^2 - \tfrac{10}{9} p_4 = 0`$, with rational coefficients.

## 4. The 664 surface

**In plain words.** The 664 pattern sits in a different family: quartics unchanged by even sign changes and all permutations of the four coordinates. The dial plane is two-dimensional again; the record is the point where three special curves meet, and its equation needs only $`\sqrt{-5}`$.

**Configuration** (`EXACT`). Barth-Bauer row of Degtyarev's Kummer paper (arXiv 2108.11181, Table 6, `CITED`): "3,4,4,6,6,7 | 664 | 768 | 12 | 49² | [4,0,60] (1,0) (2,0)". We rebuilt it from Degtyarev's recipe: 664 conics, det $-240$, discriminant $`\mathbb{Z}/60 \oplus \mathbb{Z}/4`$, no lines. The same abstract K3 surface carries configuration (5.13) with 660 conics under a different polarisation (`EXACT` discriminant forms + `CITED` uniqueness in the genus).

**Symmetry** (`EXACT`). $|O_h| = 768$; $`|\mathrm{Sym}| = 96`$ = SmallGroup(96,227); symplectic part SmallGroup(48,50) = Xiao #49. Twelve non-symplectic involutions, read as reflections (`ARGUED`).

**Family** (`ARGUED`, checked by counts 464, 472, 664). $`F(a{:}b{:}c) = a\,\Sigma x^4 + b\,\Sigma x_i^2x_j^2 + c\,xyzw`$, invariant under even sign changes and $S_4$ (order 96). Generic member 464 conics. The conditional conics form three classes: $`\mathrm{NL}_8`$ (+8, the line $b = -a$, where the four coordinate planes split), and two classes of +96 each. On $b = -a$, elimination gives the candidate values of $c$; $c^2 = -45$ carries 664.

**The equation.**

```math
X_{664}:\quad \Sigma x^4 - \Sigma x_i^2 x_j^2 + c\,xyzw = 0, \qquad c = 3\sqrt{-5} .
```

The sign of $c$ does not matter ($`x \mapsto -x`$).

**Verification chain.**

| step | result | label |
|---|---|---|
| smoothness | dimension 0 over $`\mathbb{Q}(\sqrt{-45})`$ | `EXACT` (`code/664/sing1.sing`) |
| sealed count | 664 at $p = 20023$ (distinct), 20047, 20063; controls 464, 472 | `MODULAR` (BAR-664-POINT `HOLD` 5/5) |
| exact conics | 17 orbit representatives over $`L = \mathbb{Q}(i,\sqrt3,\sqrt5)`$; 17/17 identities in PARI and 17/17 in Singular; negative control fails 17/17 | `EXACT` |
| closure | 664 distinct smooth conics on 332 planes, exactly two per plane | `EXACT`, ball-certified |
| Gram | $`C\cdot A = \deg\gcd(q_C, q_A)`$ over $L$, symmetric, 32 triple points; ball replay agrees on all 440,832 decided entries | `EXACT` |
| census | $S$ rank 20, det $-240$, Smith form $`1^{18}\cdot4\cdot60`$; one even index-2 overlattice exists but contains 12 $\pm$ pairs of classes with $v^2=-2$, $`v\cdot h=0`$, so it is excluded; $`\mathrm{NS} = S`$; exactly 664 classes, no lines | `EXACT` |
| real picture | two real structures from projective maps; $h_1$ ($`w \mapsto iw`$): 32 real conics, 12 with real points; $h_2$: 36 real, all with real points | `EXACT` reality, ball-certified real points |

**Result.** $X_{664}$ has **exactly 664 conics over $`\mathbb{C}`$, all smooth, no lines** (`EXACT`). Identification with the Barth-Bauer 664 row rests on the matching invariants (664 conics, $|O_h| = 768$, symmetry group, det 240) and the row's uniqueness (`CITED`); an explicit isometry with the rebuilt row lattice was not built, and $T = [4,0,60]$ is not decided within its genus (`ARGUED`). It is not a real record: the best real form has 36 real conics.

## 5. The 704 surface = the Barth-Bauer 704 quartic

**In plain words.** The 704 surface is a member of a classical one-dial family, the $W(B_4)$ pencil $`\Sigma x^4 + \lambda(\Sigma x^2)^2`$, at a non-real value of the dial. It also sits inside Goursat's family, where three special curves meet. We matched its conics one by one with the lattice Degtyarev built for the 704-conic Barth-Bauer quartic, so this is that surface.

**Where it was found.** In the Goursat map (section 7) the curves $`\mathrm{NL}_A`$, $`\mathrm{NL}_B`$ and Smith's curve $S: E(1+t) = 4$ meet at the complex pair $9t^2 + 36t + 52 = 0$, $E = -(36t+108)/25$, with predicted count $392 + 144 + 48 + 120 = 704$. Rewritten in Smith's normalisation ($`\lambda = 1/t`$, $`w \mapsto s w`$ with $`s^2 = 2\lambda/(1+\lambda)`$; `EXACT`):

```math
X_{704}:\quad \Sigma x^4 + \lambda\,(\Sigma x^2)^2 = 0, \qquad 52\lambda^2 + 36\lambda + 9 = 0,\quad \lambda = \frac{-9 \pm 6i}{26} .
```

**Verification chain.**

| step | result | label |
|---|---|---|
| smoothness | Jacobian ideal dimension 0, vdim 81, over $`\mathbb{Q}(i)`$ | `EXACT` (`code/704/smooth704.sing`) |
| sealed count | 704 at $p = 20101$ (distinct) and 20113; control 512 on Smith's curve | `MODULAR` (BAR-704-POINT `HOLD` 3/3) |
| exact conics | 11 orbit representatives over the $D_4$ octic $`N_8 = \mathbb{Q}(i, \sqrt{\varepsilon})`$, $`\varepsilon = (3+\sqrt{13})/2`$; 11/11 identities in PARI and in Singular | `EXACT` |
| closure and Gram | 704 distinct conics on 352 planes; every Gram entry decided exactly over $N_8$; symmetric, invariant under all 384 signed permutations | `EXACT` |
| census | rank 20, det $-208$; the even index-2 overlattice contains 12 $\pm$ pairs of roots in $`h^\perp`$, excluded; $`\mathrm{NS} = S`$; exactly 704 classes, no lines | `EXACT` |
| symmetry | $`\vert O_h\vert  = 768`$; $`\mathrm{Sym} = W(B_4)/\pm1`$, order 192, SmallGroup(192,955); symplectic part SmallGroup(96,227) = Xiao #65 | `EXACT` + `CITED` Torelli |
| $T$ | among the reduced even binary forms of det 208, only $[8,4,28]$ has the right discriminant form | `EXACT` |
| Barth-Bauer | Degtyarev's 704 row rebuilt from his recipe (704 conics, det $-208$, no lines); explicit permutation mapping its conic Gram onto ours, checked entrywise in Python and in PARI; 16 pairwise disjoint conics on $X_{704}$ | `EXACT` |

**Result.** $X_{704}$ and its complex conjugate have **exactly 704 conics**, all smooth, no lines (`EXACT`), and form the 704-conic Barth-Bauer pair of Degtyarev's Table 6 (lattice match `EXACT`; uniqueness of the pair `CITED`, row data $(r,c) = (0,1)$). Whether $X_{704}$ has a real model is `UNTESTED`.

## 6. The 736 surface = the Dwork CM point

**In plain words.** The 736 surface is a member of the Dwork pencil $`\Sigma x^4 + c\,xyzw`$, the famous one-dial family used in mirror symmetry. The right member has a rational model. Physicists had already printed its parameter as a special (CM) point, but with the parameter turned upside down, and without knowing it carries 736 conics.

**Configuration** (`EXACT`). Decoded (5.10): 736 conics, rank 20, det 192, no lines, $T = [12,0,16]$. $|O_h| = 3072$, $`|\mathrm{Sym}| = 384`$, symplectic part of order 192 ($4^2A_4$; Xiao #75 `ARGUED` from element orders); $`\mathrm{rank}\,\mathrm{NS}^{\mathrm{Sp}} = 2`$, a one-parameter family: the Dwork pencil (Smith; Degtyarev Addendum 1.4, `CITED`).

**The equation.** In the convention $`\Sigma x^4 - 4\psi\,xyzw`$, the member is $`\psi^4 = -9/16`$ ($c^4 = -144$). Its rational model:

```math
X_{736}:\quad -x^4 + y^4 + z^4 + 9w^4 + 6\,xyzw = 0 .
```

The equivalence is `EXACT`: for $`\sum a_i x_i^4 + c\prod x_i`$ the only invariant of diagonal scaling is $c^4/(a_0a_1a_2a_3)$, equal to $-144$ for both forms.

**Verification chain.**

| step | result | label |
|---|---|---|
| smoothness | dimension 0, vdim 81, over $`\mathbb{Q}`$ | `EXACT` (`code/736/smooth736.sing`) |
| sealed count | 736 at $p = 20201$ (distinct) and 20219; control 608 (generic Dwork member) | `MODULAR` (BAR-736-POINT `HOLD` 3/3) |
| exact conics | 8 orbit representatives over $`\mathbb{Q}(\zeta_{24})`$; 8/8 identities in PARI and in Singular | `EXACT` |
| closure and Gram | 736 distinct conics on 368 planes; 256 entries undecided from one side were decided from the other (intersection numbers are symmetric) | `EXACT` |
| census | rank 20, det $-192$; the even index-2 overlattice contains 12 $\pm$ pairs of roots in $`h^\perp`$, excluded; $`\mathrm{NS} = S`$; exactly 736 classes, no lines | `EXACT` |
| symmetry | the 384 monomial maps $`(\mathbb{Z}/4)^2 : S_4`$ preserve $F$ and act faithfully; SmallGroup(384,18135), symplectic part SmallGroup(192,1023) | `EXACT` + `CITED` Torelli |
| configuration | explicit permutation mapping the decoded (5.10) Gram onto ours, checked in Python and PARI | `EXACT` |
| real picture | two real structures; the rational model: 20 real conics, 10 with real points; the other: 40 real, all with real points (exact signs) | `EXACT` |

**Result.** $X_{736}$ has **exactly 736 conics over $`\mathbb{C}`$**, all smooth, no lines (`EXACT`); it is Degtyarev's (5.10). No real form comes close to all-real (at most 40), consistent with $T$ having no vector of square 2.

**The printed parameter.** Ahmed and Ruehle (arXiv 2304.00027, JHEP 06 (2023) 164) list the CM points $`\tau = (1+3i)/2`$ and $`\tau = (1+\sqrt3 i)/2`$ of the Dwork family, with "$`\psi^{-4} = -1/48`$ and $`\psi^{-4} = -9/16`$". Their own formula gives $`\psi^{-4} = -16/9`$ at the second point, that is $`\psi^4 = -9/16`$: our $X_{736}$. Arora-Mondal-Nakagawa-Tu (arXiv 2601.07030, Table 3(B)) print the correct value $t_4 = -16/9$ for this point, which confirms the misprint independently. See section 12. What we claim is therefore the identification (this CM point is the 736-conic quartic, with $T = [12,0,16]$ and its explicit conics), not the polynomial.

**Arithmetic certificate** (`NUMERICAL`). The eta quotient $`\rho(\tau) = 256\,\eta(\tau)^{24}\eta(2\tau)^{24}/(\eta(\tau)^{24} + 64\,\eta(2\tau)^{24})^2`$ gives $`\rho((1+\sqrt{-3})/2) = -16/9`$ to 30 digits (`code/736/rho.py`).

### 6a. The 660 and 640 surfaces

**In plain words.** Two more patterns went through the whole pipeline. The 660 surface is a member of a pencil of quartics with the symmetries of five points, studied by Hashimoto; the 640 surface is another special member of the Dwork pencil, at a parameter value Ramanujan used in 1914 for a series for $`1/\pi`$. Both have rational equations, and both counts are now exact.

**660, configuration (5.13).** Symmetry group $S_5$ (lattice side, `EXACT`). The family is the $S_5$-invariant pencil $`p_4 + L\,p_2^2`$ on $`\sigma_1 = 0`$ in $`\mathbb{P}^4`$ (our derivation `ARGUED`, using the Shephard-Todd classification cited from memory; the pencil is Hashimoto's, see below). Two independent eliminations give the single smooth point $L = 1/6$:

```math
X_{660}:\quad 6(x_1^4+\dots+x_5^4) + (x_1^2+\dots+x_5^2)^2 = 0, \qquad x_1+\dots+x_5 = 0 .
```

**640, $T = [4,0,72]$.** The member $c = 10$ of the line $b = -a$ in the 664 family,

```math
X_{640}:\quad \Sigma x^4 - \Sigma x_i^2 x_j^2 + 10\,xyzw = 0 ,
```

is the Hadamard image of the Dwork member $`\Sigma x^4 + 28\,xyzw`$: with $H$ the $`4 \times 4`$ Hadamard matrix, $`F_{\mathrm{Dwork}}(Hv) = 32\,F_{640}(v)`$ identically (`EXACT`). In the convention $`\Sigma x^4 - 4\psi\,xyzw`$ this is $`\psi^{-4} = 1/7^4`$, the CM point $`\tau = 3i/\sqrt2`$ of the same eta quotient (`NUMERICAL`, 60 digits).

**Verification chain** (same route as 704 and 736).

| step | X660 | X640 | label |
|---|---|---|---|
| smoothness | dimension 0, vdim 81 | dimension 0 | `EXACT` |
| sealed count (BAR-660-640, seal 4baad3e0e3) | 660 distinct at $p = 20231$, 660 at 20233 | 640 distinct at 20231, 640 (Dwork form) at 20233; control 560 | `MODULAR`, `HOLD` 5/5 |
| exact conics | 13 orbit representatives over $`\mathbb{Q}(i,\sqrt3,\sqrt5)`$ (degree 8, contains $`\sqrt{-15}`$); 13/13 identities in PARI and in Singular | 8 representatives over $`\mathbb{Q}(\zeta_{24})`$ (contains $`\sqrt{-2}`$); 8/8 in PARI and in Singular | `EXACT` |
| closure and Gram | 660 distinct smooth conics on 330 planes; Gram symmetric, rank 20, invariant under all 120 maps | 640 on 320 planes; invariant under all 384 maps | `EXACT` |
| census | det $-240$, Smith form $[60,4]$; the even index-2 overlattice has 10 $\pm$ pairs of roots in $`h^\perp`$, excluded; $`\mathrm{NS} = S`$; exactly 660 classes, no lines | det $-288$, Smith form $[72,4]$; even index-2 and index-3 overlattices have 15 and 16 $\pm$ pairs of roots in $`h^\perp`$, excluded; $`\mathrm{NS} = S`$; exactly 640 classes, no lines | `EXACT` |
| configuration | explicit permutation onto the decoded (5.13), checked in Python and PARI, $h$ preserved | explicit permutation onto the rebuilt Table 6 640 row, checked in Python and PARI | `EXACT` |
| $T$ | $[4,0,60]$, the only reduced form of det 240 with the right discriminant form | $[4,0,72]$, the only one of det 288 | `EXACT` given Nikulin (`CITED`) |
| symmetry | $S_5$ = SmallGroup(120,34); symplectic part $A_5$ | SmallGroup(384,18135); symplectic part SmallGroup(192,1023) | `EXACT` + `CITED` Torelli |
| real picture | three real structures: 0, 0 and 32 real conics, with 0, 0 and 28 having real points; the given rational form has no real points at all ($6p_4 + p_2^2 > 0$) | five real structures (one quaternionic, no real points); the rational form: 32 real conics, 16 with real points; the best: 48 real, 44 with real points | `EXACT` (exact signs) |

**Results.** $X_{660}$ has **exactly 660 conics**, all smooth, no lines; it is Degtyarev's (5.13) with $T = [4,0,60]$ and automorphism group $S_5$. $X_{640}$ has **exactly 640 conics**, all smooth, no lines; it is the 640-conic Barth-Bauer quartic of Table 6 (explicit polarised isometry `EXACT`; uniqueness of the row, $(r,c) = (1,0)$, `CITED`), with $T = [4,0,72]$ and automorphism group of order 384. Transcripts: `code/660-640/`; data: `data/660/`, `data/640/`.

**Prior art** (`references/PRIOR-ART-660-640.md`, 21 November 2026). The pencil is published: it is Hashimoto's family (arXiv 0904.0072, J. reine angew. Math.), named "the Hashimoto pencil" by Dolgachev (arXiv 1604.02567); $X_{660}$ is Hashimoto's fibre $t = (6:1)$. Our member as a Picard-20 surface with $T = [4,0,60]$ and 660 conics was not found at our search floor. For $X_{640}$ the parameter is published: $`\psi^{-4} = 1/7^4`$ is Ramanujan's 1914 singular value (via Zudilin, arXiv 0712.1332, and Dembélé-Panchishkin-Voight-Zudilin, arXiv 1906.07384), and Arora-Mondal-Nakagawa-Tu (arXiv 2601.07030, Table 3(B)) list $`\tau = 3i/\sqrt2`$, $t_4 = 1/7^4$. At our search floor no source states the K3 surface, $T = [4,0,72]$ or the 640 conics. What we claim for 640 is the identification, the conics and the certificate, not the parameter.

## 7. The conic map of Goursat's family

**In plain words.** We mapped the whole dial plane of the family that holds the 656 record. We found eight special curves where extra conics or lines appear (that there is no ninth is argued, not machine-checked). At any point, the number of conics is 392 plus the extras of every curve passing through that point, counting each branch. Every one of 23 tested points obeys this rule, including several that initially looked like surprises. The record sits inside the only region of the real plane where all generic conics are real.

**The eight curves** (lattice completeness `ARGUED`; equations `EXACT`; counts DEV/`MODULAR`, two charts):

| curve | equation ($E = e^2$) | adds | generic count on it |
|---|---|---|---|
| $`\mathrm{NL}_A`$ | section 3 | +144 | 536 |
| $S$ (Smith's $W(B_4)$ slice) | $E(1+t) = 4$ | +120 | 512 |
| NL1 | $E(t-1)^2 = 2(t+2)(3t+1)^2$ | +72 | 464 |
| $`\mathrm{NL}_B`$ | `code/656/meet.sing` | +48 | 440 |
| $X_2$ | `code/family/curves.gp` | +24 | 416 |
| $F_a$ | $9E(11t+6)(t+2) = 4(t+3)(7t+6)^2$ | +16 | 408 |
| $L_a$ | $E(1-t) = 4$ | 24 lines, +12 line-pair classes | 404 |
| $L_e$ | `code/family/curves.gp` | 24 lines | 392 |

All eight are rational curves. The singular members lie on $t(t+1)(t+2)(t+3)(E-2t-4)(3E-4t-12)(E-4t-4) = 0$ (`EXACT`).

**The additive rule** (`ARGUED` on the lattice side, theorem-shaped): at a smooth member, count $`= 392 + \sum`$ (increment of each curve branch through the point). DEV side: 23/23 counted points fit, 22 predicted before the run. Examples: the 656 triple point ($392+144+72+48$); the 704 pair ($`\mathrm{NL}_A`$, $`\mathrm{NL}_B`$, $S$); the node of $`\mathrm{NL}_B`$ crossed by NL1 (560); a quadruple point of $`\mathrm{NL}_A`$, $`\mathrm{NL}_B`$, $L_a$, $L_e$ carrying 48 lines (596); two real 576 points; the rational point $(28/11, 4/7)$ on $`\mathrm{NL}_B`$ and $S$ (560); and along $E = 0$ (an extra symmetry $`w \mapsto iw`$), where a curve's increment doubles (536 at $(e,t) = (0,-1/3)$).

**Mukai 800 inside** (`EXACT` placement, `CITED` surface). The point $(E,t) = (-12,-4/3)$ is the node of $`\mathrm{NL}_A`$, with $S$ passing through it: $`392 + 2\cdot144 + 120 = 800`$. It is the Mukai quartic in Bonnafé-Sarti's form $`\Sigma x_i^4 - 6\Sigma x_i^2x_j^2 = 0`$ (arXiv 1910.05955; the placement in the family is an exact rescaling).

**The real picture** (`NUMERICAL`). Sampling every chamber of the real plane (cut by the discriminant and by $E = 0$) in six real structures: exactly one chamber, $-2 < t < -1$, $2t+4 < E < (4t+12)/3$, makes all 392 generic conics real, on the real form $E w^4 - E q w^2 + q^2 + t p_4$. The 656 point lies in that chamber. **656 is the maximum number of real conics over the real Goursat family** (`ARGUED`): real cannot exceed complex; the only smooth real members with at least 656 complex conics are the 656 point and the Mukai point; the Mukai member has at most 56 real conics in each family real structure (`NUMERICAL`) and at most 560 as a real Barth-Bauer quartic (Degtyarev 2108.11181, Thm 1.6, `CITED`).

## 8. No hidden symmetry: the t = infinity gluing

**In plain words.** The real chamber table showed pairs of chambers with identical real counts, as if a hidden mirror folded the dial plane. There is no such mirror. The chart we used cuts the plane along a line at infinity; in Goursat's own coordinates that line is ordinary, and each pair is one chamber seen from both ends of a strip.

- **No symmetry** (`ARGUED`; each lattice step `EXACT`, Torelli `CITED`). The image of $`O(\mathrm{NS}_{\mathrm{gen}}, h)`$ in the orthogonal group of the discriminant form has index 1 (both of order 256); with Torelli, very general members are isomorphic (even abstractly) only when their $(E,t)$ agree. The normaliser of the symmetry group in $`\mathrm{PGL}_4`$ is the group times a torus that acts only by $`e \mapsto -e`$.
- **The gluing** (`EXACT` discriminant in the new chart). In $u = E/t$, $s = 1/t$ the line $`t = \infty`$ is $s = 0$, which is not a component of the discriminant. The three lines through $(E,t) = (4,0)$ become parallel, giving 20 real chambers, not 25. The strip $s > -1/3$ contains both $t > 0$ and $t < -3$; its five bands are the five observed pairs, in the predicted order. The one near-miss pair differs only in "with real points" numbers because the line curve $L_a$ passes between the two sample points.

## 9. Untested veins

**In plain words.** Two questions came up that we did not settle. We record them because they may matter more than what we did settle.

- **Quaternion structure of Goursat's family** (`UNTESTED`). The generic transcendental lattice $`T_{\mathrm{gen}}`$ (rank 4, signature (2,2), det 576) is anisotropic over $`\mathbb{Q}`$ (`EXACT`; Hasse invariants differ from the split form exactly at 2 and 3). So $`T_{\mathrm{gen}} \otimes \mathbb{Q}`$ is a multiple of the reduced norm of the indefinite quaternion algebra of discriminant 6 (`ARGUED`, via van Geemen, arXiv math/9903146, Thm 7.7, `CITED`), and the moduli of the family would be a compact Shimura-type surface commensurable with $`X_6 \times X_6`$; generic members then have no Shioda-Inose structure (`ARGUED`). Prior art: Smith's thesis (arXiv 0705.3658) computes the monodromy of the one-parameter slice $S$ and places it in the quaternion algebra $(3,-1)$; we checked that $(3,-1)$ over $`\mathbb{Q}`$ is ramified exactly at 2 and 3, the same discriminant-6 algebra (the identification is ours, `ARGUED`). The two-parameter statement was not found in the literature at our search floor (21 November 2026, arXiv included). Whether the eight curves are Hecke-type correspondences is open.
- **The 656 to 718 question** (`UNTESTED`). Within Goursat's family, 656 is the real maximum (section 7, `ARGUED`). Nothing here decides whether some other real quartic exceeds 656 real conics; Degtyarev's bound leaves room up to 718.

## 10. The method's limit: 616 needs a four-dimensional family

**In plain words.** The pipeline works when the symmetry group is big enough to leave a family with one or two dials. The next real candidate, a pattern of 616 conics that could all be real, has too few symmetries: its family has four dials, and four special conditions would have to meet at a point.

Configuration with $T = [2,0,138]$ from Degtyarev's companion tables (decoded, `EXACT`): 616 conics, rank 20, det 276, no lines. $|O_h| = 64$, $`|\mathrm{Sym}| = 16`$, $`|\mathrm{Sp}| = 8`$ ($D_4$, `ARGUED` from element orders), $`\mathrm{rank}\,\mathrm{NS}^{\mathrm{Sp}} = 5`$, so the invariant family has dimension 4. We stopped there.

## 11. What is ours and what is credited

**In plain words.** The surfaces exist because Degtyarev proved it; the families they live in are mostly classical. What we add is the equations, every conic written out and checked, exact counts, and the map of where conics appear.

**Credited** (`CITED`):

- A. Degtyarev, *Conics on smooth quartic surfaces*, arXiv 2407.00493 (v2): the 800 bound, Theorem 1.1, the configurations (5.8), (5.10), (5.13), (5.14), the real bounds 656 to 718, the companion tables.
- A. Degtyarev, *Conics in Kummer quartics*, arXiv 2108.11181: Barth-Bauer rows (664, 704, 640), real Barth-Bauer bound 560 (Thm 1.6). A. Degtyarev, *800 conics in a smooth quartic surface*, arXiv 2102.08163.
- W. Barth, Th. Bauer, *Smooth quartic surfaces with 352 conics*, Manuscripta Math. 85 (1994) 409-417, DOI 10.1007/BF02568207; Th. Bauer, *Quartic surfaces with 16 skew conics*, J. reine angew. Math. 464 (1995) 207-217, DOI 10.1515/crll.1995.464.207: existence of the Barth-Bauer quartics, without equations.
- É. Goursat, Ann. Sci. ENS (3) 4 (1887) 159-200, DOI 10.24033/asens.295: the octahedral family (record only; the family identification rests on its standard affine form).
- J. P. Smith, PhD thesis (Warwick), arXiv 0705.3658: the $W(B_4)$ pencil, its symmetry-jump points and quaternion monodromy; Sarti, arXiv math/0303364: the same pencil and its nodal members.
- Bonnafé and Sarti, arXiv 1910.05955 and 2005.04460; Cheltsov and Sarikyan, arXiv 2202.09319: the $W(D_4)$ net containing the 664 and 640 members, and the Mukai quartic's form.
- Eklund, arXiv 1010.4058; Bouyer, arXiv 1511.01781: the Heisenberg-invariant family.
- Mukai (the 800-conic quartic); Roulleau (its automorphism group, as credited in 2102.08163); Naskręcki, arXiv 2108.13402 (its 800 conics).
- Veniani, arXiv 1708.01219: the symmetry rule and the symmetric-family method; also the 656-conic surface Q56 (a different surface).
- Brandhorst and Hashimoto, arXiv 1910.05952: the 728-conic quartic with its lattice.
- F. Schur (1882): the 720-conic quartic (record only, not opened).
- Fu, arXiv 2609.36045: the Dwork CM values, printed correctly.
- Ahmed and Ruehle, arXiv 2304.00027 (JHEP 06 (2023) 164): the Dwork CM points and the eta quotient.
- Pichon-Pharabod and Telen, arXiv 2509.06785 (v2): certified generic conic counts of invariant families.
- Hashimoto, *Period map of a certain K3 family with an S5-action* (appendix by Terasoma), arXiv 0904.0072, J. reine angew. Math.: the $S_5$ pencil containing $X_{660}$; Dolgachev, *Quartic surfaces with icosahedral symmetry*, arXiv 1604.02567 (Adv. Geom. 2018): the name "Hashimoto pencil" and its classical members.
- Ramanujan (1914), via Zudilin, arXiv 0712.1332, and Dembélé-Panchishkin-Voight-Zudilin, arXiv 1906.07384: the CM value $1/7^4$ of the Dwork period; Arora-Mondal-Nakagawa-Tu, arXiv 2601.07030, Table 3(B): the CM points $`\tau = 3i/\sqrt2`$ ($t_4 = 1/7^4$) and $`\tau = (1+\sqrt3 i)/2`$ ($t_4 = -16/9$).
- Combe, arXiv 1410.1300: real topology of Goursat's family. Schütt, arXiv 0804.1558: fields of definition. van Geemen, arXiv math/9903146 (Kuga-Satake varieties). Hashimoto, arXiv 1012.2682 (Table 10.2, symplectic group actions on K3 surfaces).

**Ours, with the prior-art verdicts** (gates dated 20 and 21 November 2026; Zenodo, OpenAlex, arXiv abstracts and general web search, each zero-hit query paired with a passing control):

| item | verdict |
|---|---|
| equation of the 656-real-conic quartic (5.14), as a member of Goursat's family over the cubic field of discriminant $-244$ | explicit equation not found in the literature at our search floor (20 November 2026) |
| equation of the 664 member ($`c = 3\sqrt{-5}`$) | explicit equation not found in the literature at our search floor (21 November 2026); the family is published |
| equation of the 704 member ($`52\lambda^2 + 36\lambda + 9 = 0`$) | explicit equation not found in the literature at our search floor (21 November 2026); the pencil is published |
| identification of the 736-conic quartic with the Dwork CM point $`\psi^4 = -9/16`$, with its conics and $T$ | not found at our search floor (21 November 2026); the parameter value is printed, unlabelled: misprinted by Ahmed-Ruehle, correctly by Arora-Mondal-Nakagawa-Tu (2601.07030) |
| conic counts and Noether-Lefschetz curves on Goursat's family | not found at our search floor (20 November 2026) |
| equation of the 660 member, Hashimoto's fibre $t = (6:1)$, as a Picard-20 surface with $T = [4,0,60]$ and 660 conics | not found at our search floor (21 November 2026); the pencil is published |
| identification of the 640-conic quartic with the Dwork CM point $`\psi^{-4} = 1/7^4`$, $`\tau = 3i/\sqrt2`$, with its conics and $T$ | not found at our search floor (21 November 2026); the parameter value is published (Ramanujan; Arora-Mondal-Nakagawa-Tu) |
| exact conic lists and exact counts for all six surfaces; real pictures | ours |
| the quaternion disc-6 statement for the two-parameter family | `UNTESTED`; two-parameter statement not found; the one-parameter slice is published (Smith) |

## 12. Corrections to the literature, found in passing

**In plain words.** Two published numbers look like misprints. In both cases our evidence is strong but indirect, so we label them `ARGUED` and give the checks. For the Dwork value, later papers (Arora, Mondal, Nakagawa and Tu, 2026) print it correctly.

1. **Ahmed-Ruehle, arXiv 2304.00027, eq. (61) (also JHEP eq. (5.2)): "$`\psi^{-4} = -9/16`$" should read $`\psi^4 = -9/16`$** (equivalently $`\psi^{-4} = -16/9`$). Evidence:
   - their eta quotient (47), in their convention (27) $`\Sigma z^4 - 4\psi\prod z`$, gives $`\rho((1+\sqrt{-3})/2) = -16/9`$ to 30 digits; the other CM value in the same sentence, $-1/48$, is reproduced, as in Dembélé-Panchishkin-Voight-Zudilin (arXiv 1906.07384) and Fu (arXiv 2609.36045) (`NUMERICAL`);
   - their Figure 7 shows dashed lines at $`\rho = -0.61`$ and $-1.86$ on the slice $`\psi = (1+i)\rho`$; $`\psi^4 = -9/16`$ gives $`|\rho| = 0.612372`$, while the printed value would give $0.816497$ (`NUMERICAL`);
   - our counter: $`\psi^4 = -9/16`$ gives 736 conics (sealed, `MODULAR`), the printed $`\psi^{-4} = -9/16`$ gives 608, the generic count (DEV).
   - confirmed independently by Arora-Mondal-Nakagawa-Tu (arXiv 2601.07030, p.20 and Table 3(B)), who print $`t_4((1+\sqrt3 i)/2) = -16/9`$ for the same eta quotient (`CITED`).
   - Strength: strong. The figure was computed at the corrected value, and a later paper prints the correct value; only the printed equation is inverted.
2. **Smith, arXiv 0705.3658, §1.3: "M20 at $`\lambda = 3/4`$" should likely read $`\lambda = -3/4`$.** Evidence:
   - Bonnafé-Sarti's Mukai form is $`\lambda = -3/4`$ in Smith's normalisation (exact rescaling check, `EXACT`), and it is the point $(E,t) = (-12,-4/3)$ with 800 conics (section 7);
   - $`\lambda = +3/4`$ is $(E,t) = (12/7, 4/3)$, where our counter gives 512 conics in two charts, the generic count on Smith's curve, not 800 (DEV, `MODULAR`).
   - Strength: moderate. It rests on one DEV point (two charts); it excludes a second M20 member at $+3/4$ but does not explain how the sign arose.

## 13. Independent confirmation of Pichon-Pharabod-Telen's certified counts

**In plain words.** A 2025 paper certified the generic number of conics for quartic families invariant under various groups. Our counter, built for a different purpose, reproduces six of their rows.

Pichon-Pharabod and Telen (arXiv 2509.06785v2, Table 4, under their Theorem 22: the columns "are certified for all rows") list generic conic counts. We built members of six families from their printed generators and group action with the Reynolds operator (`code/counter/ppt/ppt_members.py`; the dimensions reproduce their table) and counted:

| group | certified count | ours (two members, $p = 32003$ and $65521$) |
|---|---|---|
| $S_5$ | 560 | 560, 560, 560 |
| $F_5$ | 400 | 400, 400, 400 |
| $S_4$ ($A_4$) | 344 | 344, 344, 344 |
| $D_6$ | 200 | 200, 200, 200 |
| $K_4$ | 128 | 128, 128, 128 |
| $Z_2$ | 56 | 56, 56, 56 |

All agree (`MODULAR`, counts with multiplicity; distinct counts not run). Transcripts: `code/counter/ppt/ppt_batch1.log`, `ppt_batch2.log`.

## 14. Loose ends

- **660 and 640 real forms.** For the 660 transposition real structure (no real conics), whether the real surface has any real points was not decided. Four of the 28 real conics with real points on the third 660 real form are counted by an isotropic-vector argument (a singular leading minor), not a sign pattern.
- **Cited K3 facts** ($`\rho \le 20`$, even unimodular $H^2$, adjunction, Riemann-Roch, ampleness of $h$, Torelli) were not reopened.
- **656: configuration match on the certified Gram.** The explicit permutation to the decoded (5.14) was found on the numerical Gram; the certified Gram has the same value counts and lattice invariants, but the permutation was not re-checked against it.
- **664: Barth-Bauer identification** rests on invariants and table uniqueness; no explicit isometry with the rebuilt row; $T = [4,0,60]$ not decided within its genus (for the 660 model of the same abstract K3 surface it is decided). $T$ for 656 is `CITED` + `ARGUED`.
- **Family derivations** (Goursat for 656, the $W(D_4)$ net for 664, the $S_5$ pencil for 660) are `ARGUED`; they are not needed for correctness, because each equation is verified directly.
- **Completeness of the eight-curve map** and the additive rule are `ARGUED`; the rank-20 lattice catalogue is a lower-bound list; 31 lattice types are argued unrealised; some special points were not counted (the 728 point on $E = 0$, which is not real: it lies at $9t^2+21t+14 = 0$, discriminant $-63$, so the argued list of real maxima is not affected; a second 608 point, about 12 low-count intersections).
- **The 704 surface's real model** is `UNTESTED`; real structures outside the polarised setting and the topology of the real surfaces were not studied for any surface.
- **Smith's sign** rests on one DEV point (two charts).
- **Xiao numbers.** The identifications (192,1023) = Xiao #75 and (96,227) = Xiao #65 were read from orders and element-order counts, not re-checked against Xiao's table.
- **The PPT check** counts with multiplicity only.
- **Not re-run from this layout.** Every script ran in the working folder; only paths were changed for release. Re-running from this layout is the next step.
- **No pictures** are included in this candidate.

Written with AI assistance.
