# AMENDMENT-656-COUNTa (amends BAR-656-COUNT, seal d9712307b9)

Written by the lead before any scoring run.

## What changes
1. P5's Singular cross-check uses `slimgb` instead of `std`, followed by `vdim`. Both compute a standard basis of the same ideal in the same ordering; vdim is a property of the ideal, not the algorithm. Reason: `std` in dp did not finish in 590 s on the 8-variable system (build seat, REPORT-BUILD1.md section 1), while `slimgb` finished in 178 s on a development member.
2. Instrument named: build/conic_count.py (repaired v2) with the protocol build/count_pipeline.sh, run_msg.sh (msolve -g 1 + vdim_lead.py: count with multiplicity) and run_ms.sh (msolve -P 0 + msout_info.py: distinct count). A count is scored as passed when the distinct count (-P 0) equals the prediction, or when the -g 1 count equals the prediction and -P 0 on one member of the same case confirms radical (distinct = vdim).
3. Scoring points chosen by the lead now, fresh (never run by any seat): P3 members (e,t) = (7/2, 11) and (-9/4, 13/3); random quartic seed 9001; Mukai at p = 32003 (the build seat's DEV timing run used p = 65521); charts seeds 501, 502.

## What does not change
All predicted numbers: 0, 800, 392, 392, 28 planes / 56 conics, and the two-chart + Singular agreement in P5.

## Seal fields
- formula_ref: none - amends the instrument and points only; formulas as in the parent
- calibrated_on: d9712307b9
- depends_on: none - the parent has not settled
- null_not_symmetry: unchanged from the parent (random quartic 0, Mukai 800)
- target_form: exact integers as in the parent
- parameters: (e,t) = (7/2, 11), (-9/4, 13/3); primes 32003, 65521
- instruments: build/conic_count.py, build/conics_through_P.py, build/vdim_lead.py, build/msout_info.py
- tolerances: none - exact counts
- ceiling: exact counts; nothing to approach
- toy_model: Mukai 800 through the same engine (parent P2)
