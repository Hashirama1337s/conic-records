# arbcert.py (EXACT-UB seat, RAID-656): ball-arithmetic (python-flint arb/acb) replay from exact/exact_conics.txt.
#  (A) real root u of u^3+48u^2+1125u+9882 (u = 9t) isolated by exact rational bisection -> arb ball
#  (B) d_j(u) > 0 certified; all 17 values per orbit as arb balls
#  (C) reality: det != 0, leading-minor signs certified (or minor exactly 0 = all coordinates 0) for all 60 conics
#  (D) 30 x 48 images of the planes, clustered; pairwise certified separation of the cluster representatives
#  (E) CERTIFIED intersection Gram of the 656 conics (one plane per cluster, two conics per plane):
#      C.C = -2, C.C_res = 4 (same plane), else C.C' = sum over clusters of the divisor ell|_C (ell = plane(C) cap plane(C'))
#      of the cluster multiplicity if the cluster is certified OFF C'' (residual of C'), 0 if certified OFF C'.
# Output: arbcert.out (log), gram_cert.gp (656x656 Gram + h vector), conics_cert.json
import sys, json, itertools, time
import sympy
from flint import arb, acb, fmpq, ctx

PREC = int(sys.argv[1]) if len(sys.argv) > 1 else 300
ctx.prec = PREC
t0 = time.time()
log = open("arbcert.out", "w")
def P(*a):
    s = " ".join(str(x) for x in a); print(s); log.write(s + "\n"); log.flush()

u_s = sympy.Symbol("u")
rows = []
for line in open("exact_conics.txt"):
    line = line.strip()
    if not line: continue
    rows.append(sympy.sympify(line.replace("vK", "u")))
P("rows:", len(rows))

# (A) real root of the monic cubic in u; derivative 3u^2+96u+1125 > 0 everywhere (disc < 0) -> unique real root
cub = lambda x: x**3 + 48*x**2 + 1125*x + 9882
lo, hi = fmpq(-17), fmpq(-16)
assert cub(lo) < 0 < cub(hi)
for _ in range(PREC + 40):
    mid = (lo + hi) / 2
    if cub(mid) < 0: lo = mid
    else: hi = mid
U = arb(lo).union(arb(hi))
T = U / 9
P("u in", U.str(30), " t in", T.str(30))

def kval(expr):
    """evaluate an element of K given as a sympy polynomial in u with rational coefficients"""
    pol = sympy.Poly(sympy.sympify(expr), u_s)
    s = arb(0)
    for (k,), c in pol.terms():
        c = sympy.Rational(c)
        s += arb(fmpq(int(c.p), int(c.q))) * U**k
    return s

def qarb(c):
    c = sympy.Rational(c); return arb(fmpq(int(c.p), int(c.q)))

MON = [(0,0),(0,1),(0,2),(1,1),(1,2),(2,2)]   # x^2, xy, xz, y^2, yz, z^2 in plane coords
SYMS = []
for p in itertools.permutations(range(3)):
    for sg in itertools.product([1,-1], repeat=3):
        g = [[0]*4 for _ in range(4)]; g[3][3] = 1
        for i in range(3): g[i][p[i]] = sg[i]
        SYMS.append(g)
assert len(SYMS) == 48

reps = []   # per orbit: dict with plane n (4 arb), zero pattern, conics as 4x4 symmetric arb matrices
minminor = None; mind = None; mindet = None
for row in rows:
    orb, size, kp, ds, qs = int(row[0]), int(row[1]), int(row[2]), list(row[3]), list(row[4])
    r = len(ds)
    assert len(qs) == 17 and all(len(q) == 3 * 2**r for q in qs), orb
    dval = [kval(d) for d in ds]
    for dv in dval:
        assert dv > 0, ("d_j not certified positive", orb)
        mind = dv if mind is None else (dv if dv.mid() < mind.mid() else mind)
    sq = [dv.sqrt() for dv in dval]
    basis = []
    for e in itertools.product([0,1], repeat=r):        # same order as PARI forvec: last coordinate fastest
        pr = arb(1)
        for j in range(r):
            if e[j]: pr *= sq[j]
        for m in range(3): basis.append(T**m * pr)
    def val(q): return sum((qarb(c) * b for c, b in zip(q, basis)), arb(0))
    iszero = [all(sympy.Rational(c) == 0 for c in q) for q in qs]
    v = [val(q) for q in qs]
    kk = kp   # 0-based pivot
    keep = [j for j in range(4) if j != kk]
    assert not iszero[kk] and qs[kk][0] == 1 and all(sympy.Rational(c) == 0 for c in qs[kk][1:]), "pivot coefficient not exactly 1"
    n = v[0:4]
    conics = []
    for c0 in (4, 10):
        cf = v[c0:c0+6]; cz = iszero[c0:c0+6]
        M3 = [[arb(0)]*3 for _ in range(3)]
        for (a, b), c in zip(MON, cf):
            if a == b: M3[a][a] = c
            else: M3[a][b] = c / 2; M3[b][a] = c / 2
        # exact zero pattern of leading minors: m1 = M3[0][0] exact zero iff its coordinate vector is zero
        m1 = M3[0][0]; m2 = M3[0][0]*M3[1][1] - M3[0][1]**2
        m3 = (M3[0][0]*(M3[1][1]*M3[2][2]-M3[1][2]**2) - M3[0][1]*(M3[0][1]*M3[2][2]-M3[1][2]*M3[0][2])
              + M3[0][2]*(M3[0][1]*M3[1][2]-M3[1][1]*M3[0][2]))
        assert m3 != 0 and (m3 > 0 or m3 < 0), ("det not certified nonzero", orb)
        absdet = abs(m3)
        mindet = absdet if mindet is None else (absdet if absdet.mid() < mindet.mid() else mindet)
        if cz[0]:
            status = "m1 exactly 0 -> point (1:0:0) on conic -> real point"
        else:
            assert m1 > 0 or m1 < 0, ("m1 sign", orb)
            if (m2 > 0 or m2 < 0):
                s1 = 1 if m1 > 0 else -1; s2 = 1 if m2 > 0 else -1; s3 = 1 if m3 > 0 else -1
                definite = (s1 > 0 and s2 > 0 and s3 > 0) or (s1 < 0 and s2 > 0 and s3 < 0)
                assert not definite, ("definite conic", orb)
                status = "signs (%d,%d,%d) indefinite" % (s1, s2, s3)
                for mm in (m1, m2, m3):
                    a_ = abs(mm)
                    minminor = a_ if minminor is None else (a_ if a_.mid() < minminor.mid() else minminor)
            else:
                # m2 not sign-certified: m2 = 0 exactly would also mean "not definite"; decide by alternative principal minor
                status = "m2 undecided"
                raise SystemExit("m2 undecided at orbit %d" % orb)
        # 4x4 matrix on P^3: Q(X) = Q3(X_keep)
        A = [[arb(0)]*4 for _ in range(4)]
        for a in range(3):
            for b in range(3): A[keep[a]][keep[b]] = M3[a][b]
        conics.append(A)
        P("orbit", orb, "conic", "rep" if c0 == 4 else "res", "|det| >=", absdet.lower().str(5), status)
    cr, cs = v[4:10], v[10:16]
    nonprop = any(abs(cr[a]*cs[b] - cr[b]*cs[a]) > 0 for a in range(6) for b in range(a+1, 6))
    assert nonprop, ("rep and res not certified non-proportional", orb)
    P("orbit", orb, "rep/res certified non-proportional:", nonprop)
    reps.append(dict(orb=orb, size=size, n=n, nz=[not iszero[j] for j in range(4)], conics=conics))
P("(B) min d_j at real embedding:", mind.str(10), "(all certified > 0)")
P("(C) min certified |leading minor| (over sign-decided minors):", minminor.lower().str(6), "; min |det| lower bound:", mindet.lower().str(6))

# (D) planes: 48 images, normalise by the first exactly-nonzero coordinate, cluster
def matvec(g, x): return [sum((g[i][j] * x[j] for j in range(4) if g[i][j] != 0), arb(0)) for i in range(4)]
def gAgT(g, A):
    return [[sum((g[i][a] * A[a][b] * g[j][b] for a in range(4) for b in range(4) if g[i][a] != 0 and g[j][b] != 0), arb(0))
             for j in range(4)] for i in range(4)]
allp = []
for ri, R in enumerate(reps):
    for gi, g in enumerate(SYMS):
        m = matvec(g, R["n"])
        nzv = [sum(abs(g[i][j]) * (1 if R["nz"][j] else 0) for j in range(4)) for i in range(4)]
        f = next(j for j in range(4) if nzv[j])
        allp.append((ri, gi, [x / m[f] for x in m], f))
clusters = []
for (ri, gi, v, f) in allp:
    hit = False
    for c in clusters:
        if c[3] == f and all(abs((a - b).mid()) < 1e-60 for a, b in zip(v, c[2])):
            hit = True; break
    if not hit: clusters.append((ri, gi, v, f))
P("(D) plane images:", len(allp), " clusters:", len(clusters))
# certified pairwise separation
minsep = None; ncert = 0
for i in range(len(clusters)):
    for j in range(i + 1, len(clusters)):
        a, b = clusters[i], clusters[j]
        if a[3] != b[3]:
            ncert += 1; continue      # first exactly-nonzero coordinate differs: distinct planes exactly
        best = max((abs(x - y) for x, y in zip(a[2], b[2])), key=lambda z: z.lower().mid())
        assert best > 0, ("planes not separated", i, j)
        minsep = best if minsep is None or best.lower().mid() < minsep.lower().mid() else minsep
        ncert += 1
P("(D) certified distinct plane pairs:", ncert, "of", len(clusters)*(len(clusters)-1)//2, "; min certified separation (sup-norm, same normalising coordinate):", minsep.lower().str(6))

# (E) certified Gram
conic_list = []   # (cluster index, k in {0,1}) -> plane normal and 4x4 matrix
CL = []
for ci, (ri, gi, v, f) in enumerate(clusters):
    g = SYMS[gi]; R = reps[ri]
    n = matvec(g, R["n"])
    As = [gAgT(g, A) for A in R["conics"]]
    CL.append((n, As))
    for k in range(2): conic_list.append((ci, k, R["orb"], gi))
N = len(conic_list)
P("(E) conics:", N)

def cross3(a, b, c):
    # vector orthogonal to a, b, c in R^4 (cofactor expansion)
    out = []
    for i in range(4):
        cols = [j for j in range(4) if j != i]
        M = [[a[j] for j in cols], [b[j] for j in cols], [c[j] for j in cols]]
        d = (M[0][0]*(M[1][1]*M[2][2]-M[1][2]*M[2][1]) - M[0][1]*(M[1][0]*M[2][2]-M[1][2]*M[2][0])
             + M[0][2]*(M[1][0]*M[2][1]-M[1][1]*M[2][0]))
        out.append(d if i % 2 == 0 else -d)
    return out
E4 = [[arb(1 if i == j else 0) for j in range(4)] for i in range(4)]
def qf(A, X, Y):
    return sum((A[i][j] * X[i] * Y[j] for i in range(4) for j in range(4)), acb(0) if isinstance(X[0], acb) else arb(0))

G = [[0]*N for _ in range(N)]
nfail = 0; minoff = None; nclusters_merged = 0
for i in range(N):
    G[i][i] = -2
for ci in range(len(CL)):
    G[2*ci][2*ci+1] = G[2*ci+1][2*ci] = 4
t1 = time.time()
for ci in range(len(CL)):
    n1, A1s = CL[ci]
    for cj in range(len(CL)):
        if cj == ci: continue
        n2, A2s = CL[cj]
        cands = [cross3(n1, n2, E4[k]) for k in range(4)]
        # choose two candidates with a certified nonzero 2x2 minor
        found = None
        for k1, k2 in itertools.combinations(range(4), 2):
            for a_, b_ in itertools.combinations(range(4), 2):
                mnr = cands[k1][a_] * cands[k2][b_] - cands[k1][b_] * cands[k2][a_]
                if abs(mnr) > 0 and (found is None or abs(mnr).lower().mid() > found[0]):
                    found = (abs(mnr).lower().mid(), k1, k2)
        assert found is not None
        Pp, Rr = cands[found[1]], cands[found[2]]
        for k in range(2):
            A = A1s[k]
            # binary form q(s,r) = a s^2 + b s r + c r^2 on ell; make a certified nonzero by P -> P + lam R
            lam = 0
            while True:
                PP = [Pp[x] + lam * Rr[x] for x in range(4)]
                a = qf(A, PP, PP); b = 2 * qf(A, PP, Rr); c = qf(A, Rr, Rr)
                if abs(a) > 0: break
                lam += 1
                assert lam < 10
            disc = b * b - 4 * a * c
            if disc > 0 or disc < 0:
                sd = acb(disc).sqrt()
                roots = [((-b + sd) / (2 * a), 1), ((-b - sd) / (2 * a), 1)]
            else:
                nclusters_merged += 1
                rad = (abs(disc).upper().sqrt() / (2 * abs(a)).lower()).upper()
                ctr = (-b / (2 * a))
                roots = [(acb(arb(ctr.mid(), (ctr.rad() + rad).upper())), 2)]
            tot = 0
            for (s, mult) in roots:
                X = [s * PP[x] + Rr[x] for x in range(4)]
                on1 = qf(A2s[0], X, X); on2 = qf(A2s[1], X, X)
                off1 = abs(on1) > 0; off2 = abs(on2) > 0
                if off1 and off2:
                    raise SystemExit("inconsistency: point of C on ell off both C' and C''")
                if off2 and not off1:
                    tot += mult      # cluster lies on C'=A2s[0] side
                    mo = abs(on2).lower()
                elif off1 and not off2:
                    mo = abs(on1).lower()
                else:
                    nfail += 1; mo = None
                if mo is not None:
                    minoff = mo if minoff is None or mo.mid() < minoff.mid() else minoff
            # C (2ci+k) . C' (2cj+0) = tot ; C . C'' (2cj+1) = 2 - tot
            G[2*ci+k][2*cj] = tot
            G[2*ci+k][2*cj+1] = 2 - tot
    if ci % 40 == 0:
        P("  plane", ci, "done, elapsed", round(time.time() - t1, 1), "s")
sym = all(G[i][j] == G[j][i] for i in range(N) for j in range(N))
P("(E) undecided clusters:", nfail, " merged (tangent-type) clusters:", nclusters_merged, " Gram symmetric:", sym)
P("(E) min certified |Q_other(point)| deciding membership:", minoff.str(6) if minoff is not None else None)
from collections import Counter
P("(E) value counts:", sorted(Counter(G[i][j] for i in range(N) for j in range(N)).items()))
h = [0]*N; h[0] = 1; h[1] = 1
with open("gram_cert.gp", "w") as fo:
    fo.write("Gc = [" + ";".join(",".join(str(x) for x in rw) for rw in G) + "];\n")
    fo.write("hc = [" + ",".join(str(x) for x in h) + "]~;\n")
json.dump([dict(cluster=c[0], k=c[1], orbit=c[2], g=c[3]) for c in conic_list], open("conics_cert.json", "w"))
P("total seconds", round(time.time() - t0, 1))
