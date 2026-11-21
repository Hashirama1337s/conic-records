# ballreal.py (CERT664): certified real-point test for the sigma-real conics exported by realpic.gp.
# Each conic is given in real coordinates X' (plane normalised by its first nonzero coordinate, conic normalised by
# its first nonzero coefficient), with exact coordinates in the basis 1,i,s3,i s3,s5,i s5,s3 s5,i s3 s5; realpic.gp
# checked exactly that they are real, so only the real basis elements 1, s3, s5, s3 s5 occur.
# A real smooth conic has real points iff its ternary form is indefinite: leading minors m1, m2, m3 (m3 = det != 0);
# m1 == 0 or m2 == 0 exactly -> real points; else definite iff (+,+,+) or (-,+,-).  Signs certified with arb balls.
import sys, re
from fractions import Fraction as Fr
from collections import Counter
from flint import arb, fmpq, ctx
ctx.prec = 256
def parse(line): return eval(re.sub(r'(-?\d+/\d+|-?\d+)', r'Fr("\1")', line.strip()), {'Fr': Fr})
S3, S5 = arb(3).sqrt(), arb(5).sqrt()
RB = {0: arb(1), 2: S3, 4: S5, 6: S3*S5}
def val(cf):
    assert all(cf[k] == 0 for k in (1, 3, 5, 7)), 'non-real coordinate'
    return sum((arb(fmpq(cf[k].numerator, cf[k].denominator))*RB[k] for k in (0, 2, 4, 6)), arb(0))
def iszero(cf): return all(c == 0 for c in cf)
for s in (1, 2):
    rows = [parse(l) for l in open('realconics_h%d.txt' % s) if l.strip()]
    nrp = 0; pat = Counter(); minabs = None; perorb = Counter(); perorb_rp = Counter()
    for r in rows:
        j, orb, f, ncf, qcf = r
        q = [val(v) for v in qcf]
        M = [[q[0], q[1]/2, q[2]/2], [q[1]/2, q[3], q[4]/2], [q[2]/2, q[4]/2, q[5]]]
        m1 = M[0][0]; m2 = M[0][0]*M[1][1] - M[0][1]**2
        m3 = (M[0][0]*(M[1][1]*M[2][2]-M[1][2]**2) - M[0][1]*(M[0][1]*M[2][2]-M[1][2]*M[0][2]) + M[0][2]*(M[0][1]*M[1][2]-M[1][1]*M[0][2]))
        assert m3 > 0 or m3 < 0, ('det sign not certified', j)
        perorb[int(orb)] += 1
        if iszero(qcf[0]):
            rp = True; pat['m1=0'] += 1
        else:
            assert m1 > 0 or m1 < 0, ('m1 sign', j)
            # m2 exactly zero? decide by certified sign; if the ball contains 0 we fall back to an exact check impossible here -> stop
            assert m2 > 0 or m2 < 0, ('m2 sign not certified', j)
            sg = tuple(1 if m > 0 else -1 for m in (m1, m2, m3))
            rp = not (sg == (1, 1, 1) or sg == (-1, 1, -1))
            pat[sg] += 1
            for m in (m1, m2, m3):
                a = abs(m).lower(); minabs = a if minabs is None or a < minabs else minabs
        if rp: nrp += 1; perorb_rp[int(orb)] += 1
    print('structure h%d: sigma-real conics %d, with real points %d; sign patterns %s; min certified |minor| %s' % (
        s, len(rows), nrp, dict(pat), minabs.str(5) if minabs is not None else None))
    print('   per orbit (real / with real points):', {o: (perorb[o], perorb_rp[o]) for o in sorted(perorb)})
