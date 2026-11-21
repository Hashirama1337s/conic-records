# Step 6/7: NL1 curve vs the exact discriminant (from disc.sing); parametrised points.
import sympy as sp
s, e, t = sp.symbols('s e t')
disc = [t, t+1, t+2, t+3, e**2-2*t-4, 3*e**2-4*t-12, e**2-4*t-4]
tt = 2*s**2 - 2; ee = 2*s*(3*tt+1)/(tt-1)
print("NL1 param check:", sp.simplify((ee**2*(tt-1)**2 - 2*(tt+2)*(3*tt+1)**2)))
for f in disc:
    v = sp.factor(sp.together(f.subs({e: ee, t: tt})))
    print("factor", f, "on NL1:", v)
nl1 = e**2*(t-1)**2 - 2*(t+2)*(3*t+1)**2
for f in disc:
    if f.has(e):
        print("resultant_e(NL1,", f, ") =", sp.factor(sp.resultant(nl1, f, e)))
for sv in [sp.Rational(3,2), 2]:
    print("s =", sv, " (e,t) =", ee.subs(s, sv), tt.subs(s, sv), " disc values:", [f.subs({e: ee.subs(s, sv), t: tt.subs(s, sv)}) for f in disc])
print("second factor e^2 = 2(t+2) equals discriminant factor e^2-2t-4:", sp.expand(e**2 - 2*(t+2) - (e**2-2*t-4)) == 0)
