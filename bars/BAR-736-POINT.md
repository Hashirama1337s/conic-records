# BAR-736-POINT: the rational quartic -x^4 + y^4 + z^4 + 9w^4 + 6xyzw carries 736 conics

Raid: hunting round (r736/, pipeline seat). Written and sealed by the lead before any scored count.

## Disclosed before sealing
- Candidate (pipeline seat, r736/REPORT-736-616.md): X736 : -x^4 + y^4 + z^4 + 9 w^4 + 6 xyzw = 0, equivalent over C to the Dwork member x^4+y^4+z^4+w^4 + c xyzw with c^4 = -144 (invariant c^4/(a0a1a2a3)). Configuration (5.10) decoded: |C| = 736, det 192, T = [12,0,16]; Sym 384, Sp 192.
- DEV counts already seen (lead re-read the .lead files): 736 at p 65521 (two roots c), 40009, and the rational form at 32003 and 65497; generic Dwork member 608; Mukai member 800; the gate's quoted psi^-4 = -9/16 gives 608. Smoothness EXACT (Singular over Q: dim 0, vdim 81).

## Predictions
- **D1 (independent counter, distinct).** referee/rcount.sing via referee/mk.sh on F = -x^4+y^4+z^4+9*w^4+6*x*y*z*w at p = 20201, seed 1001, DOLEX = 1: vdim 736 and distinct 736.
- **D2 (independent counter, second prime).** same at p = 20219, seed 1002, DOLEX = 0: vdim 736.
- **D3 (control, generic Dwork member).** referee counter on x^4+y^4+z^4+w^4+5*x*y*z*w at p = 20201, seed 1003, DOLEX = 0: 608.

## Verdict
HOLD if D1-D3 all pass; FAILED otherwise; no goalposts move.

## Not claimed
Exactness; which real structure is Degtyarev's (1,0) member and how many conics are real; novelty (gate PARTIAL earlier; re-gate pending).

## Seal fields
- formula_ref: referee/rcount.sing:1-6, referee/mk.sh:1-4
- calibrated_on: d9712307b9
- depends_on: d9712307b9
- null_not_symmetry: D3 is a different member of the pencil, where the lattice predicts 608, not a relabelling of the target
- target_form: exact integers 736, 736, 608
- parameters: primes 20201, 20219; seeds 1001-1003
- instruments: referee/rcount.sing, referee/mk.sh
- tolerances: none - exact counts
- ceiling: exact counts; nothing to approach
- toy_model: Mukai 800 through the same engine (referee runs)
