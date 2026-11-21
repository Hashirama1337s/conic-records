# PRIOR-ART-664-704: are our 664-conic and 704-conic quartic equations already published?

Gate dates: 2026-11-20 to 2026-11-21. Prior-art scout seat, strongest tier. This extends gate/TARGETS-NEXT.md and PRIOR-ART-656-EQ.md; it does not redo them.
Queries: gate/QUERIES-664-704.log. `lab.py searchcheck` prints: "search floor OK: every database with a zero-hit query has a passing positive control".
Sources downloaded this seat: gate/src/g664/ (30 files, pdf + txt).
Newest material covered: arXiv API listing up to 2611.22972 (submitted 2026-11-17); Degtyarev listing newest 2512.08018 (no 2026 paper); Naskrecki listing newest 2610.02500. Zenodo API and OpenAlex queried 2026-11-21.
arXiv ids: every id below was checked through the arXiv API (id_list or search); titles and authors match.
INSPIRE: not used. Earlier gates showed it does not index this literature.
Limits: the arXiv API searches abstracts and metadata only. Full-text coefficient searches went through a general web search engine (6 queries, logged).

## In plain words

- **Barth-Bauer 1994 and Bauer 1995 are now opened, and neither has any equation.** Both authors say so in print. Barth and Bauer: "we only prove their existence and do, unfortunately, not find their explicit equations". Bauer: "The construction does not yield the equations ... It would be interesting to find these equations."
- **Both candidates sit in families that are already published. The members themselves are not.**
  - Candidate 1 (664) lies in the 2-parameter family a·Σx^4 + b·xyzw + c·(Σx^2)^2. This is the family of quartics invariant under the Weyl group W(D4).
    - It is printed by Bonnafe-Sarti as F_{a,b,c}.
    - Cheltsov-Sarikyan print it as the net M4, with its full discriminant.
    - It is the slice of the Heisenberg-invariant family (Eklund, Bouyer) where the three x_i^2x_j^2 coefficients are equal (Eklund B=C=D, Bouyer C=D=E).
    - Its known special members are the Fermat quartic, the Dwork pencil, Mukai's 800-conic quartic Σz^4 - 6Σz_i^2z_j^2, and singular or reducible members.
    - No source prints a member with a coefficient in Q(√-5), or with √5 in the real form.
  - Candidate 2 (704) is exactly a member of Smith's pencil Σx^4 + λ(Σx^2)^2 (also Sarti's (OO)-pencil and Bouyer's [A,0,C,C,C] line). We verified this by hand: substitute w -> s·w with s^2 = 2λ/(1+λ).
    - The member is at 52λ^2 + 36λ + 9 = 0, i.e. λ = (-9 ± 6i)/26.
    - Published members of this pencil: Fermat (λ = 0), Mukai (λ = -3/4), the four nodal members λ = -1, -1/2, -1/3, -1/4, and Bouyer's rational members.
    - Smith shows the pencil's monodromy is a quaternion (Shimura-curve) group, so no published eta-quotient formula gives its CM members.
    - Nobody prints λ = (-9 ± 6i)/26.
- **Verdicts.** Candidate 1 equation: OPEN. Candidate 2 equation: OPEN. In both cases the family is TAKEN, so the new content is the member, its conic count and its lattice, not the family.
- **Nobody is one step away** on present evidence:
  - Degtyarev has the lattices and groups but publishes no equations.
  - The family papers (Bonnafe-Sarti, Cheltsov-Sarikyan, Eklund, Bouyer, Smith, Sarti) never count conics on special members or compute their CM points.

## Step 0: our own files

- `selfcite "664 conics|704 conics|Heisenberg invariant quartic|Barth-Bauer|16 skew conics|352 conics|sqrt(-5)|W(B4) pencil" "equation|explicit|member" "quartic K3" --exclude <project>` found 15 hits in 8 files.
- The paper-citing hits:
  - Our pencils gate row A(1d): Eklund 1010.4058 on the Nieto quintic.
  - A downloaded copy of Bouyer 1511.01781 ((earlier Y56 gate) src/), opened below.
  - Degtyarev 2407.00493 ref. [26] (Naskrecki 800).
  - The K3 gate (Fu-Xiao-Yau, unrelated).
- No file of ours claims a 664 or 704 equation.

Suggested lines for selfcite-aliases.txt:
- `664-conic quartic|Barth-Bauer 2^4C3 quartic|[4,0,60]|W(D4)-invariant quartic|net M4|F_{a,b,c}|a sum x^4 + b xyzw + c (sum x^2)^2`
- `704-conic quartic|W(B4) pencil member|(OO)-invariant pencil|[8,4,28]|sum x^4 + lambda (sum x^2)^2|[A,0,C,C,C]`
- `Heisenberg invariant quartic|(Z/2Z)^4-invariant quartic|H22-invariant quartic|Eklund family|Bouyer family X|Barth-Nieto family`

## Aliases searched

- Candidate 1 family:
  - W(D4) = G(2,2,4)-invariant quartics; Bonnafe-Sarti F_{a,b,c}; Cheltsov-Sarikyan net M4 (G96,227-invariant).
  - Heisenberg / H22 / (Z/2)^4-invariant quartics, slice C=D=E; Hudson-Kummer form.
  - Desmic quartics (a pencil inside the net); 2^4C3 symplectic family (#49).
- Candidate 2 family:
  - W(B4) = G(2,1,4)-invariant quartics; Smith 2^4D6 family XI; Sarti (OO)-invariant pencil f0 + λq^2.
  - Bouyer [A,0,C,C,C]; Barth-Bauer 2^4D6 (#65).
- Both: Barth-Bauer quartics = quartics with 16 skew (disjoint) conics = Kummer of (1,9)-polarised abelian surfaces; CM / singular K3 members.

## Table A: normal forms of the two candidates in each published convention (EXACT, by hand)

| convention (source) | Candidate 1 (664) | Candidate 2 (704) |
|---|---|---|
| lab form | Σx^4 - Σ_{i<j}x_i^2x_j^2 + c·xyzw, c^2 = -45 | E w^4 + E q w^2 + q^2 + t p4 (3-variable q, p4), 9t^2+36t+52 = 0, E = -(36t+108)/25 |
| Smith / Sarti: p4 + λ q^2 (+ μ xyzw) | λ = -1/3, μ = 2c/3, μ^2 = -20 | λ = 1/t = (-9 ± 6i)/26, i.e. 52λ^2+36λ+9 = 0; μ = 0. The map is w -> s w with s^2 = 2λ/(1+λ) = (-18 ± 24i)/25. Check: E = 4λ/(1+λ) and E(1+t) = 4 both hold on 52λ^2+36λ+9 = 0 |
| Bonnafe-Sarti F_{a,b,c} = a p4 + b xyzt + c q^2 | F_{3, 6√-5, -1} | F_{1, 0, λ} |
| Bouyer [A,B,C,D,E] (C multiplies x^2y^2+z^2w^2) | [1, ±3√-5, -1, -1, -1] | [1, 0, μ, μ, μ], μ = (-18 ± 24i)/25 |
| Cheltsov-Sarikyan [a:b:c] = a xyzw + b Σx_i^2x_j^2 + c Σx^4 | [±3√-5 : -1 : 1] | [0 : (-18 ± 24i)/25 : 1] |
| field of coefficients | Q(√-5) (real form Q(√5)) | Q(i) |
| CM field from T (Degtyarev 2108.11181 Table 6) | T = [4,0,60] -> x^2+15y^2, disc -60, Q(√-15). Its genus field contains √5 and √-3, consistent with Q(√-5) | T = [8,4,28] -> 2(2x^2+2xy+7y^2), disc -52, Q(√-13). Its genus field Q(i, √13) contains i, consistent |

Smoothness of candidate 1 was checked against Cheltsov-Sarikyan's discriminant (Lemma 3.9(iv)). At b = -1, c = 1 the factors are 1, -3, a∓6, a±2 and a^2c + 4b^3 - 12b^2c + 16c^3 = a^2. These are nonzero at a^2 = -45, so the member is smooth.

Side fact (EXACT): on the slice b = -1 the Kummer factor a^2 vanishes doubly at a = 0. That point is Sarti's 16-nodal W(B4) member λ = -1/3. So the 664 member lies on the line of the net tangent to the Kummer locus at that W(B4)-Kummer point. Whether this matters: UNTESTED.

Not in the Dwork pencil: Dwork members have symplectic group ⊇ 4^2A4 of order 192 (Smith). The 664 surface has Sym of order 48 and the 704 surface has Sym of order 96 (2108.11181 Table 6). So the Dwork CM papers 2304.00027 and 2609.36045 cannot contain either surface (ARGUED from the group orders). Candidate 1 also has b ≠ 0, and candidate 2 has μ ≠ 0.

## Table B: verdicts

| item | verdict | best source | label | quoted sentence | locator |
|---|---|---|---|---|---|
| Barth-Bauer 1994 gives equations of BB quartics | **NO EQUATIONS** | W. Barth, Th. Bauer, "Smooth quartic surfaces with 352 conics", Manuscripta Math. 85 (1994) 409-417, DOI 10.1007/BF02568207 (journal page paywalled; opened the authors' copy on Bauer's university page) | OPENED | "In this way we only prove their existence and do, unfortunately, not find their explicit equations." Open question listed: "What are the equations of the quartics in our (three-dimensional) family of surfaces, which contain 352 smooth conics?" | §0 Introduction, p.1 |
| Bauer 1995 gives equations | **NO EQUATIONS** | Th. Bauer, "Quartic surfaces with 16 skew conics", J. reine angew. Math. 464 (1995) 207-217, DOI 10.1515/crll.1995.464.207 (author's copy, Marburg page) | OPENED | "The construction does not yield the equations of the quartic surfaces in our two-dimensional family. It would be interesting to find these equations." | §0, p.2 |
| Candidate 1: the family Σx^4 + b·Σx_i^2x_j^2 + c·xyzw (W(D4) net) | **TAKEN (family only)** | Bonnafe-Sarti arXiv 2005.04460; Cheltsov-Sarikyan arXiv 2202.09319 | OPENED | BS: "F_{a,b,c} = a(Σx^4) + bxyzt + c((Σx^2))^2". CS (text layer garbles (3.8); formula reassembled from its basis line "x0x1x2x3, x0^2x1^2 + ... + x2^2x3^2, x0^4 + ... + x3^4"): "let us define the net M4 consisting of quartic surfaces in P3 given by a x0x1x2x3 + b(x0^2x1^2 + ... + x2^2x3^2) + c(x0^4+...+x3^4) = 0 ... every surface in the net M4 is G-invariant and G96,227-invariant", with the singular locus "c(b+2c)(b-2c)(a+2b-4c)(a-2b+4c)(a-6b-4c)(a+6b+4c)(a^2c+4b^3-12b^2c+16c^3) = 0". Only singular or reducible members are named. | BS §5.4, p.16 (txt l.845); CS (3.8) and Lemma 3.9, p.19-20 |
| Candidate 1: same family as the Heisenberg slice | **TAKEN (family only)** | Eklund arXiv 1010.4058; Bouyer arXiv 1511.01781 | OPENED | Eklund: "F = Ag0 + Bg1 + Cg2 + Dg3 + Eg4" with "g4 = 4xyzw"; special smooth members named: "the Fermat quartic ... and the pencil x^4 + y^4 + z^4 + w^4 + λxyzw = 0". Bouyer's named Picard-20 members: "The surface [√−3, 12(√−3 −1), 6, 6, −6] contains exactly 32 lines" and F4. | Eklund §2.3 p.4 and p.1; Bouyer Thm 4.9 and §3 p.4 |
| Candidate 1: the 664 member itself (any projectively equivalent equation, coefficient in Q(√-5)) | **OPEN** | searched: BB94, Bauer95, Eklund, Bouyer (paper, monodromy paper, thesis), Bonnafe-Sarti I-II, Cheltsov-Sarikyan, Cheltsov-Shramov, Avila-Ortiz-Troncoso, Manivel (desmic), Dolgachev-Kondo (desmic), Naskrecki, Degtyarev 2108.11181/2210.06966/2407.00493, Rams-Schutt 2504.00778; Zenodo; arXiv abstracts; web full text for "3√5 xyzw", "3√-5 xyzw", "2√-5 xyzw" | - | no hit. Nearest member with √5 in its field: Mukai's 800 quartic (b = -6, c = 0), whose conics live over Q(i, √2, √5) (Naskrecki). That is a different point of the net. | QUERIES-664-704.log |
| Candidate 2: the family Σx^4 + λ(Σx^2)^2 | **TAKEN (family only; earlier gate already TAKEN)** | Smith arXiv 0705.3658; Sarti arXiv math/0303364 | OPENED | Sarti: "We take the generators q2 and f0 := x0^4+x1^4+x2^4+x3^4" ... nodal members at λ = -1, -1/2, -1/3 ("16, Kummer surface"), -1/4. Smith family XI: projective monodromy generated by quaternion elements "in Q[3,-2,1 3]" (Shimura-curve type). Neither lists CM members. | Sarti §4.1 p.17-18; Smith Differential Equation XI, p.92 |
| Candidate 2: Bouyer's rational members of [A,0,C,C,C] | PARTIAL (other members) | Bouyer, PhD thesis, Warwick 2016 (WRAP 80893) | OPENED | "Note for example the subfamily [A, 0, C, C, C] of X is fixed by σ1, σ2 and σ3." Prop. 3.3.3 gives rational members with 160 Q-planes. All have A, C ∈ Q, while ours has C/A = (-18±24i)/25 ∉ R. | thesis §3.3, printed p.36-37 |
| Candidate 2: the 704 member itself (λ = (-9±6i)/26 or any equivalent form) | **OPEN** | searched as for candidate 1, plus Smith, Sarti 2003/2004/2005, Barth-Sarti, web for the pencil with "Picard number 20 / transcendental lattice / Q(√-13)" | - | no hit | QUERIES-664-704.log |
| "664 conics" / "704 conics" anywhere | 0 | Zenodo (control "Fermat quartic" = 11); web (10 results, none relevant); earlier arXiv all: count queries = 0 (control "800 conics" = 2, TARGETS-NEXT) | - | - | QUERIES-664-704.log; QUERIES-TARGETS.log |
| CM-point papers of Dwork / mirror-quartic pencils (2304.00027, 2609.36045) | **NOT COVERING** | Ahmed-Ruehle 2304.00027 (OPENED by earlier gate); Yu Fu 2609.36045 (ABSTRACT) | - | Dwork pencil only (b = 0, single xyzw term). See the group-order argument above. | TARGETS-NEXT.md |

## Citation trail (OpenAlex, 2026-11-21)

- Barth-Bauer 1994 (W1990758390): 14 citers. Bauer 1995 (W4241886034): 15 citers. Eklund (W1507421748): 18 citers. Bouyer Acta Arith. (W2148682979): 7 citers. Bouyer Glasgow (W1901655572): 3 citers.
- I read every title.
- Opened in full, because their titles touch invariant quartic families:
  - Cheltsov-Sarikyan 2202.09319 and Cheltsov-Shramov 1712.08258 (Heisenberg invariants t0..t5, p.11).
  - Avila-Ortiz-Troncoso 2211.13273: primitive groups only. Our groups are monomial in these coordinates, hence imprimitive.
  - Manivel 2508.16156 (desmic pencil 8A·x1x2x3x4 - B(2Σx_i^2x_j^2 - Σx^4), p.8). Its quadratic part is not proportional to ours, and desmic members are 12-nodal.
  - Dolgachev-Kondo 2505.01033 (desmic).
  - Rams-Schutt 2504.00778 (bounds only, no quartic equations).
  - Bouyer thesis.
  - Garbagnati-Sarti 1305.3514 (Picard 16-17 lattices, no special members).
- None prints either member.

## Paywalled / title-level sources

- Barth-Bauer 1994: DOI 10.1007/BF02568207 (Springer: "Access Type: no-access"). Opened through the authors' own copy at mathematik.uni-marburg.de/~tbauer/ (marked "Appeared in: Manuscripta math. 85, 409-417 (1994)").
- Bauer 1995: DOI 10.1515/crll.1995.464.207. Same author page.
- If the owner wants the journal versions for the record, those two DOIs are the citation.
- Sarti, "Transcendental lattices of some K3-surfaces", arXiv math/0505441: the PDF endpoint returned HTTP 500 twice. Read at ABSTRACT level: it concerns the octic-quotient families of math/0409419, not quartic pencils.

## Most dangerous neighbours

- **Degtyarev (with Rams)**: owns the lattices and groups (2108.11181 Table 6) and is active in 2025 (Miyaoka sharpness, large line configurations). He has never published equations for BB strata.
- **Bonnafe (with Sarti)**: computes special members of reflection-group families in Magma. BS I promises sequels ([BS-II] appeared, on G29-G31; no [BS-III] on arXiv). A W(D4) / W(B4) sequel could name CM members.
- **Naskrecki**: the explicit-conics specialist (800). His listing up to 2610.02500 has nothing on BB quartics.
- **Not-a-race check**: nobody shows a sign of being one step from either member. No preprint, talk title or Zenodo record was found.

## Methods worth borrowing

- **Eklund's 320 conics are explicit for every Heisenberg-invariant quartic.** Bouyer prints the conic planes with coefficients √(q±C), √(±p±j) (1511.01781 appendix, txt l.1658-1806).
  - Both candidates are Heisenberg-invariant, so 320 of their conics have closed forms.
  - This gives an independent, exact cross-check on part of our 664 and 704 counts.
- **Cheltsov-Sarikyan Lemma 3.9 discriminant**: a one-line exact smoothness certificate for any member of the net. Used above.
- **Bouyer's field-of-definition formulas** (thesis §3.1-3.3): they predict the field of each Heisenberg orbit of 32 conics. They are a check on the Galois structure of our conic sets.
- **Smith's family XI monodromy (quaternion group)**: the 704 point is a CM point on a Shimura curve. Any closed-form certificate for λ must go through that curve, not through an eta quotient.

## The gap that is genuinely open

No source we could reach prints the 664-conic member of the W(D4) net (coefficient 3√-5) or the 704-conic member of the W(B4) pencil (52λ^2+36λ+9 = 0). Both families and several of their other members are published.

## Loose ends

- Mukai 1988 and Barth-Nieto 1994 were not opened. They concern the 800 member and the line locus, not these members.
- The arXiv full text was not searchable directly. Coefficient patterns went through a general web engine only, so a printed form like "√-20" in a PDF body could be missed. Searches for c^2 = -45 and μ^2 = -20 were done as text patterns only.
- Google Scholar was not queried.
- Yu Fu 2609.36045 remains ABSTRACT-level.
- That the 664 member lies on the line tangent to the Kummer locus at Sarti's λ = -1/3 point is EXACT. Whether it has meaning (for example, as a degeneration route) is UNTESTED.

## Ledger lines

GATE 664-conic quartic equation (W(D4) net member, c^2=-45) OPEN source=arXiv:2005.04460 (family) + Barth-Bauer DOI 10.1007/BF02568207 (no equations)
GATE 704-conic quartic equation (W(B4) pencil member, 52λ^2+36λ+9=0) OPEN source=arXiv:0705.3658 (family) + Bauer DOI 10.1515/crll.1995.464.207 (no equations)
GATE W(D4)-invariant quartic net a p4 + b xyzw + c q^2 (family of the 664 member) TAKEN source=arXiv:2005.04460 (+arXiv:2202.09319)

```
python "memcap.py" 1 python "lab.py" gate <project> "Explicit equation of the 664-conic quartic: W(D4) net member sum x^4 - sum x_i^2x_j^2 + c xyzw, c^2=-45" OPEN --file gate/PRIOR-ART-664-704.md --source "arXiv:2005.04460" --queries gate/QUERIES-664-704.log
python "memcap.py" 1 python "lab.py" gate <project> "Explicit equation of the 704-conic quartic: W(B4) pencil member sum x^4 + lambda (sum x^2)^2, 52 lambda^2+36 lambda+9=0" OPEN --file gate/PRIOR-ART-664-704.md --source "arXiv:0705.3658" --queries gate/QUERIES-664-704.log
python "memcap.py" 1 python "lab.py" gate <project> "W(D4)-invariant quartic net a sum x^4 + b xyzw + c (sum x^2)^2 (family of the 664 member)" TAKEN --file gate/PRIOR-ART-664-704.md --source "arXiv:2005.04460" --queries gate/QUERIES-664-704.log
```

Written with AI assistance.
