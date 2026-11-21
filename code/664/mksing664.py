# mksing664.py (CERT664): second-engine replay of the 17 exact identities F|plane = mu*Q1*Q2 in Singular.
# Field: A = Q[a,b,e]/(a^2+1, b^2-3, e^2-5)  (a = i, b = sqrt3, e = sqrt5); the generators have pairwise coprime
# leading monomials, so they are a Groebner basis; reduce(.,J) == 0 means the identity holds for every choice of
# signs of i, sqrt3, sqrt5 (all 8 conjugates), with no absolute field and no PARI.
# Basis order (same as exact.gp): 1, a, b, ab, e, ae, be, abe.  Input: reps_exact.txt written by exact.gp.
import re
from fractions import Fraction as Fr

def parse(line):
    s = re.sub(r'(-?\d+/\d+|-?\d+)', r'Fr("\1")', line.strip())
    return eval(s, {'Fr': Fr})

BAS = ['1', 'a', 'b', 'a*b', 'e', 'a*e', 'b*e', 'a*b*e']
def el(cf):
    terms = []
    for c, b in zip(cf, BAS):
        if c != 0:
            terms.append('(%s)*%s' % (str(c), b))
    return '+'.join(terms) if terms else '0'

reps = [parse(l) for l in open('reps_exact.txt') if l.strip()]
MON2 = ['u0^2', 'u0*u1', 'u0*u2', 'u1^2', 'u1*u2', 'u2^2']
U = ['u0', 'u1', 'u2']
out = ['ring r = 0, (u0,u1,u2,a,b,e), dp;', 'ideal J = a^2+1, b^2-3, e^2-5;', 'ideal Js = std(J);',
       'print("Groebner basis size: " + string(size(Js)));', 'int nok = 0; int nneg = 0;', 'poly X1; poly X2; poly X3; poly X4; poly Fp; poly Q1; poly Q2; poly mu; poly D; poly piv;']
for R in reps:
    o, sz, wh, k = int(R[0]), int(R[1]), int(R[2]), int(R[3])
    n = [el(v) for v in R[4]]; q1 = [el(v) for v in R[5]]; q2 = [el(v) for v in R[6]]; mu = el(R[7])
    keep = [i for i in range(1, 5) if i != k]
    X = [None]*5
    for j, i in enumerate(keep): X[i] = U[j]
    X[k] = '-(' + '+'.join('(%s)*%s' % (n[keep[j]-1], U[j]) for j in range(3)) + ')'
    out.append('piv = reduce(%s - 1, Js);' % n[k-1])
    for i in range(1, 5): out.append('X%d = %s;' % (i, X[i]))
    out.append('Fp = X1^4+X2^4+X3^4+X4^4-(X1^2*X2^2+X1^2*X3^2+X1^2*X4^2+X2^2*X3^2+X2^2*X4^2+X3^2*X4^2)+3*a*e*X1*X2*X3*X4;')
    out.append('Q1 = ' + '+'.join('(%s)*%s' % (q1[i], MON2[i]) for i in range(6)) + ';')
    out.append('Q2 = ' + '+'.join('(%s)*%s' % (q2[i], MON2[i]) for i in range(6)) + ';')
    out.append('mu = %s;' % mu)
    out.append('D = reduce(Fp - mu*Q1*Q2, Js);')
    out.append('if (D == 0 && piv == 0) { nok = nok + 1; }')
    out.append('print("orbit %d: pivot == 1: " + string(piv == 0) + "   identity reduces to 0: " + string(D == 0));' % o)
    out.append('D = reduce(Fp - (mu + 1/1000000)*Q1*Q2, Js); if (D != 0) { nneg = nneg + 1; }')
out.append('print("identities holding: " + string(nok) + " of %d;  negative control (mu + 10^-6) fails in " + string(nneg) + " of %d");' % (len(reps), len(reps)))
out.append('quit;')
open('replay664.sing', 'w').write('\n'.join(out) + '\n')
print('wrote replay664.sing with', len(reps), 'identities')
