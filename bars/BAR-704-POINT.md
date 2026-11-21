# BAR-704-POINT: the NL_A ∩ NL_B ∩ S point of the Goursat family carries 704 conics

Raid: RAID-656 family map (familymap/REPORT-FAMILY1.md). Written and sealed by the lead before any scored count.

## Disclosed before sealing
- The family-map seat found a complex-conjugate pair of points where NL_A, NL_B and Smith's curve S (E(1+t) = 4) meet: 9t^2 + 36t + 52 = 0, E = -(36t+108)/25, in the E-form E w^4 + E q w^2 + q^2 + t p4 (q = x^2+y^2+z^2, p4 = x^4+y^4+z^4). DEV count 704 at p = 32009 (two charts). Lattice match: a rank-20 CM type with 704 classes and det 208 = det [8,4,28], the T of the 704-conic Barth-Bauer quartic in arXiv 2108.11181 Table 6 (equation OPEN per gate/TARGETS-NEXT.md).
- Fresh primes chosen by the lead before sealing (gp): p = 20101 (t = 6804, E = 11907), p = 20113 (t = 2154, E = 112).

## Predictions
- **V1 (target, independent counter, distinct).** referee/rcount.sing via referee/mk.sh with F = E*w^4 + E*(x^2+y^2+z^2)*w^2 + (x^2+y^2+z^2)^2 + t*(x^4+y^4+z^4) at p = 20101, t = 6804, E = 11907, seed 901, DOLEX = 1: vdim 704, distinct 704.
- **V2 (target, second prime, our counter).** familymap/count_f.sh (kind efam) or build/count_pipeline.sh kind efam at p = 20113, E = 112, t = 2154, seed 902: vdim 704.
- **V3 (control, generic point of S).** (E,t) = (2, 1) (on S: E(1+t) = 4, off NL_A and NL_B), our counter at p = 20101, seed 903: 512.

## Verdict
HOLD if V1-V3 all pass; FAILED otherwise; no goalposts move.

## Not claimed
That this member IS the Barth-Bauer 704 quartic (needs the lattice identification at the point, not only det); exactness; novelty.

## Seal fields
- formula_ref: familymap/REPORT-FAMILY1.md:170, referee/rcount.sing:1-6
- calibrated_on: d9712307b9
- depends_on: d9712307b9
- null_not_symmetry: V3 is a different point of the parameter plane where the lattice predicts 512, not a relabelling of the target
- target_form: exact integers 704, 704, 512
- parameters: primes 20101, 20113; seeds 901-903
- instruments: referee/rcount.sing, referee/mk.sh, verify/conic_count_v.py
- tolerances: none - exact counts
- ceiling: exact counts; nothing to approach
- toy_model: Mukai 800 through the same engines (d9712307b9; referee runs)
