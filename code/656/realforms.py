# realforms.py (VERIFY seat, RAID-656): reality of all conics under every real structure of the family member.
#
# Input: the JSON written by numconics.py (polished orbit representatives at 60 digits, chart R).
# Real structures: c_g = g o conj with g a real involution of Sym (signed permutations of x, y, z; w fixed).
#   Up to conjugacy in Sym: g = I (standard: X+ when e > 0), sigma = -I_xyz (equivalent to X-: w -> i w),
#   d1 = diag(-1,1,1), d2 = diag(-1,-1,1), s = swap(x,y), s' = swap(x,y) with z -> -z.
#   Real coordinates X' with X = A X', g conj(A) = A; the real quartic of c_g is F(A X') (real coefficients).
# For each conic C (all 656, generated from the representatives by the 48 exact real symmetries) and each g:
#   C is c_g-real iff its dual conic C* = Mb adj(Q) Mb^T, written in X' coordinates and scaled, is real;
#   a c_g-real conic has real points iff that real rank-3 symmetric 4x4 form is indefinite (Sylvester).
# usage: realforms.py <in.json> [dps]
import sys, json, itertools
import mpmath as mp

data = json.load(open(sys.argv[1]))
mp.mp.dps = int(sys.argv[2]) if len(sys.argv) > 2 else 40
R = [[mp.mpf(v) for v in row] for row in data['R']]
I = mp.mpc(0, 1)

SYM = []
for perm in itertools.permutations(range(3)):
    for sg in itertools.product((1, -1), repeat=3):
        g = mp.zeros(4, 4); g[3, 3] = 1
        for i in range(3):
            g[i, perm[i]] = sg[i]
        SYM.append(g)

def diag(*v):
    m = mp.zeros(4, 4)
    for i, c in enumerate(v):
        m[i, i] = c
    return m
r2 = 1/mp.sqrt(2)
A_swap = mp.matrix([[r2, I*r2, 0, 0], [r2, -I*r2, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]])
A_swapz = mp.matrix([[r2, I*r2, 0, 0], [r2, -I*r2, 0, 0], [0, 0, I, 0], [0, 0, 0, 1]])
STRUCT = {   # name: (g, A)
    'I (X+ if e>0)': (diag(1, 1, 1, 1), diag(1, 1, 1, 1)),
    'sigma (= X-)': (diag(-1, -1, -1, 1), diag(I, I, I, 1)),
    'd1=diag(-1,1,1)': (diag(-1, 1, 1, 1), diag(I, 1, 1, 1)),
    'd2=diag(-1,-1,1)': (diag(-1, -1, 1, 1), diag(I, I, 1, 1)),
    's=swap(x,y)': (mp.matrix([[0, 1, 0, 0], [1, 0, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]), A_swap),
    "s'=swap(x,y),z->-z": (mp.matrix([[0, 1, 0, 0], [1, 0, 0, 0], [0, 0, -1, 0], [0, 0, 0, 1]]), A_swapz),
}
for name, (g, A) in STRUCT.items():      # check g conj(A) = A
    d = g*A.conjugate() - A
    assert max(abs(d[i, j]) for i in range(4) for j in range(4)) < mp.mpf(10)**-30, name

def adj3(Q):
    return mp.matrix([[Q[(i+1)%3, (j+1)%3]*Q[(i+2)%3, (j+2)%3] - Q[(i+1)%3, (j+2)%3]*Q[(i+2)%3, (j+1)%3]
                       for i in range(3)] for j in range(3)])

def rep_conic(rep):
    V = [mp.mpc(mp.mpf(a), mp.mpf(b)) for a, b in rep['V']]
    u = V[:3]
    Mb = mp.matrix(4, 3)
    for i in range(4):
        for j in range(3):
            Mb[i, j] = R[i][0]*u[j] + R[i][j+1]
    if rep['which'] == 1:
        a = V[3:8]; Q = mp.matrix([[1, a[0]/2, a[1]/2], [a[0]/2, a[2], a[3]/2], [a[1]/2, a[3]/2, a[4]]])
    else:
        b = V[8:14]; Q = mp.matrix([[b[0], b[1]/2, b[2]/2], [b[1]/2, b[3], b[4]/2], [b[2]/2, b[4]/2, b[5]]])
    return Mb*adj3(Q)*Mb.T

def normalize(C):
    m = max(((i, j) for i in range(4) for j in range(4)), key=lambda ij: abs(C[ij[0], ij[1]]))
    return C/C[m[0], m[1]]

RK = [mp.mpf(v) for v in (0.3141, -1.2718, 0.5772, 0.9189)]   # fixed generic real vector (tie-free scaling)
def dkey(C, digs=8):
    s = sum(RK[i]*C[i, j]*RK[j] for i in range(4) for j in range(4))
    C = C/s
    return tuple(round(float(mp.re(C[i, j])), digs) for i in range(4) for j in range(i, 4)) + \
           tuple(round(float(mp.im(C[i, j])), digs) for i in range(4) for j in range(i, 4))

allc = {}   # key -> (C*, orbit)
for rep in data['reps']:
    C0 = rep_conic(rep)
    for h in SYM:
        C = h*C0*h.T
        k = dkey(C)
        if k not in allc:
            allc[k] = (C, rep['orbit'])
print("conics generated from representatives:", len(allc), "(input total %d)" % data['summary']['total_conics'])

res = {}
gaps = {}
for name, (g, A) in STRUCT.items():
    Ai = mp.inverse(A)
    nreal = nrp = 0
    per_orbit = {}
    max_im_real, min_im_nonreal, min_eig = mp.mpf(0), mp.mpf(1e9), mp.mpf(1e9)
    for k, (C, oid) in allc.items():
        Cp = normalize(Ai*C*Ai.T)
        im = max(abs(mp.im(Cp[i, j])) for i in range(4) for j in range(4))
        po = per_orbit.setdefault(oid, [0, 0, 0])
        po[0] += 1
        if im < mp.mpf(10)**-25:
            max_im_real = max(max_im_real, im)
            Cr = mp.matrix([[mp.re(Cp[i, j]) for j in range(4)] for i in range(4)])
            ev = sorted(mp.eigsy(Cr)[0], key=lambda v: abs(v))      # smallest |ev| is the zero eigenvalue
            nz = ev[1:]
            min_eig = min(min_eig, min(abs(v) for v in nz))
            nreal += 1; po[1] += 1
            if min(nz) < 0 < max(nz):
                nrp += 1; po[2] += 1
        else:
            min_im_nonreal = min(min_im_nonreal, im)
    res[name] = dict(real=nreal, real_with_points=nrp, per_orbit={str(o): v for o, v in sorted(per_orbit.items())})
    gaps[name] = dict(max_im_real=float(max_im_real), min_im_nonreal=float(min_im_nonreal), min_abs_nonzero_eig=float(min_eig))
    print("%-22s real conics %3d   with real points %3d   [max |Im| real %.1e, min |Im| non-real %.1e, min |eig| %.1e]" % (
        name, nreal, nrp, max_im_real, min_im_nonreal, min_eig), flush=True)
out = sys.argv[1].replace('.json', '_realforms.json')
json.dump(dict(results=res, gaps=gaps), open(out, 'w'), indent=1)
print("wrote", out)
