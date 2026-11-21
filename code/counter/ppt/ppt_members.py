# ppt_members.py (FAMILYMAP): random members of Pichon-Pharabod--Telen's G-invariant quartic families L4G.
# Source (OPENED): local copy of arXiv 2509.06785.txt
#   action: Sylvester action, l.136-149 (S5 permutes y0..y4 with y0+...+y4 = 0; coordinates [y0:y1:y2:y3];
#           Example 2: (15)(23) acts by x0 -> -x0-x1-x2-x3, x1 <-> x2, x3 fixed, so label k <-> y_{k-1}).
#   generators: Table 2, l.1076-1121.   dims / conic counts: Table 4, l.1535-1575 (certified, Thm 22 l.1497).
# The invariant space is computed here with the Reynolds operator from the printed generators (the quartic bases
# themselves are not printed in the paper; they are in their data repository [39]).
# usage: ppt_members.py <G> <seed> <outfile>
import sys, random, itertools, sympy as sp

GENS = {
    'S5': ['(14532)', '(12)'], 'F5': ['(12345)', '(2354)'], 'S4': ['(1234)', '(12)'], 'D6': ['(123)', '(12)', '(45)'],
    'K4': ['(12)(34)', '(13)(24)'], 'Z2': ['(12)'], 'Z6': ['(123)', '(45)'], 'S3': ['(123)', '(12)'],
}
G, seed, out = sys.argv[1], int(sys.argv[2]), sys.argv[3]
X = sp.symbols('X0:4')
Y = list(X) + [-(X[0] + X[1] + X[2] + X[3])]

def perm(cyc):
    pm = list(range(5))
    for c in cyc.strip('()').split(')('):
        c = [int(ch) - 1 for ch in c]
        for i in range(len(c)):
            pm[c[i]] = c[(i + 1) % len(c)]
    return tuple(pm)

def compose(a, b):
    return tuple(a[b[i]] for i in range(5))

gens = [perm(g) for g in GENS[G]]
grp = {tuple(range(5))}; todo = [tuple(range(5))]
while todo:
    g = todo.pop()
    for h in gens:
        k = compose(h, g)
        if k not in grp:
            grp.add(k); todo.append(k)
grp = list(grp)

def act(f, pm):  # substitute y_k -> y_{pm(k)}
    return sp.expand(f.subs({X[k]: Y[pm[k]] for k in range(4)}, simultaneous=True))

mons = [m for m in sp.itermonomials(X, 4) if sp.Poly(m, *X).total_degree() == 4]
mons = sorted(mons, key=sp.default_sort_key)
rows = []
for m in mons:
    r = sp.Poly(sum(act(m, pm) for pm in grp), *X)
    rows.append([r.coeff_monomial(mm) for mm in mons])
M = sp.Matrix(rows)
basis = M.T.columnspace()
print("G", G, "|G|", len(grp), "dim invariant quartics (vector)", len(basis), "projective", len(basis) - 1)
rng = random.Random(seed)
coef = [rng.randint(-9, 9) or 1 for _ in basis]
vec = sum((c * b for c, b in zip(coef, basis)), sp.zeros(len(mons), 1))
F = sum(vec[i] * mons[i] for i in range(len(mons)))
# invariance check under every group element
assert all(sp.expand(act(F, pm) - F) == 0 for pm in grp)
with open(out, 'w') as fh:
    fh.write("# %s member seed %d coefs %s\n" % (G, seed, coef))
    for i, mm in enumerate(mons):
        if vec[i] != 0:
            d = sp.Poly(mm, *X).monoms()[0]
            fh.write("%d %d %d %d %s\n" % (d[0], d[1], d[2], d[3], vec[i]))
print("terms", sum(1 for v in vec if v != 0), "written", out)
