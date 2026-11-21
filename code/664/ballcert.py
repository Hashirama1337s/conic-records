# ballcert.py (CERT664): ball-arithmetic (python-flint acb) replay from the exact data conics_exact.txt / planes_exact.txt.
# Independent of the PARI Gram: evaluates the exact algebraic coordinates (basis 1,i,s3,i s3,s5,i s5,s3 s5,i s3 s5)
# as certified complex balls, then certifies
#  (A) det != 0 for all 664 conics (smooth), and the two conics on each plane non-proportional;
#  (B) the 332 planes pairwise distinct (same normalising coordinate: some coordinate difference excludes 0;
#      different first-nonzero coordinate: distinct exactly);
#  (C) the intersection Gram, arbcert-style (complex version): C.C = -2, same plane 4; otherwise the divisor of
#      ell = plane(C) cap plane(C') on C, split by certified membership of its root balls on C' or C''.
# Output: ballcert.out, gram_ball.gp
import sys, re, itertools, time
from fractions import Fraction as Fr
from collections import Counter
from flint import arb, acb, fmpq, ctx

ctx.prec = int(sys.argv[1]) if len(sys.argv) > 1 else 256
log = open('ballcert.out', 'w')
def P(*a):
    s = ' '.join(str(x) for x in a); print(s, flush=True); log.write(s + '\n'); log.flush()
def parse(line):
    return eval(re.sub(r'(-?\d+/\d+|-?\d+)', r'Fr("\1")', line.strip()), {'Fr': Fr})
I = acb(0, 1); S3 = acb(arb(3).sqrt()); S5 = acb(arb(5).sqrt())
BAS = [acb(1), I, S3, I*S3, S5, I*S5, S3*S5, I*S3*S5]
def val(cf): return sum((acb(arb(fmpq(c.numerator, c.denominator)))*b for c, b in zip(cf, BAS) if c != 0), acb(0))
rows = [parse(l) for l in open('conics_exact.txt') if l.strip()]
rows = rows[-664:] if len(rows) >= 664 else rows
planes = [tuple(int(v) for v in parse(l)) for l in open('planes_exact.txt') if l.strip()][-332:]
P('conics read:', len(rows), ' planes read:', len(planes))
CON = []
for r in rows:
    j, f, orb, ncf, qcf = int(r[0]), int(r[1]) - 1, int(r[2]), r[3], r[4]
    nz = [any(c != 0 for c in v) for v in ncf]
    n = [val(v) for v in ncf]; q = [val(v) for v in qcf]
    keep = [i for i in range(4) if i != f]
    M3 = [[q[0], q[1]/2, q[2]/2], [q[1]/2, q[3], q[4]/2], [q[2]/2, q[4]/2, q[5]]]
    CON.append(dict(j=j, f=f, orb=orb, n=n, nz=nz, q=q, M3=M3, keep=keep, qz=[all(c == 0 for c in v) for v in qcf]))
def det3(M):
    return (M[0][0]*(M[1][1]*M[2][2]-M[1][2]*M[2][1]) - M[0][1]*(M[1][0]*M[2][2]-M[1][2]*M[2][0]) + M[0][2]*(M[1][0]*M[2][1]-M[1][1]*M[2][0]))
def nonzero(z): return abs(z) > 0
mindet = None
for c in CON:
    d = det3(c['M3'])
    assert nonzero(d), ('det not certified', c['j'])
    a_ = abs(d).lower()
    mindet = a_ if mindet is None or a_ < mindet else mindet
P('(A) all', len(CON), 'conics: det certified != 0; min |det| >=', mindet.str(6))
for (a, b) in planes:
    ca, cb = CON[a-1], CON[b-1]
    assert ca['f'] == cb['f'] and all(abs(x - y) < 1e-40 for x, y in zip(ca['n'], cb['n'])), 'plane mismatch'
    ok = any(nonzero(ca['q'][u]*cb['q'][v] - ca['q'][v]*cb['q'][u]) for u in range(6) for v in range(u+1, 6))
    assert ok, ('not certified non-proportional', a, b)
P('(A) all', len(planes), 'planes: the two conics certified non-proportional')
ncert = 0; minsep = None; nexact = 0
for i in range(len(planes)):
    for k in range(i+1, len(planes)):
        a, b = CON[planes[i][0]-1], CON[planes[k][0]-1]
        if a['f'] != b['f']:
            nexact += 1; ncert += 1; continue
        best = max((abs(x - y).lower() for x, y in zip(a['n'], b['n'])))
        assert best > 0, ('planes not separated', i, k)
        minsep = best if minsep is None or best < minsep else minsep
        ncert += 1
P('(B) certified distinct plane pairs:', ncert, 'of', len(planes)*(len(planes)-1)//2, '(', nexact, 'by different first-nonzero coordinate); min certified sup-norm separation:', minsep.str(6))

# (C) Gram
def cross3(a, b, c):
    out = []
    for i in range(4):
        cols = [j for j in range(4) if j != i]
        M = [[a[j] for j in cols], [b[j] for j in cols], [c[j] for j in cols]]
        d = det3(M); out.append(d if i % 2 == 0 else -d)
    return out
E4 = [[acb(1 if i == j else 0) for j in range(4)] for i in range(4)]
def qform(c, X, Y):
    xk = [X[i] for i in c['keep']]; yk = [Y[i] for i in c['keep']]
    return sum((c['M3'][u][v]*xk[u]*yk[v] for u in range(3) for v in range(3)), acb(0))
N = len(CON); G = [[0]*N for _ in range(N)]
for i in range(N): G[i][i] = -2
for (a, b) in planes: G[a-1][b-1] = G[b-1][a-1] = 4
nfail = 0; nmerged = 0; minoff = None
t1 = time.time()
for pi in range(len(planes)):
    A1 = [CON[planes[pi][0]-1], CON[planes[pi][1]-1]]
    for pj in range(len(planes)):
        if pj == pi: continue
        A2 = [CON[planes[pj][0]-1], CON[planes[pj][1]-1]]
        n1, n2 = A1[0]['n'], A2[0]['n']
        cands = [cross3(n1, n2, E4[k]) for k in range(4)]
        found = None
        for k1, k2 in itertools.combinations(range(4), 2):
            for u, v in itertools.combinations(range(4), 2):
                mn = cands[k1][u]*cands[k2][v] - cands[k1][v]*cands[k2][u]
                if nonzero(mn):
                    lb = abs(mn).lower()
                    if found is None or lb > found[0]: found = (lb, k1, k2)
        assert found is not None
        Pp, Rr = cands[found[1]], cands[found[2]]
        for kk in range(2):
            C = A1[kk]; lam = 0
            while True:
                PP = [Pp[x] + lam*Rr[x] for x in range(4)]
                qa = qform(C, PP, PP); qb = 2*qform(C, PP, Rr); qc = qform(C, Rr, Rr)
                if nonzero(qa): break
                lam += 1; assert lam < 10
            disc = qb*qb - 4*qa*qc
            if nonzero(disc):
                # avoid the branch cut of acb sqrt on the negative real axis (a ball straddling it gives a huge radius)
                sd = (I*((-disc).sqrt())) if disc.real < 0 else disc.sqrt(); roots = [((-qb + sd)/(2*qa), 1), ((-qb - sd)/(2*qa), 1)]
            else:
                nmerged += 1
                rad = (abs(disc).upper().sqrt()/(2*abs(qa)).lower()).upper()
                ctr = -qb/(2*qa)
                roots = [(acb(arb(ctr.real.mid(), (ctr.real.rad() + rad).upper()), arb(ctr.imag.mid(), (ctr.imag.rad() + rad).upper())), 2)]
            tot = 0; und = False
            for (sr, mult) in roots:
                X = [sr*PP[x] + Rr[x] for x in range(4)]
                on1 = qform(A2[0], X, X); on2 = qform(A2[1], X, X)
                off1, off2 = nonzero(on1), nonzero(on2)
                if off1 and off2: raise SystemExit('inconsistency: point of C on ell off both conics of the other plane')
                if off2 and not off1: tot += mult; mo = abs(on2).lower()
                elif off1 and not off2: mo = abs(on1).lower()
                else: nfail += 1; mo = None; und = True    # root ball meets both conics of the other plane (triple point?)
                if mo is not None: minoff = mo if minoff is None or mo < minoff else minoff
            G[planes[pi][kk]-1][planes[pj][0]-1] = -9 if und else tot
            G[planes[pi][kk]-1][planes[pj][1]-1] = -9 if und else 2 - tot
    if pi % 40 == 0: P('  plane', pi, 'elapsed', round(time.time() - t1, 1), 's')
sym = all(G[i][j] == G[j][i] or -9 in (G[i][j], G[j][i]) for i in range(N) for j in range(N))
P('(C) entries left undecided by balls (marked -9):', sum(1 for i in range(N) for j in range(N) if G[i][j] == -9))
P('(C) undecided clusters:', nfail, ' merged (double-root) clusters:', nmerged, ' Gram symmetric:', sym)
P('(C) min certified |Q_other(point)| deciding membership:', minoff.str(6) if minoff is not None else None)
P('(C) value counts:', sorted(Counter(G[i][j] for i in range(N) for j in range(N)).items()))
with open('gram_ball.gp', 'w') as fo:
    fo.write('Gb = [' + ';'.join(','.join(str(x) for x in rw) for rw in G) + '];\n')
P('wrote gram_ball.gp')
