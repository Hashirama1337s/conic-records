# PRIOR-ART-660-640: the 660-conic S5 quartic, the 640-conic Dwork member, and the arXiv re-run for 736/QM

Gate date: 2026-11-21. Prior-art scout seat, strongest tier. This extends TARGETS-NEXT.md, PRIOR-ART-664-704.md, PRIOR-ART-736-QM.md and PRIOR-ART-656-EQ.md and does not redo them.
Queries: gate/QUERIES-660-640.log (117 lines, 14 controls). `lab.py searchcheck` prints: "search floor OK: every database with a zero-hit query has a passing positive control".
Databases: arXiv export API (answered HTTP 429 at first, HTTP 200 later in the seat), arXiv HTML search, Zenodo API (via curl), OpenAlex (search + citers), INSPIRE (fulltext, refersto). Web search engine: 5 queries (not logged as counts).
New sources (all in gate/src/g660/, pdf + txt): 0904.0072, 1604.02567, 1605.08720, 0712.1332, 2601.07030, 1504.07498, 2608.14495, 2602.04128, 2607.19427. Renders: renders/ (0904.0072 p.5, 22, 59, 63, 66), renders_dolg/ (1604.02567 p.4, 6), renders_amnt/ (2601.07030 p.13, 20, 21, 28), renders_zud/ (0712.1332 p.7), renders_bh/ (1910.05952 p.13-14).
Helpers (by role, in gate/tools660/): q660.py (arXiv / Zenodo / OpenAlex query + log line), batch660.sh, rerun660.sh, api660.sh (arXiv export-API re-run of the 736qm batch), zen660.sh (Zenodo via curl), insp660.sh (INSPIRE), ht_cm.py (evaluates Hashimoto's inverse period map at the printed CM points), t4check.py (evaluates the level-2 eta quotient at CM points).
arXiv ids: every id cited below was checked through the arXiv export API (id_list) or the abstract page; titles and authors match.
Newest material covered: arXiv listing results up to 2611.26001 (submitted 2026-11-19); Zenodo, OpenAlex and INSPIRE queried 2026-11-21.

## In plain words

- **X660 (660 conics).** The family is published and has a name. The member is not.
  - The pencil p4 + L·p2^2 on σ1 = 0 is exactly the family studied by Kenji Hashimoto (arXiv 0904.0072, Crelle 2011), "t0(x1^4+...+x5^4) + t1(x1^2+...+x5^2)^2 = 0". Dolgachev (arXiv 1604.02567) calls it "the Hashimoto pencil".
  - Hashimoto's conventions match ours exactly: his singular fibres are at t1/t0 = -1/4, -1/2, -7/30, -13/20 and the double quadric, which are our L values. X660 is his fibre t = (6 : 1). Dolgachev writes the pencil with the opposite sign, so in his notation X660 is S_{-1/6}.
  - Published special members: the four nodal members (with their transcendental lattices) and one smooth Picard-20 member, the Maschke/Mukai surface at Dolgachev's t = (3/20)(3 - i) with T = diag(4, 40). Hashimoto computes his inverse period map at 8 CM points but never prints their t values. We evaluated his formula: the only Q(√-15) point goes to t = -1/2 (a nodal member). So none of the published CM points is X660.
  - Nobody prints t = (6 : 1), the field Q(√-15) with T = [4,0,60] for a smooth member, or "660 conics".
- **X640 (640 conics).** The parameter value is published as a CM value, but never as a K3 surface.
  - ψ^-4 = 1/2401 = 1/7^4 is Ramanujan's 1914 singular value: Σ (1/2)n(1/4)n(3/4)n/n!^3 (40n+3)/7^{4n} = 49/(3π√3) (Ramanujan eq. (42), quoted by Zudilin 0712.1332 and DPVZ 1906.07384).
  - DPVZ says outright that this hypergeometric belongs to the Fermat-Dwork pencil, with z = ψ^-4.
  - A 2026 paper (Arora-Mondal-Nakagawa-Tu, arXiv 2601.07030, Table 3(B)) prints the row "t = 1/7^4, τ = 3i/√2, f8.3.d.a". Their hauptmodul t4 is the same eta quotient as Ahmed-Ruehle's ρ.
  - So "Σx^4 + 28xyzw is a Picard-20 member at τ = 3i/√2" is one published dictionary step away. We found no source that takes that step, writes the quartic, gives T = [4,0,72], or links it to 640 conics. Degtyarev says only that the 640-conic Barth-Bauer quartic lies in the closure of the 4^2A4 (Dwork) family.
- **The arXiv re-run changes the 736 verdict's wording, not its level.**
  - The arXiv API answered this time. The full 736qm batch was re-run with the same query strings and found nothing new on conics, quaternionic Shimura moduli or the octahedral family.
  - The citation trail found the same 2026 paper: its Table 3(B) row "t = -16/9, τ = (1+√3 i)/2, f12.3.c.a" prints the *correct* value of the 736 member's parameter (ψ^-4 = -16/9), together with its weight-3 CM newform. This independently confirms PRIOR-ART-736-QM's misprint verdict on Ahmed-Ruehle (-9/16). The 736 parameter is therefore now in print correctly, not only misprinted, but still with no K3, conics or lattice attached.
  - The 736 verdict stays PARTIAL, and the quaternion-6 verdict stays PARTIAL.

## Step 0: our own files

- `selfcite "660 conics|640 conics|2 sigma2^2 = 3 sigma4|S5-invariant quartic|S5 quartic|A5 pencil|Clebsch|Coble|28xyzw|psi^4 = 2401|psi = -7|4, 0, 72|4, 0, 60" "equation|Picard number 20|CM|conics|member" "quartic K3" --exclude ` gave 14 hits in 9 files.
  - Paper-citing hits: pencils gate row A(1h) (Degtyarev 2407.00493, already gated); Degtyarev's text "Bauer quartic with 640 conics, see [10] and (5.15)" and "X60: 60 lines, 140 + 500 = 640 conics" (2407.00493 l.143, l.1908; that is X'60, a different surface with field Q(√-15)); Bouyer 1511.01781; 2012.15821 (numerical CY metrics, Dwork quintic).
  - None names the Hashimoto pencil, t = 1/6, ψ^4 = 2401 or Σx^4 + 28xyzw.
- Inside this project: r660/REPORT-660-640.md (the pipeline seat). It said "For X660, no prior-art search was run" and "Smith's A5 pencil (0705.3658 p.20) is likely a different representation". Both points are settled below.
- Our own earlier gate PRIOR-ART-736-QM.md row "S5 quartic family ... arXiv 0904.0072; author not confirmed this seat; SNIPPET". This seat OPENED it: the author is Kenji Hashimoto (appendix by Tomohide Terasoma), and it is our 660 pencil.

Suggested lines for POCKETLAB/lab/tools/selfcite-aliases.txt:
- `660-conic quartic|X660|Hashimoto pencil|S5-invariant quartic pencil|t0 s4 + t1 s2^2 on s1 = 0|p4 + L p2^2 on sigma1 = 0|2 sigma2^2 = 3 sigma4|configuration (5.13)|S_{-1/6}|t = (6:1)`
- `640-conic quartic|X640|Dwork psi^4 = 2401|psi^-4 = 1/2401|sum x^4 + 28xyzw|t4 = 1/7^4|tau = 3i/sqrt2|Ramanujan (40n+3)/7^{4n}|configuration (5.15)|[4,0,72]`
- add to the 736 line: `t4 = -16/9|f12.3.c.a`

## Aliases searched

- X660: Hashimoto pencil; S5- / A5-invariant quartic surfaces; symmetric quartic surfaces; icosahedral quartic surfaces (Dolgachev); W(A4) = S5 standard representation W4; quartics on the Segre cubic / Igusa quartic sections; Shimura curve X(15,2) (Hashimoto's moduli); Picard-20 / CM / singular K3 member; 660 conics; configuration (5.13); Clebsch / Coble / Mukai S5 quartic.
- X640: Fermat-Dwork pencil; Dwork family; mirror quartic pencil; Ramanujan singular value z = 1/2401 / 7^{-4}; level-2 hauptmodul t4 / ρ(τ); CM point τ = 3i/√2; weight-3 CM newform f8.3.d.a; attractor point; Barth-Bauer 640 quartic; 28xyzw.

## Object 1. X660: 6(x1^4+...+x5^4) + (x1^2+...+x5^2)^2 = 0 on x1+...+x5 = 0

### Normalisations (EXACT, by hand)

- Newton identities on σ1 = 0: p2 = -2σ2 and p4 = 2σ2^2 - 4σ4. So 6p4 + p2^2 = 16σ2^2 - 24σ4, and X660 is 2σ2^2 = 3σ4 (as in the brief).
- Hashimoto (3.1): t0·s4 + t1·s2^2 = 0, with s_k the power sums. X660 is (t0 : t1) = (6 : 1), t = t1/t0 = 1/6.
- Hashimoto Prop. 3.1 singular fibres: t1 = (4 : -1) (15 A1), t2 = (2 : -1) (10 A1), t3 = (30 : -7) (10 A1), t4 = (20 : -13) (5 A1), t5 = (0 : 1) (double quadric). The pipeline seat's singular L values were -1/4, -1/2, -7/30, -13/20 and ∞, which is the same convention.
- Dolgachev (3.2): p4 - t·p2^2 = 0, with singular t = 1/4, 1/2, 7/30, 13/20. So t_Dolgachev = -t_Hashimoto, and X660 = S_{-1/6}. The pipeline seat's second NL point L = -7/12 (570 conics) is S_{7/12} there.

### Table 1: verdicts

| item | verdict | best source | label | quoted sentence | locator |
|---|---|---|---|---|---|
| The S5 pencil p4 + L p2^2 on σ1 = 0 | **TAKEN** (family, studied in detail) | K. Hashimoto (appendix by T. Terasoma), "Period map of a certain K3 family with an S5-action", arXiv 0904.0072, J. reine angew. Math. (OpenAlex W2963876592) | OPENED | "we study the period map of the family {Xt} t=(t0:t1)∈P1 of quartic K3 surfaces defined by Xt : x1 + ··· + x5 = t0(x1^4 + ··· + x5^4) + t1(x1^2 + ··· + x5^2)^2 = 0 (0.1) in P4" ... "The restriction of the action of S5 to A5 on each Xt is symplectic." Generic T = [[4,1,0],[1,4,0],[0,0,-20]]. Main theorem (rendered p.59, Thm 7.8): t1/t0 = -(1/5)((s-1)/(s+2))^2 - 1/4 in terms of genus-2 theta constants; Cor. 7.9 gives the Shimura curve X(15,2). | 0904.0072 p.1 (0.1), p.2, p.4 (0.8); Prop. 3.1 p.22; Thm 4.15 p.33; Thm 7.8 p.59 |
| The pencil is named and classical members identified | **TAKEN** | Dolgachev, "Quartic surfaces with icosahedral symmetry", arXiv 1604.02567v3, Adv. Geom. (2018), DOI 10.1515/advgeom-2017-0040 | OPENED (rendered p.4, 6) | "The pencil (3.2) was intensively studied by K. Hashimoto in [10]. So, it is appropriate to refer to it as the Hashimoto pencil." Also: "any smooth quartic surface S with a faithful action of A5 belongs to one of the two pencils of invariant quartic surfaces"; "S1/2 is isomorphic to the K3-cover of an Enriques surface with Aut(X) ≅ S5 (of type VI in Kondo's classification)"; S7/30 "is a quartic symmetroid". | 1604.02567 p.1, p.4, Prop. 3 p.3 |
| Published Picard-20 members of the pencil | **PARTIAL (other members)** | Hashimoto Thm 4.15; Dolgachev Thm 1 and Remark 1 | OPENED | Nodal members (resolved): "4 0 0 10 (t = 1/2), 4 1 1 4 (t = 1/4), 4 2 2 16 (t = 7/30), 6 0 0 20 (t = 13/20)" (Dolgachev's t; Dolgachev's text pairs [4,0,0,10] with 1/2 and [4,1,1,4] with 1/4, while Hashimoto's Thm 4.15 pairs [4,0,0,10] with t1 (15 nodes, t = -1/4) and [4,1,1,4] with t2 (10 nodes, t = -1/2): the two papers disagree on this pairing, see Loose ends). Smooth member: "According to computations made by Bert van Geemen, the surface V(M1) corresponds to the parameter t = (3/20)(3 - i). Note that according to S. Mukai the transcendental lattice of the Maschke surface is given by the diagonal 2 × 2-matrix with the diagonal entries 4 and 40." | 0904.0072 Thm 4.15 p.33; 1604.02567 Thm 1 p.5, Remark 1 p.5-6 |
| Hashimoto's CM points: is X660 among them? | **NO** (ARGUED, by evaluating his formula) | 0904.0072 Appendix (Terasoma) | OPENED + our evaluation | The Appendix gives theta ratios at 8 CM points p1..p8 (fields from D = 3, 7, 15, 13, 22, 30, 10) but prints no t values. tools660/ht_cm.py evaluates Thm 7.8 at the cleanly parsed points: p2 (Q(√-7)) gives t = -3/10; p5 (Q(√-13)) gives r1 = 0, so t = -9/20; p4 (the only Q(√-15) point) gives t = -1/2 for the consistent sign choices, i.e. the 10-nodal fibre t2 with T = [4,1,1,4] (disc -15), which matches. X660 has t = +1/6. | Appendix p.63-69; tools660/ht_cm.py |
| X660 itself: the member t = (6 : 1) as a Picard-20 / CM / Q(√-15) / T = [4,0,60] / 660-conic quartic | **OPEN** (search floor) | closest: Hashimoto 0904.0072, Dolgachev 1604.02567, Degtyarev 2407.00493 (5.13) | OPENED | Degtyarev: "(5.13) |C| = 660 : ... [4, 0, 60] (1, 0). This is the same abstract K3-surface as the Barth-Bauer quartic with 664 conics, see [10]". No equation; no symmetry group given there. Dolgachev's list of open questions includes "Find the transcendental lattices of the general member of the pencil." Nobody prints t = 1/6 or ∓1/6. | 2407.00493 p.24 (txt l.1554-1561); 1604.02567 p.12-13 |
| Smith's A5 pencil (0705.3658 family XIV) | **different projective pencil** (ARGUED) | Smith 0705.3658; Dolgachev 1604.02567 | OPENED | Smith: "This family is singular at λ^2 = -80 and λ^2 = 1 and the symplectic automorphism group jumps to S5 at λ = 0." Dolgachev: the second pencil "arises from a faithful linear representation of the binary icosahedron group 2.A5". Smith's pencil has a member with symplectic S5; in the Hashimoto pencil the transpositions are non-symplectic. So Smith XIV is the 2.A5 pencil. But Hashimoto writes: "After finishing this work, we noticed a relevant paper [34], which treats the Picard-Fuchs equation for this K3 family" ([34] = Smith). The two families may share one lattice-polarised moduli curve (see Loose ends). | 0705.3658 p.20 and family XIV p.56; 1604.02567 p.1; 0904.0072 p.5 |
| Mukai's S5 example is a quartic? | **no** | Brandhorst-Hashimoto 1910.05952 §6.4 | OPENED (rendered p.13) | "A projective model of 70a is given in [25]: Σ_{i=1}^5 x_i = Σ_{i=1}^6 x_i^2 = Σ_{i=1}^5 x_i^3 = 0 in P5". The symplectic-S5 (#70) Picard-20 list has T ∈ {[10,0,20], [6,0,20], [4,1,4], [20,10,20], [4,2,16], [4,2,6]}. There is no [4,0,60], and our X660 has symplectic group A5 only. | 1910.05952 p.13 |
| All S5- / A5-invariant smooth quartics classified | **TAKEN (families only)** | Faina-Marcugini-Pambianco-Kaneta arXiv 1605.08720; Avila-Ortiz-Troncoso arXiv 2211.13273 | ABSTRACT (1605.08720; grep of full text finds no "Picard" or "K3" lines); OPENED (2211.13273 Thm A) | 1605.08720: "All S5-invariant nonsingular quartic surfaces are obtained." 2211.13273 Thm A(3): "The smooth quartic surfaces invariant by the primitive representations in PGL4(C) of S5 are in the pencil of quartics (b)", with singular fibres "[0 : 1], [1 : 0], [√15 : -4], [2√15 : -5], and [6√15 : 1]" (five, as in Hashimoto). No lattices, no conics. | 1605.08720 abstract; 2211.13273 p.3-4 |
| Clebsch / Coble S5 quartics | not found as distinct objects | - | - | The classical 10-nodal S5 quartics in the pencil are S1/2 (Kondo VI Enriques cover) and S7/30 (Cayley symmetroid) (Dolgachev). The "Coble fourfold" (Cheltsov-Kuznetsov-Shramov 1712.08906, title only) is an S6 quartic fourfold, not a surface. | - |
| "660 conics" anywhere | 0 | arXiv API, arXiv search, Zenodo, OpenAlex, INSPIRE fulltext | - | - | QUERIES-660-640.log |

### Citation trails (every title read)

- Hashimoto (OpenAlex W2963876592): 12 citers. They are Dolgachev (opened), Cheltsov-Przyjalkowski-Shramov "Quartic double solids with icosahedral symmetry" (2.A5 pencil per Dolgachev), Hashimoto "Finite symplectic actions on the K3 lattice", Yui "Modularity of Calabi-Yau varieties: 2011 and beyond", Garbagnati "Symplectic automorphisms and the Picard group of a K3 surface", "On a family of K3 surfaces with S4 symmetry", "Extensions of maximal symplectic actions on K3 surfaces", two chapters of the Cheltsov-Shramov icosahedron book, "The Calabi problem for Fano threefolds", the BIRS report "Number theory and physics at the crossroads", and plane sextics. No title concerns a special smooth member. Read at title level except Dolgachev.
- Dolgachev (OpenAlex W2341351390): 10 citers. Opened: Faina et al. 1605.08720, Avila-Ortiz-Troncoso 2211.13273, Bonnafé-Sarti 1910.05955 (M20; no Hashimoto pencil), Cheltsov-Shramov 1712.08258 (birational rigidity). Title only: Wiman-Edge pencil, "A four-dimensional cousin of the Segre cubic", Cremona dimension, projective superflows, Kaneta et al. 1611.10101, quartic threefolds 2610.39627. None names a Picard-20 member.

## Object 2. X640: x^4+y^4+z^4+w^4 - Σx_i^2x_j^2 + 10xyzw = 0 ≅ Σx^4 + 28xyzw

### Normalisations (EXACT / NUMERICAL)

- The pipeline seat's identity H*(Σx^4 + μ xyzw) with μ = 28 gives X640 (exact640.out, not re-derived here).
- DPVZ (1.4): "Xψ : x0^4 + x1^4 + x2^4 + x3^4 = 4ψ x0x1x2x3", z = ψ^-4. Σx^4 + 28xyzw is 4ψ = -28, ψ = -7 (ψ = 7 after x0 -> -x0), so z = 7^-4 = 1/2401.
- AMNT 2601.07030 Table 2 (rendered p.13): t4(τ) = 256η(τ)^24η(2τ)^24/(η(τ)^24 + 64η(2τ)^24)^2 on Γ0(2)+. This is the same formula as Ahmed-Ruehle (47) ρ(τ), and 3F2(1/2,1/4,3/4;1,1; t4(τ)) is the Dwork period.
- Numbers compared in the same units (tools660/t4check.out, double precision):
  - t4(3i/√2) gives 1/t4 = +2401.000000. AMNT row "1/7^4 | 3i/√2". The pipeline seat's rho.out: ρ(3i/√2) = 1/2401. All three agree.
  - t4((1+√3 i)/2) = -1.777777777778. AMNT row "-16/9 | (1+√3 i)/2". This agrees with PRIOR-ART-736-QM's corrected value.
  - Controls: t4(i/√2) = 1 (AMNT row 1); t4(i√6/2) = 1/9 (AMNT row 1/9); t4((1+3i)/2) = -1/48 (DPVZ).
  - t4(i√10/2) = 1/81 (the Mukai 800 member), but this value is *absent* from AMNT Table 3(B), even though the table says it "collects all rational CM-values" (see Loose ends).
- T = [4,0,72] gives x^2 + 18y^2, disc -72, field Q(√-2). AMNT attaches f8.3.d.a (level 8, CM by Q(√-2), ARGUED from the label) to t = 1/7^4. The fields agree.

### Table 2: verdicts

| item | verdict | best source | label | quoted sentence | locator |
|---|---|---|---|---|---|
| z = ψ^-4 = 1/2401 is a CM value of the Dwork period (Ramanujan) | **TAKEN** (as a hypergeometric/modular value) | Ramanujan 1914 eq. (42), via Zudilin arXiv 0712.1332 and DPVZ arXiv 1906.07384 | OPENED (Zudilin rendered p.7; DPVZ txt) | Zudilin: "Σ (1/2)n(1/4)n(3/4)n / n!^3 (40n + 3) 1/7^{4n} = 49/(3π√3)". DPVZ (6.1): the same series "= 49√3/(9π) ... Here the first equation is from Ramanujan's list [34, eq. (42)]". | 0712.1332 p.7; 1906.07384 §6 p.16 (txt l.1462-1514) |
| Dictionary: this hypergeometric is the Fermat-Dwork pencil, z = ψ^-4, CM values give Picard rank 20 | **TAKEN** | DPVZ 1906.07384; Ahmed-Ruehle 2304.00027 | OPENED | DPVZ: "the HGM of rank 3 with parameters α = {1/2, 1/4, 3/4} and β = {1, 1, 1} corresponds to the Fermat-Dwork pencil of quartic K3 surfaces of generic Picard rank 19 defined by the equation (1.4) Xψ : x0^4 + x1^4 + x2^4 + x3^4 = 4ψ x0x1x2x3" and "Ramanujan's and Ramanujan-type formulas for 1/π corresponding to rational values of z are tabulated in [6, Tables 3-6]". Ahmed-Ruehle: "the rank of the Picard lattice is enhanced to 20 over a dense set of countably many points" (earlier gate). | 1906.07384 p.2 (l.66-110), p.4 (l.329-331); 2304.00027 p.14 |
| The CM point τ = 3i/√2 with t4 = 1/7^4 and its weight-3 CM form | **TAKEN** (no K3) | Arora-Mondal-Nakagawa-Tu, "Special L-values of certain CM weight three Hecke eigenforms", arXiv 2601.07030v2 (2026-02-25) | OPENED (rendered p.28, p.20) | Table 3(B) d = 4 row: "1/7^4 | 3i/√2 | f8.3.d.a | 56/3"; §6.2: "Table 3 and Table 4 collects all rational CM-values of the hauptmodul td for d = 3, 4, and 6". Thm 5.2: "L(f8, 2) = (π^2/24) 3F2[1/2 1/4 3/4; 1 1; 1] = (3π^2/56) 3F2[1/2 1/4 3/4; 1 1; 1/2401]". The paper never mentions the Dwork or Fermat quartic (grep: no "Dwork" except Griffiths-Dwork and a reference, no "Fermat", no "quartic"). | 2601.07030 Table 3(B) p.28; Thm 5.2 p.20; Table 2 p.13 |
| Σx^4 + 28xyzw (ψ^4 = 2401) stated as a K3 with Picard number 20 / T = [4,0,72] | **PARTIAL** (one published dictionary step; not stated) | DPVZ + AMNT/Ramanujan (above) | - | No source found that writes the quartic or calls this member singular or Picard-20. Searched: Ahmed-Ruehle, Fu 2609.36045, DPVZ, Elkies-Schutt 0809.0830 (its "2401" hit, p.24, is an unrelated elliptic K3 with disc -1435), Brandhorst-Hashimoto, the DPVZ citers (20, every title read; 2601.07030, 2602.04128 and 2607.19427 opened), Ahmed-Ruehle's citers on INSPIRE (16, physics), INSPIRE fulltext "2401" AND "Dwork" (9, titles irrelevant), fulltext "28xyzw" 0, Zenodo, web. | QUERIES-660-640.log |
| The 640-conic quartic is a Dwork (4^2A4) member | **TAKEN** (Degtyarev) | Degtyarev arXiv 2407.00493v2 Addendum 1.4; 2108.11181 Table 6 | OPENED (earlier gates) | "The closure of this family contains quartics (1) and (2) in Theorem 1.1, as well as the Barth-Bauer quartic with 640 conics, see [10] and (5.15)." | 2407.00493 l.138-143 |
| Which member: the 640-conic quartic = ψ^4 = 2401 = τ = 3i/√2 | **OPEN** (search floor) | closest: Degtyarev (family), AMNT (value) | - | No source joins them. "640 conics" gives 0 on arXiv API/search, Zenodo, OpenAlex and INSPIRE. Degtyarev's other "640 conics" is X'60 (field Q(√-15)), already excluded by the pipeline seat. | QUERIES-660-640.log |
| Candelas et al. / attractor literature on this point | not covering | Ahmed-Ruehle (earlier gate), INSPIRE refersto:recid:2648263 (16 citers, titles read) | title | flux vacua, metrics, Yukawas, distance conjecture; none lists ψ^4 = 2401 | QUERIES-660-640.log |

## Part 2. arXiv re-run for PRIOR-ART-736-QM

- The arXiv export API returned HTTP 429 for the first probe of this seat and HTTP 200 later. tools660/api660.sh re-ran the 20 query strings of tools/arxiv_batch_736qm.sh verbatim (pacing about 3 s), plus 11 new ones. The arXiv HTML search (arxiv.org/search) ran the same intents earlier in the seat.
- Results (arXiv API; same numbers on HTML search where both ran):
  - Controls: `all:"Dwork pencil"` 5; `ti:"Shimura curve"` 137; `ti:"S5-action"` 1.
  - 736: `all:"736 conics"` 0; `abs:Dwork AND abs:conics` 0; `abs:"Fermat quartic" AND abs:conics` 0; `abs:Dwork AND abs:K3 AND abs:"transcendental lattice"` 0; `"Fermat-Dwork" OR "Dwork family" AND "Picard number 20"` 0; `abs:quartic AND abs:"singular K3" AND abs:Dwork` 1 (2211.09801, machine-learned CY metrics; not relevant).
  - Quaternion vein: `K3 AND "quaternionic multiplication"` 3 (2504.08270 Kuga-Satake for Picard rank 14; 1906.10157 RM Hodge structures; 1504.07498 Nagano, icosahedral invariants and Shimura curves: a different rank-18 family whose Hilbert modular surface is for Q(√5); opened by grep, no quartic S5 pencil, no octahedral family); `K3 AND "Shimura curves" AND "Picard number 18"` 0; `K3 AND "Shimura surface"` 0; `K3 AND "quaternion algebra"` 3 (Brauer-Manin, Enriques sheaves, Elkies 0802.1301 already gated); `K3 AND anisotropic AND transcendental` 0; `octahedral AND quartic AND K3` 0; `Goursat AND quartic` 3 (integration, Ramanujan level-3 series, unbendable curves); `"product of Shimura curves"` 4 (number theory); `Shimura AND K3 AND "rank 18"` 0.
  - Authors: `au:Elkies AND abs:K3` 7, newest 2608.25406 (Mordell-Weil rank 17; not relevant). `au:Degtyarev AND abs:conics` 5, newest 2407.00493 (no new paper). `au:Naskrecki` 27, newest 2610.02500. The only new conic-adjacent item is 2607.07898 "A (24_4,32_3)-configuration on the Schur quartic" (title only; Schur quartic, 720 conics, not a target).
  - Extra: "Shimura curves of discriminant 14 and 15 and associated Heun functions" 2608.14495 (2026) concerns abelian surfaces; grep finds no "K3" or "quartic".
- **Effect on PRIOR-ART-736-QM verdicts.**
  - 736 member: **PARTIAL, unchanged in level.** New fact from the citation trail (OpenAlex citers of DPVZ): Arora-Mondal-Nakagawa-Tu 2601.07030 print "t4((1+τD)/2) = -16/9" (Thm 5.2 proof, p.20) and the Table 3(B) row "-16/9 | (1+√3 i)/2 | f12.3.c.a | 12". Their t4 is Ahmed-Ruehle's ρ. So the correct parameter value of the 736 member is in print (as a CM value of the hauptmodul), and the misprint finding against 2304.00027 is independently confirmed. The ledger line should cite 2601.07030 as well. Still no source names a K3, conics or T = [12,0,16] at this point.
  - Quaternion disc-6 / compact moduli of the octahedral family: **PARTIAL, unchanged.** No arXiv abstract hit on anisotropic rank-4 T, Shimura surfaces from K3 families, or the octahedral/Goursat family.

## Search floor

- arXiv API (controls 5 / 137 / 1) and arXiv HTML search (controls `"Dwork pencil"` 5, `conics quartic surfaces` abstract 42, `"Shimura curve"` title 137, `period map K3 family S5-action` title 1, `quartic surfaces icosahedral symmetry` title 1): 660/640 queries `"660 conics"` 0, `"640 conics"` 0, `K3 S5-action quartic` 1 (Hashimoto), `S5-invariant quartic` 1 (1605.08720), `icosahedral quartic surface` 2, `A5-invariant quartic` 0, `"symmetric quartic" K3` 0, `Hashimoto pencil` 0, `K3 Picard 20 S5 quartic` 0, `Dwork Ramanujan` 3 (vector fields, Rankin-Cohen, q-supercongruences), `Ramanujan Dwork quartic` 0, `"Fermat-Dwork"` 0, `singular K3 Dwork quartic CM` 0, `"mirror quartic" CM` 1 (Fu 2609.36045), `"attractor points" K3 quartic` 1 (Ahmed-Ruehle), `hypergeometric-modularity` 207 (top 20 read; 2601.07030, 2607.25173, 2607.19427 checked).
- Instrument faults (recorded in the log): `au:Hashimoto_K AND abs:K3` (API) and `Hashimoto S5 K3` (HTML search, all fields) both returned 0 although 0904.0072 exists. Author-field and hyphen-token forms are unreliable, so neither zero is used as evidence. The hyphen issue also means `"Fermat-Dwork"` = 0 is weak; DPVZ was found by citation trail instead.
- Zenodo (curl; controls `"K3 surface"` 110, `"K3 surfaces" AND "Picard"` 41): `"660 conics"` 0, `"640 conics"` 0, `"S5" AND "quartic" AND "K3"` 0, `"Dwork" AND "2401"` 2 (unrelated), `"Ramanujan" AND "Dwork"` 5 (supercongruence preprints; none on quartic K3 members), `"Shimura curve" AND "quartic"` 0, `"icosahedral" AND "quartic" AND "K3"` 0, `"symmetric quartic" AND "K3"` 0, `"Hashimoto" AND "quartic" AND "K3"` 0, `"Fermat quartic" AND "Picard number 20"` 0. The Python client failed TLS verification for zenodo.org; those attempts are not logged as counts.
- OpenAlex (control `"conics" AND "quartic surfaces"` 39): `"660 conics"` 0, `"640 conics"` 0, `"S5" AND "quartic" AND "K3"` 2 (physics), `"A5" AND "quartic" AND "K3"` 0, `"Dwork" AND "Ramanujan"` 6 (supercongruences), `"Fermat quartic" AND "Ramanujan"` 0, `"icosahedral" AND "quartic surface"` 1 (Dolgachev), `"Shimura curve" AND "quartic"` 2 (dessins; Klein quartic). Citers: Hashimoto 12; Dolgachev 10; DPVZ 20.
- INSPIRE (controls `fulltext:"Dwork pencil"` 23, `t:"attractor points"` 4): `refersto:recid:2648263` 16; `fulltext:"2401" and fulltext:"Dwork"` 9; `fulltext:"28xyzw"` 0; `fulltext:"640 conics"` 0; `fulltext:"660 conics"` 0; `fulltext:"736 conics"` 0; `fulltext:"Hashimoto pencil"` 0; `fulltext:"S5-action" and fulltext:"quartic"` 30 (AdS5×S5 noise); `fulltext:"-16/9" and fulltext:"Dwork"` 8 (quintic/physics). Totals are plausible (no runaway OR query).
- Web search engine, 5 queries: Ramanujan (40n+3)/49^{2n}; "28xyzw" K3 Picard; A5-invariant pencil Picard 20 (this one led to Dolgachev 1604.02567 and Cheltsov-Shramov 1511.07508); "Hashimoto pencil" Picard 20; symmetric quartic σ1 = 0 Q(√-15). No source for t = ±1/6 or ψ^4 = 2401 as a K3.

## Most dangerous neighbours

- **X640 and X736 (and every rational CM Dwork member):** the hypergeometric-modularity group (Fang-Ting Tu, Ling Long and coauthors; 2601.07030, 2607.25173). They already tabulate the rational CM values of t4, with their weight-3 newforms, and cite "hypergeometric type K3 surfaces". One sentence connecting their Table 3(B) to the Dwork quartic (via DPVZ (1.4)) would publish the Picard-20 members. Counting conics is not their style.
- **X660:** Hashimoto (with Brandhorst), and Dolgachev, Mukai and van Geemen. Dolgachev's open questions ask for the transcendental lattices in the Hashimoto pencil. Hashimoto's Thm 7.8 plus a CM point of discriminant -60 on X(15,2) would give t = 1/6 directly. Nobody shows signs of doing this.
- **The configuration side:** Degtyarev holds (5.13) and (5.15) as lattices, and never publishes equations.

## Methods worth borrowing

- **Hashimoto's Thm 7.8 is a closed-form certificate for X660.** Evaluate the theta-constant formula at the discriminant -60 CM point of the Shimura curve X(15,2) and check that t1/t0 = 1/6. Our ht_cm.py already reproduces a known fibre (p4 → t = -1/2, the Q(√-15) 10-nodal member with T = [4,1,1,4]) as a positive control. Locating the disc -60 point on Hashimoto's domain needs his Section 5 order (UNTESTED).
- **AMNT Table 3(B) is a ready-made list of rational Picard-20 Dwork members** (via DPVZ's z = ψ^-4): t = -256/(3^4 7^2), 1, 1/7^4, -16/9, 32/81, 1/9, -1/324, 1/9801, -1/25920, -1/777924, 1/96059601, each with τ and a weight-3 CM newform. For our lab, each is a quartic over Q with a predicted conic count from Degtyarev's 4^2A4 rows: the 736 (-16/9) and 640 (1/7^4) are two of them. UNTESTED curiosity: which other rows carry record conic counts?
- Dolgachev's sign convention and named members (S_{1/2}, S_{7/30}, Maschke at (3/20)(3 - i)) give extra controls for any conic count on the Hashimoto pencil. For example, the Maschke member should give the 800 configuration in another polarisation, or a different count (UNTESTED).

## The gap that is genuinely open

- No source identifies the Hashimoto-pencil member t = (6 : 1) (2σ2^2 = 3σ4 on σ1 = 0) as a Picard-20 / Q(√-15) / T = [4,0,60] surface or as Degtyarev's 660-conic quartic.
- No source writes Σx^4 + 28xyzw (ψ^4 = 2401) as a K3 surface of Picard number 20 with T = [4,0,72], or as the 640-conic quartic. Its parameter is published only as Ramanujan's hypergeometric CM value.

## Loose ends

- Dolgachev Thm 1 and Hashimoto Thm 4.15 pair the lattices [4,0,0,10] and [4,1,1,4] with the 15-nodal and 10-nodal members in opposite ways. The text layers were read, and Dolgachev p.5 was not rendered for that line. Our ht_cm.py result (the Q(√-15) CM point maps to t = -1/2) supports Hashimoto's pairing ([4,1,1,4] at the 10-nodal t2). Not settled. It does not affect any verdict.
- Hashimoto says Smith "treats the Picard-Fuchs equation for this K3 family", while Smith's projective pencil (family XIV) is, by Dolgachev's two-pencil statement and Smith's symplectic-S5 jump, the 2.A5 pencil. Both statements can hold if the two pencils share one lattice-polarised moduli curve. Not checked.
- AMNT Table 3(B) claims to collect all rational CM values of t4 but omits 1/81, although t4(i√10/2) = 1/81 (our double-precision check; also the pipeline seat's 60-digit rho.out). It may be a selection rule we did not read, or an omission. It matters only as a caution against reading their table as exhaustive.
- Hashimoto's Appendix points p1, p3 and p6-p8 were not evaluated: their text layer is garbled, and their fields (Q(√-3), Q(√-7), Q(√-22), Q(√-30), Q(√-10)) cannot carry T = [4,0,60] anyway.
- Chan-Cooper (Math. Proc. Cambridge Philos. Soc., "Rational analogues of Ramanujan's series for 1/π", Tables 3-6, cited by DPVZ) and Ramanujan 1914 were not opened (the 1914 series is quoted through Zudilin and DPVZ). DOI not retrieved this seat.
- Cheltsov-Przyjalkowski-Shramov "Quartic double solids with icosahedral symmetry" (EJM 2016, DOI 10.1007/s40879-015-0086-9) and the Cheltsov-Shramov icosahedron book chapters were seen only as titles or snippets. Per Dolgachev they treat the 2.A5 pencil and the threefold side.
- Yui's survey "Modularity of Calabi-Yau varieties: 2011 and beyond" (Fields Inst. Commun. 67, DOI 10.1007/978-1-4614-6403-7_4) cites Hashimoto. It was seen at title level only.
- Google Scholar was not queried.

## Ledger lines

GATE S5 pencil p4 + L p2^2 on sigma1=0 (Hashimoto pencil) TAKEN source=arXiv:0904.0072 (+arXiv:1604.02567)
GATE X660 = Hashimoto-pencil member t=(6:1) as Picard-20 / Q(sqrt-15) / T=[4,0,60] / 660-conic quartic OPEN source=arXiv:0904.0072 (+arXiv:1604.02567, arXiv:2407.00493)
GATE X640 = Dwork member psi^4=2401 (sum x^4 + 28xyzw) as Picard-20 K3: value published only as Ramanujan CM value, K3 statement absent PARTIAL source=arXiv:2601.07030 (+arXiv:1906.07384, arXiv:0712.1332)
GATE 640-conic quartic identified with the Dwork member psi^4=2401 / tau=3i/sqrt2 OPEN source=arXiv:2407.00493 (+arXiv:2601.07030)
GATE 736 member (re-run): correct value t4=-16/9 at tau=(1+sqrt-3)/2 now in print (AMNT Table 3(B)), still no K3/conics/T PARTIAL source=arXiv:2601.07030 (+arXiv:2304.00027)
GATE quaternion disc-6 compact moduli of the octahedral family (arXiv re-run, no change) PARTIAL source=arXiv:0705.3658

```
python tools/memcap.py 1 python tools/lab.py gate  "S5-invariant pencil p4 + L p2^2 on sigma1=0 in P4 (the Hashimoto pencil) is published" TAKEN --file gate/PRIOR-ART-660-640.md --source "arXiv:0904.0072" --queries gate/QUERIES-660-640.log
python tools/memcap.py 1 python tools/lab.py gate  "X660 = Hashimoto-pencil member t=(6:1) (2 sigma2^2 = 3 sigma4 on sigma1=0) as Picard-20 / Q(sqrt-15) / T=[4,0,60] / 660-conic quartic (5.13)" OPEN --file gate/PRIOR-ART-660-640.md --source "arXiv:0904.0072" --queries gate/QUERIES-660-640.log
python tools/memcap.py 1 python tools/lab.py gate  "X640 = Dwork member psi^4=2401 (sum x^4 + 28xyzw) as a Picard-20 K3: z=1/7^4 published only as Ramanujan/hauptmodul CM value (tau=3i/sqrt2), K3 statement absent" PARTIAL --file gate/PRIOR-ART-660-640.md --source "arXiv:2601.07030" --queries gate/QUERIES-660-640.log
python tools/memcap.py 1 python tools/lab.py gate  "640-conic Barth-Bauer quartic (5.15) identified as the Dwork member psi^4=2401 / tau=3i/sqrt2" OPEN --file gate/PRIOR-ART-660-640.md --source "arXiv:2407.00493" --queries gate/QUERIES-660-640.log
python tools/memcap.py 1 python tools/lab.py gate  "736-conic quartic = Dwork member psi^-4=-16/9 (tau=(1+sqrt-3)/2): correct value now in print as CM value t4 (AMNT 2601.07030 Table 3(B)); no K3/conics/T=[12,0,16] anywhere (arXiv re-run)" PARTIAL --file gate/PRIOR-ART-660-640.md --source "arXiv:2601.07030" --queries gate/QUERIES-660-640.log
python tools/memcap.py 1 python tools/lab.py gate  "Goursat octahedral family: disc-6 quaternionic compact moduli (arXiv re-run, unchanged)" PARTIAL --file gate/PRIOR-ART-660-640.md --source "arXiv:0705.3658" --queries gate/QUERIES-660-640.log
```

Written with AI assistance.
