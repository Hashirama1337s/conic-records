# BAR-656-COUNT: the conic counter, calibrated before it touches the target

Raid: RAID-656 (SCOPE.md). Design: design/DESIGN-656.md nodes C0, C1, F2 and PLAN-656.md step 5. Written and sealed by the lead before any build seat runs this step.

## Disclosed before sealing
- The design seat already ran the counter: random quartic 0 conics (msolve, GF(p)); a generic member of F(e,t) gave 384 and 376 with small-integer charts, against the lattice prediction 392. So prediction P3 is known to have FAILED with that chart choice; this bar tests the repaired instrument.
- 392 comes from the lattice (design node G3: conics in the rank-18 sublattice orthogonal to the Sp-invariants other than h), computed by the design seat and re-derivable by grp3.gp. The lead independently confirmed |O_h| = 96, |Sym| = 48, |Sp| = 24 (design/probe/lead_grp.gp), not the 392 split.

## Object
A conic counter: given a quartic F over Q, count the planes P and conics Q with F|_P = Q * Q' (Q, Q' conics), i.e. the number of conics on X = {F = 0}, modulo a prime p, counting each conic once.

## Predictions
- **P1 (negative control).** A random quartic with small random integer coefficients: 0 conics.
- **P2 (positive control).** The Mukai quartic z0^4 + z1^4 + z2^4 + z3^4 + 12 z0 z1 z2 z3: 800 conics (CITED: arXiv 2102.08163v2 p.1, opened by the design seat).
- **P3 (family, generic).** F(e,t) = w^4 + e q w^2 + q^2 + t p4 (q = x^2+y^2+z^2, p4 = x^4+y^4+z^4) at two random rational (e,t) off the discriminant: 392 conics at each.
- **P4 (planes through P).** On the same two members, planes through P = (0:0:0:1) that split into two conics: 28 planes, 56 conics.
- **P5 (agreement).** For one P3 member, two independent charts (different random coordinate changes) give the same count, and a Singular vdim(std) over GF(32003) of one chart agrees with msolve after removing multiplicity (or the multiplicity is explained).

## Verdict
HOLD if P1, P2, P3 (both members), P4 and P5 all pass. FAILED otherwise; on FAILED the instrument is debugged before any Phase C step (doctrine: suspect the instrument first). No goalposts move: 392 and 800 are fixed here.

## Not claimed
Nothing about the 656 surface itself; this bar only calibrates the counter.

## Seal fields
- formula_ref: design/DESIGN-656.md:61-63, design/probe/grp3.gp:36, design/src800/2102.08163v2.txt:35-38
- calibrated_on: none - first calibration of this instrument; thresholds are exact integers fixed by the lattice and a published count
- depends_on: none - no settled bar underlies this one
- null_not_symmetry: the random quartic changes the answer from hundreds to 0 (not a relabelling); the Mukai quartic changes the configuration entirely (800, a different lattice)
- target_form: exact integers 0, 800, 392, 392, 28/56
- parameters: (e,t) at two random rational points off the discriminant; charts: at least two random dense coordinate changes; primes: 32003 and one more
- instruments: build/conicsys2.py
- tolerances: none - exact counts
- ceiling: the counts are exact; nothing to approach
- toy_model: P2 (Mukai 800) is the known exact answer through the same engine
