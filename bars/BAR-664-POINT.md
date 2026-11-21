# BAR-664-POINT: the pipeline's 664 candidate carries 664 conics

Raid: RAID-664 (SCOPE-664.md). Written and sealed by the lead before any scored count.

## Disclosed before sealing
- Candidate (r664/REPORT-664-1.md, pipeline seat): X664 : x^4+y^4+z^4+w^4 - (x^2y^2+x^2z^2+x^2w^2+y^2z^2+y^2w^2+z^2w^2) + c xyzw = 0 with c^2 = -45, in the 2-parameter family F(a:b:c) = a sum x_i^4 + b sum x_i^2 x_j^2 + c xyzw (symmetry (even sign changes) x| S4, order 96).
- DEV counts already seen by the seat (lead re-read the .lead files): 664 at p = 65521 (2 charts), 40009, 32003 (our counter, vdim with multiplicity); generic member 464; member (1:-1:7) on the line b = -a: 472; other line members 640, 528, 496, 504. Smooth: EXACT (Singular over Q(s), s^2 = -45).
- Fresh primes for scoring (gp, before sealing): p = 20023 (c = 2924), 20047 (c = 1889), 20063 (c = 2208); never used by any seat.

## Predictions
- **R1 (target, independent counter, distinct).** The referee's Singular counter (referee/rcount.sing via referee/mk.sh, code independent of build/conic_count.py) at p = 20023, c = 2924, seed 801, DOLEX = 1: vdim 664 and distinct 664.
- **R2 (target, second prime, our counter).** r664/count_pipeline.sh kind abcde (A = 1, B = C = D = -1/2, E = c/4) at p = 20047, c = 1889, seed 802: vdim 664.
- **R3 (target, third prime, independent counter).** referee counter at p = 20063, c = 2208, seed 803, DOLEX = 0: vdim 664.
- **R4 (control, generic member).** our counter at the member (a:b:c) = (1 : 1/3 : 5) (A = 1, B = C = D = 1/6, E = 5/4), p = 20023, seed 804: 464.
- **R5 (control, NL_8 line).** our counter at (1 : -1 : 5) (A = 1, B = C = D = -1/2, E = 5/4), p = 20023, seed 805: 472.

## Verdict
HOLD if R1-R5 all pass. FAILED otherwise; no goalposts move.

## Not claimed
Reality of conics on the real form; exactness; T = [4,0,60] at the point; novelty (Barth-Bauer 1994 / Bauer 1995 not opened).

## Seal fields
- formula_ref: r664/conic_count.py:55-57, referee/rcount.sing:1-6, referee/mk.sh:1-4
- calibrated_on: d9712307b9
- depends_on: d9712307b9
- null_not_symmetry: R4 and R5 are different members of the family where the lattice predicts 464 and 472, not relabellings of the target
- target_form: exact integers 664, 664, 664, 464, 472
- parameters: primes 20023, 20047, 20063; seeds 801-805; c = 2924, 1889, 2208 (roots of c^2 = -45 mod p)
- instruments: referee/rcount.sing, referee/mk.sh, r664/conic_count.py, r664/count_pipeline.sh
- tolerances: none - exact counts
- ceiling: exact counts; nothing to approach
- toy_model: Mukai 800 and the 656 family's 392 through the same engines (d9712307b9; referee runs)
