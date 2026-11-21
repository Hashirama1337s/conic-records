# msout_info.py: header degree D and degree of the eliminating polynomial (distinct solutions) from msolve -P 0 output
import sys, ast
for fn in sys.argv[1:]:
    s = open(fn).read().strip().rstrip(':')
    try:
        L = ast.literal_eval(s)
    except Exception as ex:
        print(fn, "unparsed", str(ex)[:60]); continue
    if L == [-1]:
        print(fn, "no solutions"); continue
    p, nv, D = L[1][0], L[1][1], L[1][2]
    elim = L[1][5][1][0]          # [deg, coeffs]
    print(fn, "p", p, "nvars", nv, "header degree", D, "elim degree", elim[0], "(coeff list length %d)" % len(elim[1]))
