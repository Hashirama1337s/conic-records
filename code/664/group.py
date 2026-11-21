# group.py (CERT664): exact checks on the symmetry group of X664 and enumeration of its real structures.
#  (1) every signed 4x4 permutation matrix with an even number of -1 preserves F exactly (sympy, c symbolic with c^2=-45 not needed);
#      every one with an odd number of -1 sends F_c to F_{-c}.  Projectively: 192/{+-1} = 96 elements.
#  (2) projective reflections among the 96 (g or -g has eigenvalues 1,1,1,-1).
#  (3) real structures sigma_h = h o conj, h in the odd coset (X(-c) -> X(c), since -conj(c) = c for c = 3 sqrt(-5)),
#      with h^2 = +-I; classes under conjugation by the group; for h^2 = +I a matrix A with h conj(A) = A
#      (real points of sigma_h = A RP^3) and a check that F(A X') is real up to a scalar.
import itertools, json
import numpy as np, sympy as sp

x, y, z, w, c = sp.symbols('x y z w c')
X = sp.Matrix([x, y, z, w])
F = x**4 + y**4 + z**4 + w**4 - (x**2*y**2 + x**2*z**2 + x**2*w**2 + y**2*z**2 + y**2*w**2 + z**2*w**2) + c*x*y*z*w
def Fsub(M):
    v = M*X
    return sp.expand(F.subs({x: v[0], y: v[1], z: v[2], w: v[3]}, simultaneous=True))
even, odd = [], []
for perm in itertools.permutations(range(4)):
    for sg in itertools.product((1, -1), repeat=4):
        M = sp.zeros(4, 4)
        for i in range(4): M[i, perm[i]] = sg[i]
        (even if np.prod(sg) > 0 else odd).append(M)
ok_even = all(sp.expand(Fsub(M) - F) == 0 for M in even)
ok_odd = all(sp.expand(Fsub(M) - F.subs(c, -c)) == 0 for M in odd)
print("192 even signed permutations preserve F exactly:", ok_even, "| 192 odd ones send c -> -c:", ok_odd)

def key(M):   # projective key: M up to sign
    a = np.array(M.tolist(), dtype=int); f = a.flatten(); s = np.sign(f[np.nonzero(f)[0][0]])
    return tuple((s*a).flatten())
G = {key(M): np.array(M.tolist(), dtype=int) for M in even}
print("projective order of the group:", len(G))
I4 = np.eye(4, dtype=int)
nref = 0
for k, g in G.items():
    for s in (1, -1):
        ev = np.sort(np.linalg.eigvals(s*g).real.round(8))
        if np.allclose(ev, [-1, 1, 1, 1]) and np.allclose(s*g @ (s*g), I4):
            nref += 1; break
print("projective reflections in the group:", nref)
nonsym = sum(1 for k, g in G.items() if round(np.linalg.det(g)) == 1)   # det of a 4x4 lift; symplectic part = det 1 (lift choice irrelevant: det(-g)=det g)
print("elements with det = +1 (symplectic part):", nonsym)

# real structures
Odd = {key(M): np.array(M.tolist(), dtype=int) for M in odd}
cands = [h for h in Odd.values() if (np.array_equal(h @ h, I4) or np.array_equal(h @ h, -I4))]
Glist = list(G.values())
classes = []
seen = set()
for h in cands:
    k = key(sp.Matrix(h))
    if k in seen: continue
    orb = set()
    for g in Glist:
        hh = g @ h @ g.T          # g^-1 = g^T for signed permutations
        orb.add(key(sp.Matrix(hh)))
    seen |= orb
    classes.append(dict(rep=h.tolist(), size=len(orb), square=int((h @ h)[0, 0])))
print("involutive h in the odd coset (projectively):", len(cands), "; classes under conjugation:", len(classes))
cS = 3*sp.sqrt(5)*sp.I
out = []
for cl in classes:
    h = sp.Matrix(cl['rep'])
    info = dict(cl)
    if cl['square'] == 1:
        # A = [E+ basis | i * E- basis]
        Ep = (sp.eye(4) + h).columnspace(); Em = (sp.eye(4) - h).columnspace()
        A = sp.Matrix.hstack(*(Ep + [sp.I*v for v in Em]))
        assert sp.simplify(h*A.conjugate() - A) == sp.zeros(4, 4)
        v = A*X
        FA = sp.expand(F.subs(c, cS).subs({x: v[0], y: v[1], z: v[2], w: v[3]}, simultaneous=True))
        coeffs = sp.Poly(FA, x, y, z, w).coeffs()
        lead = coeffs[0]
        real_ok = all(sp.simplify(sp.im(sp.expand(cf/lead))) == 0 for cf in coeffs)
        info.update(A=[[str(e) for e in row] for row in A.tolist()], real_quartic=str(sp.expand(FA/lead)), real_coeffs=real_ok)
    else:
        info.update(A=None, real_quartic=None, note="h^2 = -I: quaternionic, no real points in P^3")
    out.append(info)
    print(info)
json.dump(out, open("realstructs.json", "w"), indent=1)
