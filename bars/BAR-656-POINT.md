# BAR-656-POINT: the triple point of the three Noether-Lefschetz curves carries 656 conics

Raid: RAID-656. Written and sealed by the lead before any count at the point. Counter: calibrated in BAR-656-COUNT (d9712307b9, HOLD 5/5).

## Disclosed before sealing
- The math seat (math/, report REPORT-MATH1.md) derived NL_A and NL_B with a symmetric model (completeness ARGUED) and found that NL1, NL_A and NL_B meet off the singular locus in exactly one Galois orbit: 9t^3 + 48t^2 + 125t + 122 = 0, E = e^2 = (1688 - 1140t - 1044t^2)/361. Lead checks (scratchpad lead_point.py and gp): all three curves vanish exactly at the point; the cubic has one real root; nfdisc = -244 (equal to det [2,0,122]); polredabs x^3 + x - 6; the member is smooth (discriminant nonzero at the real point).
- DEV counts by the math seat: 536 on a point of NL_A, 440 on a point of NL_B (one chart each). No count at the triple point or at the two-class points was run by anyone.
- Points mod p (lead, gp, before sealing): p = 40013, t = 37794, e = 18321; p = 40031, t = 18408, e = 12425 (first two primes above 40000 where the cubic has a root and E is a square).

## Predictions
- **Q1 (the target).** The family member F(e,t) = w^4 + e q w^2 + q^2 + t p4 at the triple point carries exactly 656 conics: distinct count 656 at p = 40013 (chart seed 701) and at p = 40031 (chart seed 702).
- **Q2 (second chart).** At p = 40013 a second chart (seed 703) gives 656 (count with multiplicity).
- **Q3 (two-class point, structure null).** The rational member (e, t) = (28/19, -10/9), on NL1 and NL_B but not NL_A, carries 512 = 392 + 72 + 48 conics (distinct count, p = 32003, seed 704). A count of 656 here would mean the 656 is not specific to the triple point.

## Verdict
HOLD if Q1, Q2 and Q3 all pass. Q1 alone failing means the triple point is not the 656 configuration (or the model is incomplete); Q3 failing means the class bookkeeping is wrong. No goalposts move.

## Not claimed
Reality of the conics, which real form (X+ or X-) carries all 656 real conics, T = [2,0,122] at the real point, exact (characteristic 0) counts: later steps (PLAN V2-V5).

## Seal fields
- formula_ref: design/DESIGN-656.md:61-63, build/REPORT-BUILD1.md:96-104, math/exactpts.out:1
- calibrated_on: d9712307b9
- depends_on: d9712307b9
- null_not_symmetry: Q3 moves to a different point of the parameter plane (on two of the three curves), where the predicted count drops to 512; it is not a relabelling of Q1
- target_form: exact integers 656, 656, 656, 512
- parameters: primes 40013, 40031, 32003; chart seeds 701, 702, 703, 704
- instruments: build/conic_count.py, build/vdim_lead.py, build/msout_info.py
- tolerances: none - exact counts
- ceiling: exact counts; nothing to approach
- toy_model: Mukai 800 and the family's 392 through the same engine (d9712307b9)
