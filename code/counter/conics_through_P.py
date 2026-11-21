# conics_through_P.py (BUILD, RAID-656): count conics on F(e,t) lying in planes through P = (0:0:0:1).
# Planes through P = lines in the (x,y,z)-plane. After a random S in GL3(GF(p)) acting on (x,y,z):
#   (x,y,z) = S (Y0, Y1, Y2), plane Y2 = al*Y0 + be*Y1 (misses only lines through the random point S e2).
# In the plane, coordinates (Y0, Y1, w). P is not on X (F(P) = 1), so every conic in such a plane has
# nonzero w^2 coefficient: Q1 = w^2 + a1 w Y0 + a2 w Y1 + a3 Y0^2 + a4 Y0 Y1 + a5 Y1^2 is complete.
# Remainder of F|plane mod Q1 in w -> equations in (al, be, a1..a5): 7 unknowns.
# usage: conics_through_P.py <p> <seed> <out.ms> e t
import sys, random, sympy as sp
from fractions import Fraction
p, seed, out = int(sys.argv[1]), int(sys.argv[2]), sys.argv[3]
def modp(s):
    f = Fraction(s); return f.numerator * pow(f.denominator, -1, p) % p
e, t = modp(sys.argv[4]), modp(sys.argv[5])
rng = random.Random(seed)
x, y, z, w = sp.symbols('x y z w')
q = x**2 + y**2 + z**2; p4 = x**4 + y**4 + z**4
F = w**4 + e*q*w**2 + q**2 + t*p4
while True:
    S = sp.Matrix(3, 3, lambda i, j: rng.randrange(p))
    if S.det() % p: break
Y0, Y1, al, be = sp.symbols('Y0 Y1 al be')
a = sp.symbols('a1:6')
Y2 = al*Y0 + be*Y1
xyz = S * sp.Matrix([Y0, Y1, Y2])
gens = (w,) + (al, be) + tuple(a) + (Y0, Y1)
G = sp.Poly(F.subs({x: xyz[0], y: xyz[1], z: xyz[2]}, simultaneous=True), *gens, modulus=p)
Q1 = sp.Poly(w**2 + a[0]*w*Y0 + a[1]*w*Y1 + a[2]*Y0**2 + a[3]*Y0*Y1 + a[4]*Y1**2, *gens, modulus=p)
R = G
while R.degree(w) >= 2:
    d = R.degree(w)
    lc = sp.Poly(R.as_expr().coeff(w, d), *gens, modulus=p)
    R = R - lc * Q1 * sp.Poly(w**(d - 2), *gens, modulus=p)
vars_ = ['al', 'be'] + [str(v) for v in a]
groups = {}
for mon, cf in R.terms():
    groups.setdefault((mon[0], mon[8], mon[9]), {})[mon[1:8]] = int(cf) % p
def s(dct):
    o = []
    for m, cf in dct.items():
        mon = "*".join(("%s^%d" % (vars_[i], k) if k > 1 else vars_[i]) for i, k in enumerate(m) if k)
        o.append(str(cf) + ("*" + mon if mon else ""))
    return "+".join(o)
eqs = [d for d in (dict((m, c) for m, c in g.items() if c) for g in groups.values()) if d]
with open(out, 'w') as f:
    f.write(",".join(vars_) + "\n%d\n" % p)
    f.write(",\n".join(s(d) for d in eqs) + "\n")
print("wrote", out, "eqs", len(eqs), "e,t =", sys.argv[4], sys.argv[5], "p", p)
