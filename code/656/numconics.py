# numconics.py (VERIFY seat, RAID-656): find ALL conics on a real quartic surface numerically and classify reality.
#
# Method (NUMERICAL):
#   * random real orthogonal chart R (X = R Y); planes Y0 = u1 Y1 + u2 Y2 + u3 Y3 (misses only planes through R e0,
#     a random real point not on X, so generically misses nothing); plane coordinates s = (Y1, Y2, Y3).
#   * G(s) = F(M(u) s); unknowns u (3), Q1 = s1^2 + a.(s1s2, s1s3, s2^2, s2s3, s3^2) (5, monic in s1), Q2 (6 coeffs);
#     equations G(s_k) - Q1(s_k) Q2(s_k) = 0 at 15 fixed generic points s_k (equivalent to the 15 coefficient
#     equations of a ternary quartic).  14 unknowns, 15 equations; damped Gauss-Newton from random complex starts,
#     vectorised in numpy (complex128).
#   * each converged solution gives 2 conics (Q1 and Q2); conics are keyed canonically (plane normalised by its
#     largest coordinate, conic matrix in the 3 remaining coordinates, normalised); optional orbit closure under the
#     48 signed permutations of (x, y, z) (family only); saturation is reported.
#   * one representative per Sym-orbit is polished with mpmath (dps 60) on the same equations; reality and
#     real-point status (indefinite real 3x3 form) decided on the polished representative and propagated to the
#     orbit (the symmetries are real, so they preserve both properties).
# usage: numconics.py <kind> <seed> <nstarts> <outjson> [sign=+1|-1] [sym=1|0] [rounds=k]
#   kind = fam (triple point, e = sign*sqrt(E*)) | famq3 (e,t) = (28/19, -10/9) | fermat | y56 | fam_et:<e>:<t>
import sys, json, itertools, time
import numpy as np, sympy as sp, mpmath as mp

mp.mp.dps = 60
kind, seed, nstarts, outjson = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), sys.argv[4]
opts = dict(s.split('=', 1) for s in sys.argv[5:])
sign = int(opts.get('sign', '1')); use_sym = int(opts.get('sym', '1')); rounds = int(opts.get('rounds', '6'))
rng = np.random.default_rng(seed)

x, y, z, w = Xs = sp.symbols('x y z w')
q = x**2 + y**2 + z**2; p4 = x**4 + y**4 + z**4
info = {}
if kind == 'fam':
    rts = mp.polyroots([9, 48, 125, 122], maxsteps=200, extraprec=400)
    tstar = [r for r in rts if abs(mp.im(r)) < mp.mpf(10)**-50][0].real
    Estar = (1688 - 1140*tstar - 1044*tstar**2)/361
    estar = sign*mp.sqrt(Estar)
    info = dict(t=mp.nstr(tstar, 45), E=mp.nstr(Estar, 45), e=mp.nstr(estar, 45))
    eS, tS = sp.Float(mp.nstr(estar, 58), 60), sp.Float(mp.nstr(tstar, 58), 60)
    Fexpr = w**4 + eS*q*w**2 + q**2 + tS*p4
    is_family = True
elif kind == 'famq3':
    Fexpr = w**4 + sp.Rational(28*sign, 19)*q*w**2 + q**2 + sp.Rational(-10, 9)*p4
    is_family = True
elif kind.startswith('fam_et:'):
    _, ee, tt = kind.split(':')
    Fexpr = w**4 + sp.Rational(ee)*q*w**2 + q**2 + sp.Rational(tt)*p4
    is_family = True
elif kind.startswith('efam:'):      # E-form E w^4 + E q w^2 + q^2 + t p4; E, t rationals or long decimals (complex: a+b*I)
    _, EE, tt = kind.split(':')
    Ev, tv = sp.sympify(EE, rational=('/' in EE)), sp.sympify(tt, rational=('/' in tt))
    Fexpr = Ev*w**4 + Ev*q*w**2 + q**2 + tv*p4
    is_family = True
elif kind == 'fermat':
    Fexpr = x**4 + y**4 + z**4 + w**4
    is_family = True     # Fermat is also invariant under signed permutations of (x,y,z)
elif kind == 'y56':
    s2 = sp.sqrt(2)
    z0, z1, z2, z3 = Xs
    Fexpr = (3*s2*z0**2*z1*z2 + 3*s2*z1*z2*z3**2 - s2*z1**3*z2 - s2*z1*z2**3 + 4*z0**3*z3 - 4*z0*z3**3)
    is_family = False
else:
    raise SystemExit('unknown kind')
if not is_family:
    use_sym = 0
Fn = sp.lambdify(Xs, Fexpr, 'numpy')
gradn = [sp.lambdify(Xs, sp.diff(Fexpr, v), 'numpy') for v in Xs]
Fm = sp.lambdify(Xs, Fexpr, 'mpmath')
gradm = [sp.lambdify(Xs, sp.diff(Fexpr, v), 'mpmath') for v in Xs]

# real orthogonal chart
Rm, _ = np.linalg.qr(rng.normal(size=(4, 4)))
R = Rm
S = rng.normal(size=(15, 3)) + 1j*rng.normal(size=(15, 3))      # 15 generic sample points in the plane
mons2 = lambda s: np.stack([s[..., 0]*s[..., 1], s[..., 0]*s[..., 2], s[..., 1]**2, s[..., 1]*s[..., 2], s[..., 2]**2], -1)
mons2f = lambda s: np.stack([s[..., 0]**2, s[..., 0]*s[..., 1], s[..., 0]*s[..., 2], s[..., 1]**2, s[..., 1]*s[..., 2], s[..., 2]**2], -1)
M2S = mons2(S); M2fS = mons2f(S)                                # (15,5), (15,6)

def Mof(u):            # (N,3) -> (N,4,3): column j = R[:,0] u_j + R[:,j+1]
    return R[None, :, 0:1]*u[:, None, :] + R[None, :, 1:4]

def resid_jac(V):
    u, a, b = V[:, :3], V[:, 3:8], V[:, 8:14]
    M = Mof(u)
    X = np.einsum('nij,kj->nki', M, S)                           # (N,15,4)
    Fx = Fn(*[X[..., i] for i in range(4)])
    G = np.stack([np.broadcast_to(gi(*[X[..., i] for i in range(4)]), Fx.shape) for gi in gradn], -1)   # (N,15,4)
    Q1 = S[None, :, 0]**2 + a @ M2S.T                            # (N,15)
    Q2 = b @ M2fS.T
    r = Fx - Q1*Q2
    J = np.empty(V.shape[:1] + (15, 14), complex)
    gR0 = G @ R[:, 0]                                            # (N,15)
    J[:, :, 0:3] = gR0[..., None]*S[None, :, :]
    J[:, :, 3:8] = -M2S[None]*Q2[..., None]
    J[:, :, 8:14] = -M2fS[None]*Q1[..., None]
    return r, J

def newton(V, iters=80):
    for it in range(iters):
        r, J = resid_jac(V)
        d = -np.einsum('nij,nj->ni', np.linalg.pinv(J), r)
        nv = np.linalg.norm(V, axis=1); nd = np.linalg.norm(d, axis=1)
        fac = np.minimum(1.0, (1.0 + nv)/np.maximum(nd, 1e-300))   # damping: step at most 1+|V|
        V = V + fac[:, None]*d
        bad = ~np.isfinite(V).all(1) | (np.linalg.norm(V, axis=1) > 1e6)
        V[bad] = 0.0
    r, J = resid_jac(V)
    return V, r

# ---------- conic keys, symmetry ----------
def canon(Mb, Qs):
    """Mb: 4x3 basis of the plane (X = Mb s); Qs: 3x3 symmetric matrix in s. Return (k, n, Qc) canonical."""
    # plane normal n with n . (Mb s) = 0
    _, _, vh = np.linalg.svd(Mb.T)
    n = vh[-1].conj()                     # n^T Mb = 0  (solve Mb^T n = 0)
    n = np.linalg.svd(Mb.T)[2][-1].conj()
    k = int(np.argmax(abs(n))); n = n/n[k]
    keep = [i for i in range(4) if i != k]
    A = Mb[keep, :]                       # c = A s
    Ai = np.linalg.inv(A)
    Qc = Ai.T @ Qs @ Ai
    j = np.unravel_index(np.argmax(abs(Qc)), Qc.shape); Qc = Qc/Qc[j]
    return k, n, Qc

RKEY = np.random.default_rng(12345).normal(size=4); RKEY2 = np.random.default_rng(54321).normal(size=4)
def adj3(Q):
    return np.array([[Q[(i+1)%3, (j+1)%3]*Q[(i+2)%3, (j+2)%3] - Q[(i+1)%3, (j+2)%3]*Q[(i+2)%3, (j+1)%3]
                      for i in range(3)] for j in range(3)])
def key(Mb, Qs, digs=12):
    """tie-free canonical key: dual conic C* = Mb adj(Q) Mb^T (4x4, rank 3, the quadric of planes tangent to the
    conic; determines the conic) normalised by r^T C* r for a fixed random real r, plus the plane normal
    normalised by r2 . n (keeps line pairs with a common node apart)."""
    C = Mb @ adj3(Qs) @ Mb.T
    C = C/(RKEY @ C @ RKEY)
    n = np.linalg.svd(Mb.T)[2][-1].conj(); n = n/(RKEY2 @ n)
    v = np.concatenate([C[np.triu_indices(4)], n])
    return tuple(np.round(v.real, digs)) + tuple(np.round(v.imag, digs))

def Qmat1(a):
    return np.array([[1, a[0]/2, a[1]/2], [a[0]/2, a[2], a[3]/2], [a[1]/2, a[3]/2, a[4]]], complex)
def Qmat2(b):
    return np.array([[b[0], b[1]/2, b[2]/2], [b[1]/2, b[3], b[4]/2], [b[2]/2, b[4]/2, b[5]]], complex)

SYM = []
for perm in itertools.permutations(range(3)):
    for sg in itertools.product((1, -1), repeat=3):
        g = np.zeros((4, 4)); g[3, 3] = 1
        for i in range(3):
            g[i, perm[i]] = sg[i]
        SYM.append(g)

class ConicSet(dict):
    """dict keyed by conic key tuples, but membership is by distance (< 1e-5) between key vectors, not rounding."""
    def __init__(self):
        super().__init__(); self.vecs = np.zeros((0, 28)); self.keys = []
    def find(self, k):
        if not self.keys: return None
        v = np.array(k); d = np.linalg.norm(self.vecs - v, axis=1); i = int(np.argmin(d))
        return self.keys[i] if d[i] < 1e-5*(1 + np.linalg.norm(v)) else None
    def __contains__(self, k): return self.find(k) is not None
    def __getitem__(self, k): return dict.__getitem__(self, self.find(k))
    def __setitem__(self, k, val):
        self.vecs = np.vstack([self.vecs, np.array(k)[None]]); self.keys.append(k); dict.__setitem__(self, k, val)
conics = ConicSet()   # key -> dict(basis, Q, orbit id)
sols = []
t0 = time.time()
total_tried = 0
for rd in range(rounds):
    V0 = (rng.normal(size=(nstarts, 14)) + 1j*rng.normal(size=(nstarts, 14)))*rng.choice([float(v) for v in opts.get("scales", "0.5,1,2").split(",")], size=(nstarts, 1))
    V, r = newton(V0)
    total_tried += nstarts
    rel = np.linalg.norm(r, axis=1)/(1 + np.linalg.norm(V, axis=1)**4)
    good = (rel < 1e-10) & (np.linalg.norm(V, axis=1) < 1e5)
    newc = 0
    for vv in V[good]:
        Mb = Mof(vv[None, :3])[0]
        for Qs in (Qmat1(vv[3:8]), Qmat2(vv[8:14])):
            if abs(np.linalg.det(Qs)) < 1e-12*np.linalg.norm(Qs)**3 and kind not in ('y56', 'fermat'):
                pass
            imgs = [(SYM[i] @ Mb, Qs) for i in range(len(SYM))] if use_sym else [(Mb, Qs)]
            kk0 = key(Mb, Qs)
            if kk0 in conics:
                continue
            sols.append(vv)
            oid = len(sols) - 1
            for (Mg, Qg) in imgs:
                kk = key(Mg, Qg)
                if kk not in conics:
                    conics[kk] = dict(Mb=Mg, Q=Qg, orbit=oid, rep=(Mg is Mb) or not use_sym)
                    newc += 1
    print("round", rd, "starts", nstarts, "converged", int(good.sum()), "new conics", newc, "total", len(conics),
          "orbits(reps)", len(sols), "secs %.0f" % (time.time() - t0), flush=True)

# ---------- polish representatives with mpmath ----------
Smp = [[mp.mpc(complex(S[k, j])) for j in range(3)] for k in range(15)]
Rmp = [[mp.mpf(float(R[i, j])) for j in range(4)] for i in range(4)]
def mp_resid_jac(Vm):
    u, a, b = Vm[:3], Vm[3:8], Vm[8:14]
    rr = mp.matrix(15, 1); JJ = mp.matrix(15, 14)
    for k in range(15):
        s = Smp[k]
        X = [Rmp[i][0]*(u[0]*s[0] + u[1]*s[1] + u[2]*s[2]) + Rmp[i][1]*s[0] + Rmp[i][2]*s[1] + Rmp[i][3]*s[2] for i in range(4)]
        m2 = [s[0]*s[1], s[0]*s[2], s[1]**2, s[1]*s[2], s[2]**2]
        m2f = [s[0]**2] + m2
        Q1 = s[0]**2 + sum(a[i]*m2[i] for i in range(5)); Q2 = sum(b[i]*m2f[i] for i in range(6))
        rr[k] = Fm(*X) - Q1*Q2
        gr = [gi(*X) for gi in gradm]
        gR0 = sum(gr[i]*Rmp[i][0] for i in range(4))
        for j in range(3): JJ[k, j] = gR0*s[j]
        for i in range(5): JJ[k, 3+i] = -m2[i]*Q2
        for i in range(6): JJ[k, 8+i] = -m2f[i]*Q1
    return rr, JJ
def polish(v):
    Vm = [mp.mpc(complex(c)) for c in v]
    for it in range(12):
        rr, JJ = mp_resid_jac(Vm)
        JH = JJ.H
        d = mp.lu_solve(JH*JJ, -(JH*rr))
        Vm = [Vm[i] + d[i] for i in range(14)]
        if mp.norm(d) < mp.mpf(10)**-55:
            break
    rr, JJ = mp_resid_jac(Vm)
    sv = mp.svd_c(JJ, compute_uv=False)
    return Vm, mp.norm(rr), mp.norm(d), min(sv[i] for i in range(len(sv)))

def classify_mp(Vm, which):
    """reality of the plane, of conic `which` (1 or 2), and real points, at mp precision."""
    u = Vm[:3]
    Mb = mp.matrix(4, 3)
    for i in range(4):
        for j in range(3):
            Mb[i, j] = Rmp[i][0]*u[j] + Rmp[i][j+1]
    if which == 1:
        a = Vm[3:8]; Q = mp.matrix([[1, a[0]/2, a[1]/2], [a[0]/2, a[2], a[3]/2], [a[1]/2, a[3]/2, a[4]]])
    else:
        b = Vm[8:14]; Q = mp.matrix([[b[0], b[1]/2, b[2]/2], [b[1]/2, b[3], b[4]/2], [b[2]/2, b[4]/2, b[5]]])
    # plane normal: cross-product style via 3x3 minors of Mb
    n = []
    for k in range(4):
        rows = [i for i in range(4) if i != k]
        n.append((-1)**k*mp.det(mp.matrix([[Mb[i, j] for j in range(3)] for i in rows])))
    kmax = max(range(4), key=lambda i: abs(n[i])); n = [c/n[kmax] for c in n]
    plane_im = max(abs(mp.im(c)) for c in n)
    keep = [i for i in range(4) if i != kmax]
    A = mp.matrix([[Mb[i, j] for j in range(3)] for i in keep]); Ai = mp.inverse(A)
    Qc = Ai.T*Q*Ai
    jmax = max(((i, j) for i in range(3) for j in range(3)), key=lambda ij: abs(Qc[ij[0], ij[1]]))
    Qc = Qc/Qc[jmax[0], jmax[1]]
    conic_im = max(abs(mp.im(Qc[i, j])) for i in range(3) for j in range(3))
    detQ = mp.det(Qc)
    res = dict(plane_im=float(plane_im), conic_im=float(conic_im), det=[float(mp.re(detQ)), float(mp.im(detQ))])
    if plane_im < mp.mpf(10)**-40 and conic_im < mp.mpf(10)**-40:
        Qr = mp.matrix([[mp.re(Qc[i, j]) for j in range(3)] for i in range(3)])
        ev = mp.eigsy(Qr)[0]
        evs = [float(ev[i]) for i in range(3)]
        pos = sum(1 for v in evs if v > 1e-30); neg = sum(1 for v in evs if v < -1e-30)
        res.update(eig=evs, real_points=(pos > 0 and neg > 0), min_abs_eig=float(min(abs(v) for v in evs)))
    return res

orbit_size = {}
for kk, c in conics.items():
    orbit_size[c['orbit']] = orbit_size.get(c['orbit'], 0) + 1
reps = []
for oid, v in enumerate(sols):
    Vm, rn, dn, smin = polish(v)
    # which of Q1/Q2 does this orbit's representative correspond to? test both, record the one whose key matches
    Mb = Mof(v[None, :3])[0]
    k1 = key(Mb, Qmat1(v[3:8]))
    which = 1 if (k1 in conics and conics[k1]['orbit'] == oid) else 2
    cl = classify_mp(Vm, which)
    cl.update(orbit=oid, size=orbit_size.get(oid, 0), resid=float(rn), last_step=float(dn), jac_smin=float(smin), which=which,
              V=[[mp.nstr(mp.re(c), 58), mp.nstr(mp.im(c), 58)] for c in Vm])
    reps.append(cl)
    print("orbit %2d size %2d resid %.1e smin %.2e plane_im %.1e conic_im %.1e real_pts %s eig %s" % (
        oid, cl['size'], cl['resid'], cl['jac_smin'], cl['plane_im'], cl['conic_im'], cl.get('real_points'),
        ['%.3g' % e for e in cl.get('eig', [])]), flush=True)

tot = len(conics)
reps_all = reps
reps = [r for r in reps_all if r['resid'] < 1e-40]          # genuine: polished to 60 digits
spurious = sum(r['size'] for r in reps_all if r['resid'] >= 1e-40)
real = sum(r['size'] for r in reps if 'eig' in r)
realpts = sum(r['size'] for r in reps if r.get('real_points'))
realplane = sum(r['size'] for r in reps if r['plane_im'] < 1e-40)
summary = dict(kind=kind, sign=sign, seed=seed, info=info, total_found=tot, spurious_rejected=spurious, total_conics=tot - spurious, orbits=len(sols), real_plane=realplane,
               real_conic=real, real_with_real_points=realpts, starts=total_tried, sym=use_sym)
print("SUMMARY", json.dumps(summary))
json.dump(dict(summary=summary, reps=reps, R=R.tolist()), open(outjson, 'w'), indent=1)
