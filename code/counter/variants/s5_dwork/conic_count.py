# conic_count.py  v2 (BUILD seat, RAID-656). Repaired conic counter, started from design/probe/conicsys2.py.
#
# Counts conics on a quartic surface X = {F = 0} over the algebraic closure of GF(p):
# the number of (plane P, conic Q) with Q | F|_P, each conic counted once (line pairs included,
# so on a surface with lines the count includes reducible conics = pairs of coplanar lines).
#
# Chart:
#   * T in GL4(GF(p)) uniformly random (dense); X-coordinates = T * Z; c = T e0 (chart centre), d = T e1.
#     option centre=onX: c is a random GF(p)-point of X (then F|_P has degree 3 in u: smaller system).
#   * planes Z0 = u1 Z1 + u2 Z2 + u3 Z3  (misses exactly the planes through c);
#   * Q1 = Z1^2 + a1 Z1Z2 + a2 Z1Z3 + a3 Z2^2 + a4 Z2Z3 + a5 Z3^2
#     (misses exactly the conics meeting the line <c, d>: the point (1:0:0) of the plane is u1 c + d).
#   Both conditions only depend on (c, d); for generic (c, d) no conic is missed (finitely many conics).
#   A random point c of X is generic for "plane through c" (the conic planes cut X in a curve).
# Formulations:
#   rem : remainder of F|_P mod Q1 in Z1 -> 9 equations, 8 unknowns (u, a)   [as conicsys2.py]
#   bil : F|_P = Q1 * Q2 coefficientwise -> 15 equations, 14 unknowns (u, a, b), bilinear in (a, b)
# Output: <outbase>.ms (msolve) and <outbase>.sing (Singular std + vdim, counts WITH multiplicity).
#
# usage: conic_count.py <kind> <p> <seed> <outbase> [form=rem|bil] [centre=random|onX] [params...]
#   kind = family e t | mukai | random | y56 | fermat   (e, t integers or a/b rationals, reduced mod p)
import sys, random, sympy as sp
from fractions import Fraction

kind, p, seed, outbase = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
opts = {k: v for k, v in (s.split('=', 1) for s in sys.argv[5:] if '=' in s)}
args = [s for s in sys.argv[5:] if '=' not in s]
form = opts.get('form', 'rem'); centre = opts.get('centre', 'random')
rng = random.Random(seed)

def modp(s):
    f = Fraction(s)
    return f.numerator * pow(f.denominator, -1, p) % p

def sqrtmod(a):
    a %= p
    for r in range(p):
        if r * r % p == a:
            return r
    raise ValueError("no sqrt of %d mod %d" % (a, p))

X = sp.symbols('X0:4')
x, y, z, w = X
if kind == 'family':           # F(e,t) = w^4 + e q w^2 + q^2 + t p4
    e, t = modp(args[0]), modp(args[1])
    q = x**2 + y**2 + z**2; p4 = x**4 + y**4 + z**4
    F = w**4 + e*q*w**2 + q**2 + t*p4
elif kind == 'heis':           # Heisenberg-invariant quartic sum u_i t_i (Eklund 1010.4058 sec 2.3), u_i rationals mod p
    u = [modp(a) for a in args[:6]]
    g0 = x**4 + y**4 + z**4 + w**4; g1 = 2*(x**2*y**2 + z**2*w**2); g2 = 2*(x**2*z**2 + y**2*w**2)
    g3 = 2*(x**2*w**2 + y**2*z**2); g4 = 4*x*y*z*w
    th = pow(3, -1, p)
    T = [th*g0 - g1 - g2 - g3, th*g0 - g1 + g2 + g3, th*g0 + g1 - g2 + g3, th*g0 + g1 + g2 - g3, -2*th*g0 + 2*g4, -2*th*g0 - 2*g4]
    F = sum(ui * ti for ui, ti in zip(u, T))
elif kind == 'abcde':          # A g0 + B g1 + C g2 + D g3 + E g4, values given mod p
    A, B, C, D, E = [modp(a) for a in args[:5]]
    F = A*(x**4 + y**4 + z**4 + w**4) + B*2*(x**2*y**2 + z**2*w**2) + C*2*(x**2*z**2 + y**2*w**2) + D*2*(x**2*w**2 + y**2*z**2) + E*4*x*y*z*w
elif kind == 's5':             # S5 pencil (r660): p4 + L*p2^2 on sigma1 = 0 in P4, x5 = -(x+y+z+w); L mod p
    L = modp(args[0]); x5 = -(x + y + z + w)
    F = x**4 + y**4 + z**4 + w**4 + x5**4 + L*(x**2 + y**2 + z**2 + w**2 + x5**2)**2
elif kind == 's5ab':           # a*p4 + b*p2^2 on sigma1 = 0 (homogeneous parameters, values mod p)
    A_, B_ = modp(args[0]), modp(args[1]); x5 = -(x + y + z + w)
    F = A_*(x**4 + y**4 + z**4 + w**4 + x5**4) + B_*(x**2 + y**2 + z**2 + w**2 + x5**2)**2
elif kind == 'dwork':          # x^4+y^4+z^4+w^4 + mu*xyzw (mu mod p)
    MU = modp(args[0]); F = x**4 + y**4 + z**4 + w**4 + MU*x*y*z*w
elif kind == 'mukai':         # 800 conics (CITED 2102.08163v2 p.1) -- sealed case, DEV timing only
    F = x**4 + y**4 + z**4 + w**4 + 12*x*y*z*w
elif kind == 'fermat':
    F = x**4 + y**4 + z**4 + w**4
elif kind == 'y56':            # Y56, e = sqrt 2 (needs p = +-1 mod 8): 636 conics, 448 of them line pairs
    s2 = sqrtmod(2)
    z0, z1, z2, z3 = X
    F = (3*s2*z0**2*z1*z2 + 3*s2*z1*z2*z3**2 - s2*z1**3*z2 - s2*z1*z2**3
         + 4*z0**3*z3 - 4*z0*z3**3)
elif kind == 'random':
    mons = [m for m in sp.itermonomials(X, 4) if sp.Poly(m, *X).total_degree() == 4]
    F = sum(rng.randrange(p) * m for m in mons)
else:
    raise SystemExit("unknown kind")
FP = sp.Poly(F, *X, modulus=p)

def point_on_X():
    lam = sp.Symbol('lam')
    while True:
        P0 = [rng.randrange(p) for _ in range(4)]; V = [rng.randrange(p) for _ in range(4)]
        f = sp.Poly(FP.as_expr().subs({X[i]: P0[i] + lam * V[i] for i in range(4)}, simultaneous=True), lam, modulus=p)
        rts = [r for r in sp.polys.galoistools.gf_factor_sqf(
                   [int(c) % p for c in f.all_coeffs()], p, sp.polys.domains.ZZ)[1] if len(r) == 2]
        if rts:
            r0 = rts[rng.randrange(len(rts))]          # monic linear factor lam + c0
            l0 = (-int(r0[1])) % p
            c = [(P0[i] + l0 * V[i]) % p for i in range(4)]
            assert int(FP.eval(dict(zip(X, c)))) % p == 0 and any(c)
            return c

# chart=dense : T uniformly random.  chart=semi : T = [c | d | two coordinate vectors], c random (or onX),
#   d = the vector given by dvec=i,j,k,l (default (0,0,0,1) = P for the family; must be OFF X so that no conic
#   contains d -- then the line <c,d> misses every conic for generic c). Only c and d matter for completeness.
# chart=fixed : c given by cvec=..., d by dvec=... (used for the deliberate non-generic control).
chart = opts.get('chart', 'dense')
dvec = [int(v) % p for v in opts.get('dvec', '0,0,0,1').split(',')]
if chart in ('semi', 'fixed'):
    assert int(FP.eval(dict(zip(X, dvec)))) % p != 0, "dvec lies on X"
while True:
    T = sp.Matrix(4, 4, lambda i, j: rng.randrange(p))
    if chart in ('semi', 'fixed'):
        cols = [None, dvec]
        if chart == 'fixed':
            cols[0] = [int(v) % p for v in opts['cvec'].split(',')]
        elif centre == 'onX':
            cols[0] = point_on_X()
        else:
            cols[0] = [rng.randrange(p) for _ in range(4)]
        for i in range(4):
            T[i, 0] = cols[0][i]; T[i, 1] = cols[1][i]
        ok = False
        for j1 in range(4):
            for j2 in range(j1 + 1, 4):
                for i in range(4):
                    T[i, 2] = int(i == j1); T[i, 3] = int(i == j2)
                if T.det() % p != 0:
                    ok = True; break
            if ok: break
        if ok: break
        continue
    if centre == 'onX':
        c = point_on_X()
        for i in range(4):
            T[i, 0] = c[i]
    if T.det() % p != 0:
        break
print("chart", chart, "T columns c =", list(T[:, 0]), " d =", list(T[:, 1]))
Z = sp.symbols('z0:4')
u = sp.symbols('u1:4')
a = sp.symbols('a1:6')
b = sp.symbols('b0:6')
pl = [u[0]*Z[1] + u[1]*Z[2] + u[2]*Z[3], Z[1], Z[2], Z[3]]
xx = T * sp.Matrix(pl)
m2 = [Z[1]**2, Z[1]*Z[2], Z[1]*Z[3], Z[2]**2, Z[2]*Z[3], Z[3]**2]
Q1 = m2[0] + sum(ai*mi for ai, mi in zip(a, m2[1:]))
if form == 'rem':
    vars_ = list(u) + list(a)
    gens = (Z[1],) + tuple(vars_) + (Z[2], Z[3])
    Gp = sp.Poly(FP.as_expr().subs(dict(zip(X, list(xx))), simultaneous=True), *gens, modulus=p)
    Qp = sp.Poly(Q1, *gens, modulus=p)
    R = Gp
    while R.degree(Z[1]) >= 2:                     # division in Z1, Q1 monic in Z1
        d = R.degree(Z[1])
        lc = sp.Poly(R.as_expr().coeff(Z[1], d), *gens, modulus=p)
        R = R - lc * Qp * sp.Poly(Z[1]**(d - 2), *gens, modulus=p)
    zi = (0, len(gens) - 2, len(gens) - 1)
else:
    vars_ = list(u) + list(a) + list(b)
    Q2 = sum(bi*mi for bi, mi in zip(b, m2))
    gens = (Z[1],) + tuple(vars_) + (Z[2], Z[3])
    Gp = sp.Poly(FP.as_expr().subs(dict(zip(X, list(xx))), simultaneous=True), *gens, modulus=p)
    R = Gp - sp.Poly(sp.expand(Q1 * Q2), *gens, modulus=p)
    zi = (0, len(gens) - 2, len(gens) - 1)
nv = len(vars_)
groups = {}
for mon, cf in R.terms():                          # group by monomial in (Z1, Z2, Z3)
    key = tuple(mon[i] for i in zi)
    groups.setdefault(key, {})[mon[1:1 + nv]] = int(cf) % p
eqs = []
for key in sorted(groups):
    dct = {m: cf for m, cf in groups[key].items() if cf}
    if dct:
        eqs.append(dct)

def s(dct):
    out = []
    for m, cf in dct.items():
        mon = "*".join(("%s^%d" % (vars_[i], k) if k > 1 else str(vars_[i])) for i, k in enumerate(m) if k)
        out.append(str(cf) + ("*" + mon if mon else ""))
    return "+".join(out)

with open(outbase + '.ms', 'w') as f:
    f.write(",".join(map(str, vars_)) + "\n%d\n" % p)
    f.write(",\n".join(s(cf) for cf in eqs) + "\n")
with open(outbase + '.sing', 'w') as f:
    f.write("ring r = %d, (%s), dp;\n" % (p, ",".join(map(str, vars_))))
    f.write("ideal I =\n" + ",\n".join(s(cf) for cf in eqs) + ";\n")
    f.write("option(redSB);\nideal J = std(I);\nprint(\"dim \" + string(dim(J)));\nprint(\"vdim \" + string(vdim(J)));\nquit;\n")
nterms = sum(len(cf) for cf in eqs)
maxdeg = max(sum(m) for cf in eqs for m in cf)
print("wrote", outbase, "form", form, "centre", centre, "eqs", len(eqs), "vars", nv, "terms", nterms,
      "maxdeg", maxdeg, "kind", kind, "p", p, "args", args)
