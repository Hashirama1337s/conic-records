# CORRECTIONS

Moki & Julio (AI-assisted) · version 1.0

## In plain words

This page lists what we got wrong on the way and how each error was caught and fixed, followed by two misprints we found in published papers. None of our own errors survives in the results: each was caught by a control, a second method or a referee before the result it touched was used. We list them because a reader checking our work should know where the traps were.

## Part 1. Our own errors, found and fixed

| # | what was wrong | how it was caught | what it touched | fix |
|---|---|---|---|---|
| 1 | **The design predicted 416 conics on the curve NL1; the true count is 464.** The design counted one class of 24 conditional conics (392 + 24); the lattice shows that the NL1 condition brings in four symmetry orbits at once (12 + 12 + 24 + 24 = 72). | The repaired counter gave 464 at two independent NL1 points; the lattice split explained it exactly. | The design's choice of a second curve: an NL2 built from the other two orbits would only have reproduced NL1. | Second and third curves taken from the two genuinely independent classes, $`\mathrm{NL}_A`$ (+144) and $`\mathrm{NL}_B`$ (+48). |
| 2 | **The counter's chart fault.** The original counter used charts with small integer entries; on a symmetric surface those put the chart centre on special planes, and a generic family member gave 384 and 376 instead of 392. | A deliberate test placed the centre on a known conic plane: the count fell by exactly that plane's 2 conics (390). | The initial development counts only; no sealed count. | Charts drawn uniformly from $`GL_4(\mathbb{F}_p)`$ with the centre at a random point of the surface; then calibrated in a sealed test (BAR-656-COUNT, `HOLD` 5/5). |
| 3 | **A counter output was misread.** The third field of msolve's `-P 0` header is the dimension of the quotient (with multiplicity), not the number of distinct solutions (112 against 34 on a nodal member). | Cross-check with the degree of the eliminating polynomial. | Development runs on a singular member only. | Distinct counts are read from the eliminating polynomial (`msout_info.py`). |
| 4 | **The ball-radius fault (sign of the discriminant).** In the 664 ball-arithmetic Gram, Arb's complex square root of a discriminant ball straddling the negative real axis returned a huge radius, leaving 1,616 entries spuriously undecided. | The undecided count was far above the expected 64 triple-point entries. | The ball Gram of 664 (never the exact Gram). | Take $`i\sqrt{-\mathrm{disc}}`$ when the real part is negative; afterwards only the 64 genuine triple-point entries stayed undecided, and they agree with the exact Gram. |
| 5 | **The referee's stale files.** The referee's saved reality-check outputs for the 656 conics were from an older run on the wrong form (residual $`6\cdot10^{-3}`$). | The lead re-ran the check on the correct form: residual $`6\cdot10^{-58}`$, 656 real conics, all with real points. | The referee report's evidence files only; the verdict stood. | Re-run kept as `code/656/runs/lead_realcheck_e.out`. |
| 6 | **formula_ref slips in a sealed file.** In BAR-656-POINT two `formula_ref` pointers name neighbouring lines of the cited files. | Read-back by the lead right after sealing. | Citation pointers only; no prediction. | Logged; the sealed file is not edited. |
| 7 | **"Only the triple point can reach 656"** (a development report) was too strong. | The FAILED control of BAR-656-POINT (560 instead of 512) and an 800-conic member elsewhere in the family. | Wording only. | Withdrawn; the full eight-curve map (PAPER.md section 7) explains every count tested. |
| 8 | **The sealed control at the rational point was wrong** (512 predicted, 560 found). | The sealed test itself; the bar is reported `FAILED`. | The bookkeeping rule, not the target. | POST HOC explanation: the point is a node of $`\mathrm{NL}_B`$, two branches add 48 each. Kept as FAILED. |
| 9 | **A wording error about $S_4$ in $`\mathrm{PGL}_3`$** ("a unique class") in the design argument. | Referee. | The family derivation's wording. | Replaced by the centraliser argument: the symmetry group acts by a genuine linear 3-dimensional representation, and invariance forces Goursat's family. |
| 10 | **Exact-data key bugs.** (a) Orbit closure for 656 printed zeros of size $10^{-70}$ as different keys; (b) the 736 Gram script mixed integer, fraction and constant-polynomial keys and initially produced 832 "conics" with an impossible orbit of 224; (c) a numerical dedup by largest entry double-counted symmetric conics. | Orbit sizes that did not match the lattice. | Intermediate runs only. | Canonical keys; all final counts reproduce the lattice orbit sizes. |
| 11 | **A stale data file.** One 656 summary was written before a factor $`\mu`$ had been regenerated, so its identity column read 0. | Comparison with the authoritative run. | A superseded summary file (not shipped). | The authoritative transcript is `code/656/recog2_final.out`. |
| 12 | **A label bug.** The 704 transcendental-lattice script prints "[8,8,28]" for the form it tests, which is $[8,4;4,28]$. | Read-back of the script. | A printed label only. | Noted in `code/README.md`. |
| 13 | **An earlier gate misread table rows.** The text layer of Degtyarev's companion tables scrambles columns; our initial gate attached two lattices of 680-conic rows to the 656 rows. | Rendering the page as an image. | A side remark in an earlier gate; its conclusion stood ((5.14) is the only all-real 656). | Corrected in the later gate. |
| 14 | **The initial 664 report called 48 the group order.** 48 is the symplectic part; the full projective group has order 96. | The lattice computation of the same report. | Wording. | Group order 96 throughout. |

## Part 2. Corrections to the literature

Both are `ARGUED`; the full evidence is in PAPER.md section 12.

1. **Ahmed and Ruehle, arXiv 2304.00027, eq. (61), and JHEP 06 (2023) 164, eq. (5.2).** The second CM point $`\tau = (1+\sqrt3 i)/2`$ is printed as "$`\psi^{-4} = -9/16`$"; it should read $`\psi^4 = -9/16`$ ($`\psi^{-4} = -16/9`$). Evidence: their own eta quotient at that point gives $-16/9$ (30 digits); their Figure 7 is drawn at the corrected value; our counter gives 736 conics at the corrected value and the generic 608 at the printed one. Confirmed independently by Arora, Mondal, Nakagawa and Tu (arXiv 2601.07030, p.20 and Table 3(B)), who print $t_4 = -16/9$ for this point. Strength: strong.
2. **Smith, arXiv 0705.3658, §1.3.** The jump of the symplectic automorphism group to M20, printed at $`\lambda = 3/4`$, should likely be at $`\lambda = -3/4`$. Evidence: Bonnafé and Sarti's Mukai form is $`\lambda = -3/4`$ in Smith's normalisation (exact rescaling); at $`\lambda = +3/4`$ our counter finds 512 conics in two charts, the generic count on that curve, not 800. Strength: moderate (one development point, two charts).

Written with AI assistance.
