# mksing.py (EXACT-UB seat): write replay.sing, a Singular replay of the 30 identities F_E|plane = mu*Qrep*Qres
# from exact/exact_conics.txt, INDEPENDENT of PARI: no absolute field / rnfequation / polmods.
# Work in the quotient ring A = Q[s1,s2,u]/(u^3+48u^2+1125u+9882, s1^2-d1(u), s2^2-d2(u)) tensor Q[x,y,z].
# The three generators have pairwise coprime leading terms (s1^2, s2^2, u^3) in lex, so they form a Groebner basis;
# normal form 0 in A[x,y,z] means the identity holds for EVERY choice of the square-root signs and every root u
# (all conjugates), in particular at the real embedding. Basis order (PARI forvec): blocks 1, s2, s1, s1*s2
# (r = 2) or 1, s1 (r = 1), each times t^0, t^1, t^2 with t = u/9.
import itertools, sympy
u = sympy.Symbol("u")
out = []
out.append('option(redSB);')
out.append('int nok = 0; int nbad = 0;')
MON = ["x^2", "x*y", "x*z", "y^2", "y*z", "z^2"]
rows = [sympy.sympify(l.strip().replace("vK", "u")) for l in open("exact_conics.txt") if l.strip()]
for row in rows:
    orb, size, kp, ds, qs = int(row[0]), int(row[1]), int(row[2]), list(row[3]), list(row[4])
    r = len(ds)
    sq = ["s1", "s2"][:r]
    basis = []
    for e in itertools.product([0, 1], repeat=r):
        pr = "*".join(sq[j] for j in range(r) if e[j]) or "1"
        for m in range(3):
            basis.append("(%s)*(u/9)^%d" % (pr, m))
    def val(q):
        terms = []
        for c, b in zip(q, basis):
            c = sympy.Rational(c)
            if c != 0:
                terms.append("(%s)*%s" % (str(c), b))
        return " + ".join(terms) if terms else "0"
    out.append("// orbit %d (size %d, pivot %d, r = %d)" % (orb, size, kp, r))
    out.append("ring R%d = 0,(x,y,z,s1,s2,u),(dp(3),lp(3));" % orb)
    gens = ["u^3+48*u^2+1125*u+9882"]
    for j in range(r):
        gens.append("%s^2 - (%s)" % (sq[j], " + ".join("(%s)*u^%d" % (str(c), k) for (k,), c in sympy.Poly(ds[j], u).terms())))
    out.append("ideal I = " + ", ".join(gens) + ";")
    out.append("ideal GI = std(I);")
    out.append("int okgb = (size(GI) == %d);" % len(gens))
    out.append("poly n1 = %s; poly n2 = %s; poly n3 = %s; poly n4 = %s;" % tuple(val(qs[j]) for j in range(4)))
    out.append("poly Qr = " + " + ".join("(%s)*%s" % (val(qs[4 + j]), MON[j]) for j in range(6)) + ";")
    out.append("poly Qs = " + " + ".join("(%s)*%s" % (val(qs[10 + j]), MON[j]) for j in range(6)) + ";")
    out.append("poly mu = %s;" % val(qs[16]))
    out.append("poly t = u/9; poly E = (1688 - 1140*t - 1044*t^2)/361;")
    # plane coordinates: the three coordinates other than the pivot, in order; pivot coordinate = -sum
    nn = ["n1", "n2", "n3", "n4"]
    keep = [j for j in range(4) if j != kp]
    X = [None] * 4
    for j, var in zip(keep, ["x", "y", "z"]):
        X[j] = var
    X[kp] = "(-(" + " + ".join("%s*%s" % (nn[j], v) for j, v in zip(keep, ["x", "y", "z"])) + "))"
    out.append("int pivok = (reduce(%s - 1, GI) == 0);" % nn[kp])
    out.append("poly X1 = %s; poly X2 = %s; poly X3 = %s; poly X4 = %s;" % tuple(X))
    out.append("poly q = X1^2 + X2^2 + X3^2; poly p4 = X1^4 + X2^4 + X3^4;")
    out.append("poly G = E*X4^4 - E*q*X4^2 + q^2 + t*p4;")
    out.append("poly D = reduce(G - mu*Qr*Qs, GI);")
    out.append('poly Dc = reduce(G - (mu + 1/1000000)*Qr*Qs, GI); if (Dc == 0) { print("orbit %d: CONTROL FAILED (perturbed identity reduced to 0)"); nbad++; }' % orb)
    out.append('if (D == 0 && okgb && pivok) { nok++; print("orbit %d: F_E|plane - mu*Qrep*Qres = 0 in A[x,y,z]: TRUE"); } '
               'else { nbad++; print("orbit %d: FAIL  okgb=" + string(okgb) + " pivok=" + string(pivok) + " terms=" + string(size(D))); }' % (orb, orb))
    out.append("kill R%d; kill okgb; kill pivok;" % orb)
out.append('print("SUMMARY: " + string(nok) + " / %d identities hold, failures " + string(nbad));' % len(rows))
out.append("quit;")
open("replay.sing", "w").write("\n".join(out) + "\n")
print("wrote replay.sing for", len(rows), "orbits")
