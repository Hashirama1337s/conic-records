# PRIOR-ART RE-GATE: the 656-real-conic quartic as a member of the octahedral family (strongest tier)

Gate date: 2026-11-20. Prior-art scout seat. This extends (earlier pencils gate) PRIOR-ART-PENCILS.md (object B was OPEN at the search floor there) and does not redo it. New here: searches aimed at the mechanism we now hold. Our candidate is a member of the 2-parameter family F(e,t) = w^4 + e q w^2 + q^2 + t p4, where q = x^2+y^2+z^2 and p4 = x^4+y^4+z^4. The symmetry is C2 x S4 (signed permutations of x, y, z; w -> -w is included projectively), with symplectic part S4. The member sits at a point over the cubic field of discriminant -244.
Queries: gate/QUERIES.log (86 lines). `lab.py searchcheck` prints: "search floor OK: every database with a zero-hit query has a passing positive control".
Sources: gate/src/ holds pdf+txt of 0705.3658, 0804.1558, 0902.3761, 1012.2682, 1103.1892, 1410.1300, 1910.05952, 1910.05955, 2005.04460, 2108.11181, 2108.13402, 2602.11742 and math/0301329. Sources from the earlier gates are read in place in (earlier Y56 gate) src/ and (earlier pencils gate) src/.
Exact check script: gate/tools/famcheck.py (sympy, ran under memcap).
Newest material covered:
- arXiv API: newest hit 2611.22972 (2026-11-17).
- Pichon-Pharabod-Telen 2509.06785: v2, updated 2026-11-06.
- Zenodo API, OpenAlex and Semantic Scholar: queried 2026-11-20.
- Degtyarev's homepage: Last-Modified 2025-12-07 (unchanged).
arXiv ids: every id below was checked against the arXiv API id_list, and title and authors match.
INSPIRE is not part of the floor. The earlier gate showed it has no record of this literature (api/arxiv 2407.00493 returns 404).

## In plain words

- **The equation is still unpublished.** We found no equation for Degtyarev's real quartic with 656 real conics (configuration (5.14), T = [2,0,122]) in any paper, preprint, Zenodo record, citer or talk. This holds now that we know what the equation looks like.
- **The family is classical.** Quartics invariant under the octahedral group together with w -> -w are Goursat's octahedral surfaces (Goursat 1887). MathWorld writes them as x^4+y^4+z^4 + a(x^2+y^2+z^2)^2 + b(x^2+y^2+z^2) + c = 0, which is our F(e,t) in affine form. Combe (2014) classified their real topology.
- **Nobody has counted conics or lines on this family.** We found no paper that does, and none that locates its Noether-Lefschetz curves.
- **The 800-conic point is already known.** The point (E,t) = (-12, -4/3) with 800 conics is the Mukai quartic in the form Bonnafe-Sarti and Naskrecki already publish: sum x_i^4 - 6 sum x_i^2 x_j^2 = 0. That polynomial is visibly invariant under all signed permutations of the four coordinates, so it lies in our family. We checked the map exactly: f800/(-3) = -(1/3)w^4 + 2qw^2 + q^2 - (4/3)p4, and rescaling w with mu^4 = -3 gives E = e^2 = -12 and t = -4/3.
- **A 1-parameter slice of the family is also published.** The pencil sum x_i^4 + lambda (sum x_i^2)^2 = 0 is in Smith's 2006 thesis, with its symmetry-jump points. Inside our family it is the curve E(1+t) = 4.
- **Nothing ties the field to a K3 surface.** No source connects the cubic field of discriminant -244 (LMFDB 3.1.244.1, x^3 + x - 6) to a K3 surface or a quartic. The field fits Schutt's obstruction (ARGUED, below).

## Step 0: our own files

- `selfcite "Goursat surface|octahedral quartic|x^4+y^4+z^4|symplectic S4|octahedral group" "conics|lines|K3|invariant quartic" "quartic surface" --exclude <project>`: 320 hits in 40 files. All are generic (Veniani, DIS and Degtyarev reference lines, our earlier Y56 gates). None treats an octahedral family.
- `selfcite "Goursat|Mukai quartic|Mukai polynomial|12xyzw|12x0x1x2x3" "octahedral|S4|symmetric|conics|800" "quartic" --exclude <project>`: 314 hits in 53 files.
  - Paper-citing hits: our pencils gate row B(4) (Degtyarev 2102.08163 and Naskrecki 2108.13402, already in the table there) and (earlier Y56 gate) src/2102.08163.txt:30 ("must be given by the Mukai polynomial").
  - (earlier Y56 gate) PRIOR-ART-Y56.md:48 mentions a "Goursat quartic" GitHub repository, which is unrelated.
  - No file of ours places the Mukai quartic in an octahedral family.

Suggested lines for selfcite-aliases.txt:
- `Goursat surface|octahedral quartic|octahedral invariant quartic|W(B3)-invariant quartic|C2 x S4 quartic family|q^2 + t p4`
- `Mukai quartic|800-conic quartic|X_Mu|sum x^4 - 6 sum x^2y^2|x^4+y^4+z^4+w^4+12xyzw`
- `Smith pencil|W(B4)-invariant pencil|sum x^4 + lambda (sum x^2)^2|2^4 D6 family`
- `Barth-Bauer quartic|Kummer quartic with 16 conics|16 disjoint conics`

## Aliases searched (beyond the earlier gate)

- Family: Goursat surface / Goursat quartic; octahedral (invariant) quartic; real ternary octahedral quartic; W(B3) x W(A1) = G(2,1,3) x Z2 invariants; signed-permutation invariant quartic; quartic in squares Q(x^2, y^2, z^2, w^2); K3 with symplectic S4; C2 x S4 symmetric K3; Mukai-group subgroups (Smith's tables).
- 800 point: Mukai quartic; Mukai polynomial; X_Mu; G29-invariant quartic; Barth-Bauer quartic; M20 quartic.
- Field: cubic field of discriminant -244; x^3 + x - 6; Q(sqrt(-61)); ring class field H(-244); fields of definition of singular K3 surfaces.

## Table

| item | verdict | best source | label | quoted sentence | locator |
|---|---|---|---|---|---|
| (1a) Published or posted equation of the real quartic with 656 real conics, (5.14), T = [2,0,122] | **OPEN** (search floor; unchanged and extended) | Degtyarev arXiv 2407.00493v2 | OPENED (earlier gate; context re-read) | "(5.14) \|C\| = 656 : ... [2, 0, 122] (1, 0) [10, 4, 26] (0, 1) ... This is the largest known configuration of real conics on a real quartic, see §7.2." No symmetry group or equation is given for (5.14) (grep: no "octahedral", "S4" or "symmetric group" anywhere in the text). | 2407.00493.txt l.1563-1569; §7.2 l.1815-1827 |
| (1b) Any quartic with 656 conics (complex) with an equation | TAKEN, but for a different surface (Q56) | Veniani 1708.01219 sec 5.2; Degtyarev 2407.00493 Remark 7.4 | OPENED (earlier gate) | Q56 has 208 + 448 = 656 conics and T = [4,2,16], det 60. (5.14) has det 244, so they are different surfaces (normalisation check in the pencils gate). | earlier gate, Normalisation section |
| (1c) Zenodo / arXiv / web for "656 conics" | none beyond 2407.00493 | Zenodo `"656 conics"` 0 (control `title:"Line arrangements on smooth quartics"` 1); arXiv `abs:"656 conics"` 0, `abs:656 AND abs:quartic` 1 (= 2407.00493); web: only 2407.00493 | - | - | QUERIES.log |
| (2a) The family itself: quartics invariant under the octahedral group times w -> -w (Goursat's octahedral surfaces) | **TAKEN** (as a family) | Goursat, "Étude des surfaces qui admettent tous les plans de symétrie d'un polyèdre régulier", Ann. Sci. ENS (3) 4 (1887) 159-200, DOI 10.24033/asens.295; MathWorld "Goursat's Surface" | Goursat: record only (Numdam item page OPENED, PDF not read). MathWorld: OPENED | MathWorld: "Goursat's surface is a parametrized quartic surface defined by x^4+y^4+z^4+a(x^2+y^2+z^2)^2+b(x^2+y^2+z^2)+c=0". Homogenised, this is p4 + a q^2 + b q w^2 + c w^4, i.e. F(e,t) up to scaling. | numdam.org/item/ASENS_1887_3_4__159_0; mathworld.wolfram.com/GoursatsSurface.html, eq. (1) |
| (2b) Real geometry of the same family | PARTIAL (topology and singular members only; no lines, conics or lattices) | Combe arXiv 1410.1300 | OPENED | "(2) f(x, y, z) = A(x2y2 + y2z2 + x2z2) + B(x2 + y2 + z2)2 + C(x2 + y2 + z2) + D = 0." "To classify such surfaces we use the same type of group theory approach that was initiated by E. Goursat [4]". The text has no line, conic, K3 or Picard content (grep). | 1410.1300 sec 1, eq. (2), p.1-2 |
| (2b') Combe's only citer, "On Coxeter algebraic varieties: the geometry of CB_n quartics" (Math. Semesterber. 2018, DOI 10.1007/s00591-018-0221-z) | UNVERIFIED content (paywalled; the OpenAlex record has no abstract) | Combe 2018 | SNIPPET (title only) | - | OpenAlex W-citer of W4299447677 |
| (2c) Conic or line counts, or Noether-Lefschetz curves, along the octahedral (Goursat) family | **OPEN** (search floor) | nearest: Pichon-Pharabod-Telen 2509.06785v2, Table 4 | OPENED | Their S4 is a different action: "S4 and A4 4 17 ... 344" (dim L = 4, generic rank 17, 344 conics). Ours is 2-dimensional with generic rank 18. They state: "For all families, the generic surface contains no lines". Only generic members are tabulated. | 2509.06785 Table 4, Thm 22, p.26-27 |
| (2d) The 1-parameter W(B4) slice sum x_i^4 + lambda (sum x_i^2)^2 (inside our family on the curve E(1+t) = 4, exact) with its symmetry-jump points | **TAKEN** (family and jump points; no conic counts) | J. P. Smith, PhD thesis (Warwick 2006), arXiv 0705.3658 | OPENED (page 32 rendered as an image to read the fractions) | "X_lambda : x0^4 + x1^4 + x2^4 + x3^4 + lambda(x0^2 + x1^2 + x2^2 + x3^2)^2 = 0 in P3. This family is singular at lambda = infinity and lambda = -1, -1/2, -1/3, -1/4 and the symplectic automorphism group jumps to F384 at lambda = 0 and to M20 at lambda = 3/4." | 0705.3658 §1.3, subgroup 2^4 D6 of F384, PDF p.32 |
| (2e) Sign discrepancy in (2d) | NOTE | our exact check | EXACT (famcheck.py) | Bonnafe-Sarti's Mukai form 4 p4 - 3 q4^2 is lambda = **-3/4** in Smith's normalisation. Smith prints M20 at lambda = **+3/4**, which maps to (E,t) = (12/7, 4/3) in our family. Either a misprint, or a second M20-symmetric member. UNTESTED. One run of our conic counter at (12/7, 4/3) would settle it (800 or not). | - |
| (3a) K3 surfaces with symplectic S4: moduli dimension | TAKEN (lattice level) | Hashimoto arXiv 1012.2682, Table 10.2 | OPENED | Row "34 24 12 S4 576 4+3, 3+2 17": the coinvariant lattice has rank 17. So rho >= 18 and the moduli are 2-dimensional (ARGUED from the row). This matches our 2-parameter family. Row 51 (C2 x S4, order 48) has rank 18. | 1012.2682 Table 10.2 rows 34, 51 (txt l.2082, 2126) |
| (3b) Explicit quartic families with symplectic S4 (or C2 x S4) in other representations | PARTIAL (other S4 actions; no conic counts) | Smith 0705.3658 (family XII, "C2 x S4 ⊂ T192"); Karp-Lewis-Moore-Skjorshammer-Whitcher 1103.1892 (toric S4 families, rank 19) | OPENED | Smith: "The C2 x S4 invariant polynomials of degree 4 are p = x0^4+x1^4+x2^4+x3^4 - 2i sqrt3 (x0^2x1^2 + x2^2x3^2), q = (x0x2 + x1x3 - ix1x2 - ix0x3)^2". This is a 1-parameter T192 family, not ours. Karp et al.: "show that S4 acts symplectically on members of these families, and show that a general K3 surface in each family has Picard rank 19." | 0705.3658 p.22-23 (txt l.1224-1240); 1103.1892 abstract |
| (3c) Maximal-group K3s with quartic models (context) | not overlapping | Brandhorst-Hashimoto 1910.05952; Nukui 2602.11742 (S4 x S4, Schur's quartic); Frantzen 0902.3761 (thesis) | OPENED (grep-level) | B-H: "A projective model of 81a is given in [25]: x4 + y4 + z4 + w4 + 12xyzw = 0 in P3." None treats the C2 x S4 (symplectic S4) quartic family or conics. | 1910.05952 §6.8-6.9 (txt l.1100-1111) |
| (4) Cubic field of discriminant -244 / x^3 + x - 6 together with K3 or quartic | **OPEN** (search floor) | LMFDB 3.1.244.1 | OPENED | "Defining polynomial: x^3 + x - 6; Discriminant: -244 = -2^2 · 61; Class number: 1; Galois closure 6.0.14526784.1". No K3 or quartic is linked. Zenodo `"x^3+x-6"` 0; web search: no hit tying it to K3. | lmfdb.org/NumberField/3.1.244.1 |
| (4') Field-of-definition consistency | ARGUED (not prior art; a check) | Schutt arXiv 0804.1558, Theorem 2 | OPENED | "Let L be a number field and X a K3 surface of Picard rank 20 over L. Denote the discriminant of X by d < 0. Then L(sqrt d) contains the ring class field H(d)." | 0804.1558 Thm 2, p.2 |
| (5) The 800-conic quartic is the member (E,t) = (-12, -4/3) of our family | **TAKEN** (the form is published; the placement in the family follows by arithmetic) | Bonnafe-Sarti arXiv 1910.05955 §4 (also Naskrecki 2108.13402 §1) | OPENED | B-S: "there exists a unique (up to scalar) homogeneous invariant f of GMu of degree 4: it is given by f = Σ(x^4) - 6Σ(x^2y^2). ... endowed with a faithful symplectic action of M20 and an extra non-symplectic automorphism of order 2, i.e. one can fix it as [x : y : z : t] -> [x : y : z : -t]". Prop. 4.2: Mukai's Σx^4 + 12xyzt is projectively equivalent to it (we re-ran their change of coordinates: EXACT). Naskrecki: "Its equation in the projective space P3 is X : Σ zi^4 - 6 Σ_{i<j} zi^2zj^2 = 0." | 1910.05955 §4 p.8-9 (txt l.459-540); 2108.13402 §1 p.1 |
| (5') The 800 surface is the unique Barth-Bauer maximiser; real Barth-Bauer quartics have at most 560 real conics | TAKEN (context and a sanity bound) | Degtyarev arXiv 2108.11181 | OPENED | "Theorem 1.3 ... The maximal number of conics on a Barth-Bauer quartic is 800. Up to projective transformation, there is a unique Barth-Bauer quartic with 800 conics: it is the Mukai quartic". "Theorem 1.6 ... The maximal number of real conics on a real Barth-Bauer quartic is 560. There is a unique 1-parameter equiconical family ... of real Barth-Bauer quartics with 560 real conics". | 2108.11181 §1.2 Thm 1.3, Thm 1.6, p.3 |

## Normalisations (done before writing "no overlap")

- **Goursat vs ours.** In affine w = 1, F(e,t) = q^2 + t p4 + e q + 1. MathWorld's form is p4 + a q^2 + b q + c. They match with a = 1/t, b = e/t, c = 1/t (t != 0). Same family.
- **Smith's pencil inside ours (EXACT by hand, consistent with famcheck.py).**
  - Write p4 + w^4 + lambda (q + w^2)^2 and divide by lambda. Rescale w with mu^4 = lambda/(1+lambda).
  - This gives t = 1/lambda and E = e^2 = 4 lambda/(1+lambda), so E(1+t) = 4.
  - lambda = -3/4 gives (E,t) = (-12, -4/3), the 800 point (famcheck.py: True, True, E = -12).
  - lambda = 0 is the Fermat quartic (t -> infinity, the boundary of the chart).
- **The 656 candidate's field vs Schutt.**
  - d = -244 (T = [2,0,122], det 244). The class number of Q(sqrt(-61)) is 6, so [H(-244):Q] = 12.
  - The cubic field L (disc -244, LMFDB) gives [L(sqrt(-61)):Q] = 6 < 12.
  - By Schutt's Thm 2, the surface can be defined over L, but its Neron-Severi group (all 656 conics) cannot all be defined over L. A field of definition L' of the conics needs L'(sqrt(-61)) ⊇ H(-244) (ARGUED).
  - This is a usable check on any exact conic computation: if every conic came out defined over the cubic field, something is wrong.
- **Barth-Bauer vs our family.**
  - Theorem 1.6 of 2108.11181 caps real Barth-Bauer quartics at 560 real conics, so the 656-real-conic member is not Barth-Bauer.
  - If a generic member of F(e,t) carried 16 disjoint conics, they would specialise to the 656 member (smooth, all 656 conics irreducible). So the generic member should not be Barth-Bauer (ARGUED; it assumes the 16 conics stay smooth and disjoint in the limit).
  - The Mukai point (800) is Barth-Bauer, but only as a special member.
- **UNTESTED curiosity.**
  - The lead's verify seat found 560 conics at the node of NL_B, (28/19, -10/9).
  - Degtyarev's Theorem 1.6 has a unique 1-parameter equiconical family of real Barth-Bauer quartics with exactly 560 real conics, whose closure contains one singular quartic.
  - Whether our 560 point lies on that family has not been tested.

## Citation trails

- 2407.00493:
  - OpenAlex citers = 2 (2512.06145, 2512.08018; both grepped in the earlier gate, no 656).
  - Semantic Scholar: 0 (control: 2108.13402 has 2 citers there).
  - Degtyarev's arXiv listing: newest K3 paper is 2512.08018v3; nothing from 2026 in K3. Homepage unchanged (Last-Modified 2025-12-07).
- 2108.13402 (Naskrecki), OpenAlex citers = 4: Conics on Kummer quartics; Bonnafe-Sarti II 2112.12400; 2407.00493; Muller "Invariant Grassmannians..." (2024). None places the Mukai quartic in an octahedral 2-parameter family or mentions 656.
- 1910.05955 (Bonnafe-Sarti), OpenAlex citers = 21. Titles read; open titles opened or grepped where they touch quartic models: 1910.05952, 2108.11181, 2005.04460. None concerns the C2 x S4 family or conic counts on it. Others (EPW sextics, hyper-Kahler fourfolds, Conway compactifications, supersingular K3, E6 Weyl group) are off-mechanism by title.
- 1410.1300 (Combe), OpenAlex citers = 1 (Combe 2018, title only, paywalled).
- 2108.11181 (Degtyarev, Kummer quartics), OpenAlex citers = 5, all known (800 conics, Barth-Bauer octics, Naskrecki, 2407.00493, 2512.06145).
- Smith 0705.3658 was found through Karp et al.'s sentence: "The dissertation [Smith 07] uses symplectic group actions to produce pencils of K3 surfaces with Picard rank 19 in projective space P3" (1103.1892 §1).

## Zenodo (mandatory)

- Controls: `title:"Line arrangements on smooth quartics"` = 1 (Naskrecki 14360457).
- Zero-hit queries: `"656 conics"` 0, `"Goursat surface"` 0, `"Mukai quartic"` 0, `"800 conics"` 0, `"x^3+x-6"` 0, `"Barth-Bauer"` 0.
- Broad queries: `Goursat quartic`, `octahedral quartic surface`, `"octahedral" "K3"`, `"symplectic" "S4" "K3"`, `"real conics" quartic`, `cubic field discriminant -244` and `octahedral invariant quartic K3` return only unrelated items in their top 5-8.
- The one mathematical hit, 21072971 "Invariant Polynomials and Mukai Models v1" (Swinarski 2026), was OPENED. It is support material for arXiv 2606.14339, which is about GIT models of moduli of curves and K3 surfaces, not finite-group quartics.

## Most dangerous neighbours

- **Degtyarev.** He holds (5.14) and the code that regenerates it. Computing Sym_h(5.14) from the Fano graph, then a Roulleau-style identification, would land on the same octahedral ansatz. No sign of this in his listing (newest 2512.x) or on his homepage.
- **Pichon-Pharabod and Telen** (2509.06785v2, updated 2026-11-06). Their certified tables of G-invariant quartic families already include an S4 row (another representation). Adding W(B3) x Z2 = the Goursat family would give its generic rank and generic conic count. Their discriminant work would expose the special members. This is the most likely group to tabulate the family, but they do not chase special members.
- **Bonnafe and Sarti.** They work with reflection-group-invariant quartics (W(B4), G29). Our family is the W(B3) x W(A1)-invariant quartics.
- **Not one step away** from the 656 equation on present evidence. The not-a-race rule does not apply. Credit owed: Degtyarev (existence, (5.14)), Goursat (family), Bonnafe-Sarti and Naskrecki (the 800 member's form), Smith (the W(B4) slice).

## Methods worth borrowing

- **Schutt 0804.1558 Thm 2** as a field check on the conics (see Normalisations).
- **Smith's pencil as a calibration line inside F(e,t).** Use the curve E(1+t) = 4 with known jump points: Fermat at lambda = 0, M20 at lambda = -3/4 (and Smith's printed +3/4, to be settled).
- **Bonnafe-Sarti (4.3).** They prove the full projective stabiliser equals the reflection group by a normaliser and reflection-subgroup argument. The same pattern could prove that Aut of our 656 member is exactly C2 x S4 (or find more).
- **Pichon-Pharabod-Telen §7.2.2.** Certify the generic Picard rank (18) of the Goursat family: lower bound from the group, upper bound from a non-vanishing period determinant.

## The gap that is genuinely open

Nobody has published the equation of Degtyarev's 656-real-conic quartic (5.14). Nobody has identified it as a member of Goursat's classical octahedral family. Nobody has counted conics on that family or located the Noether-Lefschetz curves where its conic count jumps. The family and its 800-conic (Mukai) member are classical or published.

## Loose ends

- Goursat 1887 was not read (Numdam PDF available; the family identification rests on MathWorld's equation and Combe's citation). Opening the PDF would show whether Goursat said anything about lines on these surfaces (unlikely, but not checked).
- Combe 2018 (Math. Semesterber., DOI 10.1007/s00591-018-0221-z) is paywalled; content unverified.
- Smith's "M20 at lambda = 3/4" vs our exact -3/4: unresolved. One conic count at (E,t) = (12/7, 4/3) settles it.
- The Barth-Bauer argument (generic member not Barth-Bauer) is ARGUED, not computed. The 560 link to Degtyarev Thm 1.6 is UNTESTED.
- Semantic Scholar shows 0 citers of 2407.00493 (index lag); OpenAlex stands in.
- Google Scholar was not queried (no programmatic access).

## Ledger lines

GATE B 656-conic equation (octahedral/Goursat member over cubic field disc -244) OPEN source=arXiv:2407.00493
GATE F(e,t) octahedral x (w->-w) quartic family TAKEN source=doi:10.24033/asens.295 (+arXiv:1410.1300)
GATE conic counts / NL curves along the Goursat family OPEN source=arXiv:2509.06785 (nearest, different S4)
GATE 800-conic Mukai quartic as member (E,t)=(-12,-4/3) TAKEN source=arXiv:1910.05955
GATE W(B4) slice sum x^4 + lambda (sum x^2)^2 with jump points TAKEN source=arXiv:0705.3658
GATE cubic field disc -244 (x^3+x-6) with a quartic K3 model OPEN source=LMFDB 3.1.244.1

```
python "memcap.py" 1 python "lab.py" gate <project> "Explicit equation of Degtyarev's 656-real-conic quartic (5.14) as a member of the octahedral (Goursat) family over the cubic field of discriminant -244" OPEN --file gate/PRIOR-ART-656-EQ.md --source "arXiv:2407.00493" --queries gate/QUERIES.log
python "memcap.py" 1 python "lab.py" gate <project> "The 2-parameter family of quartics invariant under the octahedral group times w->-w (Goursat surfaces)" TAKEN --file gate/PRIOR-ART-656-EQ.md --source "doi:10.24033/asens.295" --queries gate/QUERIES.log
python "memcap.py" 1 python "lab.py" gate <project> "Conic counts and Noether-Lefschetz curves along the octahedral (Goursat) quartic family" OPEN --file gate/PRIOR-ART-656-EQ.md --source "arXiv:2509.06785" --queries gate/QUERIES.log
python "memcap.py" 1 python "lab.py" gate <project> "The 800-conic Mukai quartic is the member (E,t)=(-12,-4/3) of the octahedral family" TAKEN --file gate/PRIOR-ART-656-EQ.md --source "arXiv:1910.05955" --queries gate/QUERIES.log
python "memcap.py" 1 python "lab.py" gate <project> "W(B4) pencil sum x^4 + lambda (sum x^2)^2 inside the family, with symmetry-jump points" TAKEN --file gate/PRIOR-ART-656-EQ.md --source "arXiv:0705.3658" --queries gate/QUERIES.log
python "memcap.py" 1 python "lab.py" gate <project> "Cubic field of discriminant -244 (x^3+x-6) as field of a quartic K3 model" OPEN --file gate/PRIOR-ART-656-EQ.md --source "LMFDB 3.1.244.1" --queries gate/QUERIES.log
```

Written with AI assistance.
