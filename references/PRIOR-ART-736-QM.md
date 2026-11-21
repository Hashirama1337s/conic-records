# PRIOR-ART-736-QM: the 736-conic Dwork member, and the quaternion-6 vein of the octahedral family

Gate date: 2026-11-21. Prior-art scout seat, strongest tier. This extends TARGETS-NEXT.md (736 PARTIAL), PRIOR-ART-664-704.md and PRIOR-ART-656-EQ.md and does not redo them.
Queries: gate/QUERIES-736QM.log. Databases with a passing control: Zenodo API, OpenAlex (search, title_and_abstract filter, cites filter). arXiv API: see "Search floor" below.
New sources (all OPENED locally): gate/src/qm736/ (2609.36045, 1906.07384, 0809.0830, 0802.1301, 1209.3527, 1403.5818, math/9903146, Harder thesis, JHEP06(2023)164 = published 2304.00027). Renders: src/targets/renders736/p12,p15,p23,p24.png (2304.00027); src/renders_qm/p62,p96,p100,p101,p103.png (Smith 0705.3658).
Helpers (by role): tools/rho736_check.py (evaluates the published eta quotient rho(tau) at CM points), tools/hilbert_qm.py (Hilbert symbols, ramification of quaternion algebras, Hasse invariants), tools/arxiv_batch_736qm.sh (retrying arXiv API batch).
arXiv ids cited below were checked on the arXiv abstract pages (title and authors match): 2304.00027, 2609.36045, 1906.07384, 0809.0830, 0802.1301, 1209.3527, 1403.5818, math/9903146, 0705.3658, 2407.00493 (latest version v2).

## In plain words

- **The 736 surface's equation is already in print, but nobody knows it is the 736 surface.**
  - Ahmed and Ruehle (2023) list two special members of the Dwork family. The second is exactly our 736 surface.
  - But they print its parameter upside down: they write psi^-4 = -9/16 where their own formula gives psi^-4 = -16/9, i.e. psi^4 = -9/16.
  - We checked this three ways: their eta-function formula evaluated to 30 digits gives -16/9; the dashed line in their own Figure 7 sits where psi^4 = -9/16 puts it; and the other point (-1/48) in the same sentence comes out right.
  - The published journal version (JHEP 2023) carries the same misprint.
  - They never count conics. No paper found says which Dwork member has 736 conics, and no paper connects that member to T = [12,0,16].
  - So what we can claim is the identification and the conics: "the 736-conic quartic is the Dwork member at the CM point tau = (1+sqrt(-3))/2, which is defined over Q". We cannot claim the polynomial alone.
- **The quaternion-6 vein: half of it is already in print, the 2-parameter statement was not found.**
  - The general fact is textbook. A rank-4 form with square discriminant has even Clifford algebra D x D, with D a quaternion algebra (van Geemen, Thm 7.7).
  - Smith's thesis (2007) already computed the monodromy of the one-parameter slice of our family, the W(B4) pencil (his family XI). He placed it in the quaternion algebra (3,-1). We checked that (3,-1) over Q is ramified exactly at 2 and 3, the same discriminant-6 algebra our mirror seat found. Smith writes the algebra over Q[sqrt2, sqrt3] and never says "discriminant 6". That identification is ours (ARGUED).
  - We found no paper that says the full 2-parameter octahedral (Goursat) family has anisotropic T, or that its moduli are a compact surface commensurable with X_6 x X_6.
  - The closest work treats the non-compact cousins: Hashimoto-Nagano-Ueda (2-parameter K3 families, giving Hilbert modular surfaces and products of modular curves) and Elkies-Kumar (Hilbert modular surfaces).
  - An extra check (ARGUED): T_gen cannot embed in U^3, so generic members have no Shioda-Inose structure. That explains why the usual abelian-surface machinery misses this family.

## Step 0: our own files

- `selfcite "736 conics|736-conic|c^4 = -144|psi^4 = -9/16|-9/16|9w^4|4^2A4|Dwork pencil|Dwork family|Fermat pencil|12, 0, 16" "equation|CM|conics|member" "quartic K3" --exclude <project>` gave 14 hits in 9 files.
  - Paper-citing hits: our pencils gate row A(1h) (Degtyarev 2407.00493, already in TARGETS-NEXT). 2012.15821 (K3 compute papers: numerical CY metrics on Fermat/Dwork quintic, no conics). Bouyer 1511.01781 (Heisenberg family, already gated).
  - None names the 736 member or psi^4 = -9/16.
- `selfcite "quaternion|quaternionic|Shimura" "K3|transcendental|monodromy" --exclude <project>` gave 10 hits in 10 files.
  - All are hyperkahler/Hurwitz-quaternion hits from the K3/PAGE projects, plus one Shimura-reciprocity hit (ramanujan deg11).
  - None is about quaternionic moduli of K3 families.
- Inside this project (not excluded): mirror/REPORT-MIRROR.md section 5 (the vein; "The quaternion-6 structure: no source found, and not searched further"). familymap/REPORT-FAMILY1.md l.93 gives T_gen Gram [2,-4,2,0; -4,-20,-24,-4; 2,-24,-14,4; 0,-4,4,-22].

Suggested lines for selfcite-aliases.txt:
- `736-conic quartic|psi^4 = -9/16|psi^-4 = -16/9|c^4 = -144|-x^4+y^4+z^4+9w^4+6xyzw|Dwork CM point tau=(1+sqrt(-3))/2|Ahmed-Ruehle second CM point`
- `octahedral Goursat family|W(B4) pencil|Smith family XI|quaternion algebra (3,-1)|discriminant 6 quaternion algebra|Shimura curve X_6|X_6 x X_6`

## Aliases searched

- 736 member: Dwork / Fermat-Dwork pencil / one-parameter Fermat quartic / mirror quartic pencil; psi^-4 = rho(tau); CM point tau = (1+sqrt3 i)/2; "736 conics"; 4^2A4-quartic; Picard-20 / singular / attractive member; T = [12,0,16] (disc 192).
- Quaternion vein: quaternionic multiplication; Shimura curve / Shimura surface / product of Shimura curves; anisotropic transcendental lattice; Picard number 18 without Shioda-Inose structure; Kuga-Satake for rank-4 T; Goursat / octahedral / S4-symplectic quartic family; W(B4) pencil = Smith family XI; Hilbert modular surface analogues (Elkies-Kumar, Hashimoto-Nagano-Ueda).

## Object 1. The 736-conic quartic

### (2) Ahmed-Ruehle eq. (61): misprint, not a different convention

Quoted from the rendered pages (src/targets/renders736/), arXiv 2304.00027v1:
- Convention, eq. (27), p.11 (text layer l.687-692): "the one-parameter families of CY (n-1)-folds in P^n, sum_{i=0}^n z_i^{n+1} - (n+1) psi prod_{i=0}^n z_i = 0". For the quartic (n = 3) this is sum z^4 - 4 psi prod z.
- Period, eq. (45), p.14: "varpi_1 = 3F2(1/2, 1/4, 3/4; 1, 1; 1/psi^4)".
- Modular parameter, eq. (47), rendered p.15: "rho(tau) = 256 eta(tau)^24 eta(2tau)^24 / (eta(tau)^24 + 64 eta(2tau)^24)^2 ... We can then simply calculate the corresponding psi values from psi^-4 = rho(tau)."
- Eq. (60)-(61), rendered p.23: "tau = (1+3i)/2 and tau = (1+sqrt3 i)/2. (60) These correspond to psi^-4 = rho(tau) = -1/48 and psi^-4 = rho(tau) = -9/16, (61)".
- Fig. 7 caption, rendered p.24: "a codimension 1 slice psi = (1+i)rho in the moduli space, which contains CM points at psi^-4 = -1/48 and psi^-4 = -9/16 (corresponding to the dashed lines at rho = -0.61 and rho = -1.86)." The plot shows dashed lines at about -1.86 and -0.61.
- Published version, JHEP06(2023)164, eq. (5.2) (src/qm736/jhep_2023_164.txt l.1559-1564): the same "psi^-4 = rho(tau) = -9/16". It was not corrected. arXiv has only v1.

Our check (tools/rho736_check.py, 30 digits, run under memcap):

| tau | rho(tau) from their (47) | 1/rho |
|---|---|---|
| (1+3i)/2 | -0.0208333333333333 = -1/48 | -48.0 |
| (1+sqrt3 i)/2 | -1.77777777777778 = -16/9 | -0.5625 = -9/16 |

- Positive control: the identity (46), 3F2(1/2,1/4,3/4;1,1;rho(tau)) = (eta^16/eta(2tau)^8 + 64 eta(2tau)^16/eta^8)^(1/2) at tau = 1.3i gives 1.00680700368617 on both sides. The first CM value, -1/48, is reproduced. DPVZ 1906.07384 (2.5)-(2.6) and Yu Fu 2609.36045 §8.1 give the same -1/48 at (1+3i)/2.
- Slice check: on psi = (1+i)rho we have psi^4 = -4 rho^4.
  - psi^-4 = -1/48 gives |rho| = 1.86121, which matches the -1.86 line.
  - psi^4 = -9/16 gives |rho| = 0.612372, which matches the -0.61 line.
  - psi^-4 = -9/16 would give |rho| = 0.816497. No line is drawn there.
- **Verdict on (2): misprint.** At tau = (1+sqrt(-3))/2 the paper's own formula gives psi^-4 = -16/9, i.e. psi^4 = -9/16. The printed -9/16 is the reciprocal. The convention is the standard one (eq. (27)), so no change of parameter explains it. The paper's own figure was computed at the correct value.
- Normalisation to our equation. In X736 : -x^4+y^4+z^4+9w^4+6xyzw, set x = aX with a^4 = -1 and w = bW with b^4 = 1/9. This gives sum X^4 + c XYZW with c = 6ab, so c^4 = 1296·(-1)·(1/9) = -144. With c = -4psi, 256 psi^4 = -144, so psi^4 = -9/16 and psi^-4 = -16/9. This is exactly the second Ahmed-Ruehle CM point.
  - This agrees with our seat: psi^-4 = -9/16 is a generic 608 member; psi^4 = -9/16 gives 736.
  - Since psi^4 is rational, the member is defined over Q.

### (1) Is the 736 member published as the 736 surface?

| item | verdict | best source | label | quoted sentence | locator |
|---|---|---|---|---|---|
| 736 member's equation in print (any form) | **PARTIAL (in substance TAKEN, as an unlabelled CM point, with a misprinted value)** | Ahmed-Ruehle arXiv 2304.00027 = JHEP06(2023)164 | OPENED (rendered) | "These correspond to psi^-4 = rho(tau) = -1/48 and psi^-4 = rho(tau) = -9/16" (for tau = (1+3i)/2 and (1+sqrt3 i)/2). With their (27) and (47), the second point is psi^4 = -9/16 = our X736. | 2304.00027 p.23 eq. (60)-(61); p.15 eq. (47); p.11 eq. (27); JHEP eq. (5.2) |
| Anyone says which Dwork member has 736 conics / T = [12,0,16] / configuration (5.10) | **OPEN** (search floor) | Degtyarev 2407.00493v2 (closest) | OPENED | "4^2A4-quartics constitute a 1-parameter family (see Addendum 1.4), and only one of them has 736 conics." Addendum 1.4: "There exists an equiconical 1-parameter family X of (generically) 4^2A4-quartics with 608 irreducible conics ... The closure of this family contains quartics (1) and (2) in Theorem 1.1, as well as the Barth-Bauer quartic with 640 conics". §7.3 gives only the lattice "T = [-4] ⊕ [8] ⊕ [8]". No equation or parameter value. | 2407.00493v2 p.2 (l.102-104), Addendum 1.4 (l.138-141), §7.3 (l.1829-1840) |
| Ahmed-Ruehle count conics or name T | no | 2304.00027 | OPENED | §3.1.3 discusses only CM and Picard rank 20: "the rank of the Picard lattice is enhanced to 20 over a dense set of countably many points". No conics, no lattice. | p.14 |
| Yu Fu (CM fibre of the mirror quartic pencil) | uses the other CM point only | Fu arXiv 2609.36045 | OPENED | "Let tau be a root of tau^4 = -1/12288; then z_hyp = -1/48. At this value the associated Fermat-Dwork quartic has Picard number 20 and is a Kummer surface associated with the CM order of discriminant -36" | §8.1 p.33 |
| DPVZ (Asai recognition) | the other CM point only | Dembele-Panchishkin-Voight-Zudilin arXiv 1906.07384 (Exp. Math. 31 (2022)) | OPENED | "At the specialization z = psi^-4 = -1/48, the K3 surface is singular, having Picard rank 20; it arises as the Kummer surface of E x tau(E) ..." | p.3 l.105-110; Example 3.12 p.7-8 |
| Elkies-Schutt: singular members of the Dwork pencil | candidates computed, not listed | Elkies-Schutt arXiv 0809.0830 | OPENED | "we computed candidates for the singular specializations for the Dwork pencil x0^4+x1^4+x2^4+x3^4 = lambda x0x1x2x3 ... (cf. [13] for a detailed account)". [13] = "Elkies, N. D., Schutt, M.: K3 families of high Picard rank, preprint (2008)". Not found online (UNVERIFIED that it exists in public). | p.13 l.663-669; refs l.1864 |
| Brandhorst-Hashimoto | does not cover 4^2A4 | 1910.05952 | OPENED | Treats only "the 11 maximal groups"; 4^2A4 (#75) is not maximal. Its Dwork-type equation is Mukai's "x4 + y4 + z4 + w4 + 12xyzw = 0" (= 800). | p.1 Thm 1.1; l.1111 |
| Naskrecki, Bonnafe-Sarti, Mukai/Kondo | 800 only | earlier gates (TARGETS-NEXT) | OPENED there | no 736 | - |
| Citers of Ahmed-Ruehle (OpenAlex, 16) | none push it | e.g. Grimm-van de Heisteeg "Exact flux vacua..." (JHEP01(2025)005); van de Heisteeg-Lin-Maggiorotti 2610.18959 | ABSTRACT | physics (flux vacua, attractors, numerical metrics, duality defects); no conics | QUERIES-736QM.log |
| Citers of Degtyarev 2407.00493 (OpenAlex) | 2 (unchanged since 11-20) | 2512.08018, 2512.06145 | title | no 736 | log |

## Object 2. Quaternion-6 structure of Goursat's octahedral family

First the vein's arithmetic was re-derived independently (tools/hilbert_qm.py, memcap):
- Controls: (-1,-1) is ramified at {inf, 2} (Hamilton). (2,5) is ramified at {2,5}.
- The mirror seat's diagonal form <2,-7,-21,6> (square determinant 1764 = 42^2) has Hasse invariants (T vs split) of 2: (1,-1); 3: (-1,1); 5, 7, inf: equal. This matches mirror/runs/iso.out.
- Writing it as 2<1,-14,-42,3> ~ c·nrd of (14,42) ≅ (14,-3): ramified at {2,3}. **Discriminant 6, indefinite.** ARGUED (exact Hilbert-symbol arithmetic).
- Smith's algebra (3,-1) over Q: ramified at {2,3}. **The same discriminant-6 algebra.**

| item | verdict | best source | label | quoted sentence | locator |
|---|---|---|---|---|---|
| General: quaternary form of square discriminant gives C^+ = D x D, D a quaternion algebra over Q | **TAKEN** (textbook) | van Geemen, "Kuga-Satake varieties and the Hodge conjecture", arXiv math/9903146 | OPENED | "Theorem 7.7 ... In case n = 2m, let d := (-1)^m d1...dn ... (a) In case sqrt d ∈ Q we have C+(Q) ≅ M_{2^{m-2}}(D) x M_{2^{m-2}}(D) with a quaternion algebra D over Q." | §7, Thm 7.7, txt l.898-911 |
| Rank-19 slice of the family (W(B4) pencil = Smith family XI = Goursat slice E(1+t) = 4, earlier gate) has quaternionic (Shimura-curve) monodromy in (3,-1) | **TAKEN** for the monodromy statement; the **disc-6 identification is ours (ARGUED)** | Smith, PhD thesis, arXiv 0705.3658 | OPENED (rendered p.93 and p.89) | "The projective monodromy group is generated by M_inf = (1/sqrt6)(3j - k), M_-1 = (1/sqrt3)(i + 3j - k), M_-1/2 = i + 2j, M_-1/3 = (1/sqrt3)(i + 3j + k), M_-1/4 = (1/sqrt6)(3j + k) in (3,-1 / Q[sqrt2, sqrt3])." with "i = diag(sqrt3, -sqrt3)", "j = [[0,1],[-1,0]]", "k = i.j". p.89: "This projective monodromy group is contained in the image of a representation of the quaternion algebra (3,-1 / Q[sqrt2,sqrt3])." p.85: "Corollary 3.18. If Γ_S is the monodromy group of a rank 19 lattice polarised family of K3 surfaces, then Γ_S^(2) is derived from an order in a quaternion algebra over the rational numbers." | 0705.3658 Diff. Eq. XI, printed p.93 (pdf p.100); p.89 (pdf p.96); p.85 |
| Smith family XI is cocompact / X_6 named | not stated | 0705.3658 | OPENED | Smith states the dichotomy ("Fuchsian groups without cusps have compact fundamental domains") but does not name X_6 or discriminant 6 for XI. Reduced norms of his generators in (3,-1)_Q: 6, 3, 1, 3, 6 (our arithmetic). These are Atkin-Lehner-type elements, consistent with a quotient of X_6 (ARGUED). | p.85-86 |
| Full 2-parameter family: T_gen ⊗ Q anisotropic, moduli = compact quaternionic Shimura surface commensurable with X_6 x X_6 | **OPEN** (search floor) | closest: Hashimoto-Nagano-Ueda arXiv 1403.5818 | ABSTRACT + OPENED (grep) | "We give detailed descriptions of the period maps of two 2-parameter families of anti-canonical hypersurfaces in toric 3-folds. One of them is related to a Hilbert modular surface, and the other is related to the product of modular curves." These are the isotropic cases; grep finds no "quaternion", "Shimura" or "anisotropic". | 1403.5818 abstract; src/qm736/1403.5818.txt |
| Rank-18 K3 ↔ Hilbert modular surfaces (isotropic, via Shioda-Inose) | TAKEN (different case) | Elkies-Kumar arXiv 1209.3527; Harder thesis (Queen's 2011) | OPENED | Elkies-Kumar: "coarse moduli spaces for principally polarized abelian surfaces with real multiplication ... via moduli spaces of elliptic K3 surfaces with a Shioda-Inose structure". Harder: "we establish a precise relationship between the moduli spaces of rank 18 polarized K3 surfaces and Hilbert modular surfaces, and between the moduli spaces of rank 19 polarized K3 surfaces and Shimura curves." | 1209.3527 abstract p.1; Harder abstract p.i |
| K3 families over the Shimura curve X(6) (rank 19) | TAKEN (1-dim only) | Elkies arXiv 0802.1301 (ANTS VIII) | OPENED | "For N = 6 we find explicit elliptic models for our family of K3 surfaces S parametrized by X(6)/<w6>" | p.2 l.81-84 |
| Kummer families over Shimura curves | TAKEN (1-dim, Kummer) | Besser-Livne, "Universal Kummer families over Shimura curves" (Fields Inst. Commun. 67, 2013), DOI 10.1007/978-1-4614-6403-7_7 | title only (OpenAlex, no abstract) | - | OpenAlex W29798631 |
| T_gen has no primitive embedding in U^3, so the generic member has no Shioda-Inose structure | ARGUED (ours); criterion SNIPPET | Morrison 1984 Cor. 6.4 via web snippet | SNIPPET | "(ii) ρ(X) = 18 and T_X = U ⊕ T'" (criterion as quoted in a later paper; Morrison not opened). Our argument: an embedding gives T ⊗ Q ⊕ N ⊗ Q ≅ H^3 with N of rank 2 and disc ≡ -1 mod squares, so N ≅ H. Witt cancellation then forces T ⊗ Q ≅ H^2, which is isotropic. That contradicts iso.out. | web search results; mirror/runs/iso.out |
| S5 quartic family ("Period map of a certain K3 family with an S5-action") | different (rank 19) | Crelle 652 (2011), DOI 10.1515/crelle.2011.014, arXiv 0904.0072; author not confirmed this seat | SNIPPET | "The Grammian matrix of the transcendental lattice T of a generic fiber of our family is equal to [4,1,0;1,4,0;0,0,-20]" (1-dim) | web snippet |
| Zenodo, OpenAlex keyword floors | 0 relevant | - | - | see log | QUERIES-736QM.log |

## Search floor

- Zenodo API, with passing controls ("K3 surface" 110; "K3 surfaces" AND "Picard" 41):
  - `"736 conics"` 0
  - `"Dwork pencil" AND conics` 0
  - `"Shimura curve" AND "K3 surface"` 0
  - `"quaternionic multiplication" AND "K3"` 0
  - `"Shimura" AND "K3 surfaces" AND quaternion` 0
  - `"octahedral" AND "quartic" AND "K3"` 0
  - `"Fermat quartic" AND "Dwork"` 0
  - `"Mukai" AND "conics" AND quartic` 0
  - The un-ANDed forms return thousands of OR-matches; their top 10 were read and none is relevant.
- OpenAlex title_and_abstract, with passing controls (`"conics" AND "quartic surfaces"` 39, which shows the Barth-Bauer, Degtyarev and Naskrecki papers; `"Shimura curves" AND "K3"` 4):
  - `"736 conics"` 0
  - `"Dwork" AND "conics"` 0
  - `"Fermat quartic" AND "conics"` 1 (char-3 lines paper)
  - `"Shimura" AND "K3" AND "Picard number 18"` 0
  - `"quaternion algebra" AND "K3 surfaces"` 8 (Brauer-Manin, Elkies 0802.1301, Zenodo items; none relevant)
  - `"octahedral" AND "quartic" AND "K3"` 0
  - `"Goursat" AND "quartic"` 6 (none relevant)
  - `"product of Shimura curves"` 4 (number theory; none on K3)
- OpenAlex citation trails, every title read:
  - Ahmed-Ruehle W4382139142: 16 citers.
  - Smith W2104838601: 11. These include Doran-Harder-Novoseltsev-Thompson (monodromy of lattice-polarized families), Filip (Lyapunov exponents), Hashimoto S5 and Besser-Livne. None is about the 2-parameter octahedral family.
  - Elkies 0802.1301 (both records): 27.
  - Elkies-Kumar W2161221308: 61. This includes Kumar's "Hilbert modular surfaces for square discriminants" (the isotropic square case) and Doran-Harder-Movasati-Whitcher "Humbert surfaces and the moduli of lattice polarized K3 surfaces".
  - None treats an anisotropic rank-4 T.
- arXiv API: rate-limited (HTTP 429/503) for this whole seat. The retrying batch tools/arxiv_batch_736qm.sh ran for about 35 minutes without one answer and was stopped by its PID. No arXiv line is in QUERIES-736QM.log; arXiv is NOT part of this seat's floor. The earlier gate's arXiv count queries (QUERIES-TARGETS.log: `all:"736 conics"` 0 with control `"800 conics"` 2) still stand for Object 1.
- Web search (general engine): 6 queries on rank-18 quaternionic/Shimura K3 families, Hashimoto-Ueda, Elkies-Schutt "K3 families of high Picard rank" and the -16/9 or -9/16 Dwork value. Nothing on the octahedral family or the 736 identification.
- Newest material covered: OpenAlex and Zenodo as of 2026-11-21. Newest relevant item opened: Fu 2609.36045 (2026-09-28).

## Most dangerous neighbours

- **Object 1.**
  - The CM/attractor physics groups: Ahmed-Ruehle, and Grimm/van de Heisteeg, who cite them. They already work at this exact CM point and could notice the misprint. They do not count conics.
  - Degtyarev holds the configuration (5.10). A single parameter search on the Dwork pencil would name the member.
  - Number theorists on hypergeometric motives at CM points (Voight, Zudilin, Fu) use only the -1/48 point so far.
- **Object 2.**
  - The Nagano / Hashimoto / Ueda school. They write explicit period maps of 2-parameter K3 families onto Hilbert modular surfaces and products of modular curves. The compact quaternionic case is the natural third member of their series.
  - Elkies and Kumar (explicit Shimura and Hilbert-modular equations via K3).
  - Doran-Harder and coauthors (lattice-polarized families with monodromy).

## Methods worth borrowing

- The eta quotient rho(tau) of 2304.00027 (47) and 1906.07384 (2.5) is a closed-form certificate for the 736 member. rho((1+sqrt(-3))/2) = -16/9 exactly. To be fully rigorous, prove it via the class-number-1 value of the Gamma0(2)+ Hauptmodul, or by an interval evaluation with a rationality bound.
- For the quaternion vein:
  - Smith's explicit monodromy generators of family XI (reduced norms 6, 3, 1, 3, 6 in (3,-1)) give the arithmetic group of one NL curve directly. The other 7 NL curves can be tested against Hecke correspondences of X_6 the same way.
  - Elkies 0802.1301 gives explicit coordinates on X(6)/<w2,w3> and X(6)/<w6> ("r" with "X(6) is obtained by extracting a square root of -(27r^2 + 16)"). These are the targets for matching.

## The gap that is genuinely open

- No source says that the Dwork member psi^4 = -9/16 (tau = (1+sqrt(-3))/2, defined over Q) is Degtyarev's 736-conic quartic with T = [12,0,16]. Its 736 conics are not written down anywhere.
- No source says that Goursat's 2-parameter octahedral family has a compact quaternionic (discriminant 6, ~X_6 x X_6) moduli surface. Only its one-parameter W(B4) slice has published quaternion monodromy.

## Loose ends

- arXiv API was rate-limited for the whole seat (no query returned). arXiv coverage for Object 2 rests on OpenAlex (which indexes arXiv), Zenodo and web search. Re-run tools/arxiv_batch_736qm.sh when the limit clears, before any OPEN is published.
- Elkies-Schutt "K3 families of high Picard rank" (preprint 2008, cited as [13] in 0809.0830): not found online; UNVERIFIED. It may list Dwork CM members but would not count conics.
- Morrison 1984 (Shioda-Inose criterion) was not opened; it is cited via snippet only. The no-SI argument above is ours.
- Besser-Livne 2013 and Filip 2018 were seen as titles only (no open abstract in the record).
- Smith's algebra is printed over Q[sqrt2, sqrt3], over which (3,-1) splits. Our reading that the group lives in (3,-1)_Q rests on the generators having rational coordinates in i, j, k up to scalars (rendered p.93). ARGUED.
- The claim "Ω/O(T_gen) is commensurable with X_6 x X_6" is ARGUED from Spin(c·nrd_D) ≅ D^1 x D^1. Not checked against the actual arithmetic group, and not certified.

Written with AI assistance.

## Ledger lines

GATE 736 member = Dwork CM point psi^4=-9/16 (equation printed unlabelled and misprinted; 736/T identification absent) PARTIAL source=arXiv:2304.00027 (+arXiv:2407.00493)
GATE quaternion disc-6 compact moduli (~X_6 x X_6) of Goursat octahedral 2-parameter family PARTIAL source=arXiv:0705.3658 (slice XI monodromy in (3,-1)) (+arXiv:math/9903146 general theory)

```
python "memcap.py" 1 python "lab.py" gate <project> "736-conic quartic = Dwork member psi^4=-9/16 (tau=(1+sqrt-3)/2); equation printed by Ahmed-Ruehle as unlabelled CM point with misprinted psi^-4=-9/16; nobody identifies it with 736 conics / T=[12,0,16]" PARTIAL --file gate/PRIOR-ART-736-QM.md --source "arXiv:2304.00027" --queries gate/QUERIES-736QM.log
python "memcap.py" 1 python "lab.py" gate <project> "Goursat octahedral 2-parameter quartic family: T_gen anisotropic, disc-6 quaternion algebra, compact moduli ~ X_6 x X_6 (rank-19 slice XI monodromy in (3,-1) already published)" PARTIAL --file gate/PRIOR-ART-736-QM.md --source "arXiv:0705.3658" --queries gate/QUERIES-736QM.log
```
