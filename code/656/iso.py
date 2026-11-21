# Referee: exact isomorphism test between two weighted complete graphs (Gram matrices)
# by colour refinement + individualisation/backtracking. Prints an explicit permutation
# and verifies GA[p][:,p] == GB entrywise.
import sys, re
import numpy as np

def load_gp(path, name):
    s = open(path).read()
    m = re.search(name + r"\s*=\s*\[(.*?)\];", s, re.S)
    body = m.group(1)
    rows = [list(map(int, r.split(","))) for r in body.split(";")]
    return np.array(rows, dtype=np.int64)

def refine(G, col):
    vals = sorted(set(G.flatten().tolist()))
    n = len(col)
    while True:
        k = col.max() + 1
        sig = [col.copy()]
        for v in vals:
            M = (G == v).astype(np.int64)
            onehot = np.zeros((n, k), dtype=np.int64)
            onehot[np.arange(n), col] = 1
            sig.append(M @ onehot)  # n x k counts
        key = np.hstack([s.reshape(n, -1) for s in sig])
        _, new = np.unique(key, axis=0, return_inverse=True)
        new = new.ravel()
        if new.max() == col.max():
            return new, key
        col = new

def canon_pair(GA, GB):
    n = len(GA)
    ca, ka = refine(GA, np.zeros(n, dtype=np.int64))
    cb, kb = refine(GB, np.zeros(n, dtype=np.int64))
    # align colours by key rows
    def sig(c, k):
        return sorted(map(tuple, np.unique(k, axis=0).tolist()))
    if sig(ca, ka) != sig(cb, kb):
        return None, "refinement signatures differ"
    print("stable cells after refinement:", ca.max() + 1)
    return search(GA, GB, ca, ka, cb, kb, 0), "ok"

def jointrefine(GA, GB, ca, cb):
    # refine both with common colour names: concatenate as disjoint union
    n = len(GA)
    Z = np.full((2 * n, 2 * n), -99, dtype=np.int64)
    Z[:n, :n] = GA; Z[n:, n:] = GB
    col = np.concatenate([ca, cb])
    new, _ = refine(Z, col)
    return new[:n], new[n:]

def search(GA, GB, ca, ka, cb, kb, depth):
    ca, cb = jointrefine(GA, GB, ca, cb)
    if sorted(np.bincount(ca, minlength=ca.max()+1).tolist()) != sorted(np.bincount(cb, minlength=max(ca.max(), cb.max())+1)[:ca.max()+1].tolist()):
        return None
    if not np.array_equal(np.bincount(ca, minlength=2*len(GA)), np.bincount(cb, minlength=2*len(GA))):
        return None
    if ca.max() + 1 == len(set(ca.tolist())) and len(set(ca.tolist())) == len(GA):
        # discrete: map vertex with colour c in A to vertex with colour c in B
        pb = np.empty(len(GA), dtype=np.int64)
        posb = {c: i for i, c in enumerate(cb.tolist())}
        p = np.array([posb[c] for c in ca.tolist()])
        if np.array_equal(GB[np.ix_(p, p)], GA):
            return p
        return None
    counts = np.bincount(ca)
    cells = [c for c in range(len(counts)) if counts[c] > 1]
    c0 = min(cells, key=lambda c: counts[c])
    a = int(np.where(ca == c0)[0][0])
    for b in np.where(cb == c0)[0]:
        na = ca.copy(); nb = cb.copy()
        big = 10 ** 6
        na[a] = big; nb[b] = big
        _, na = np.unique(na, return_inverse=True)
        _, nb2 = np.unique(np.concatenate([na * 0 + 0, nb]), return_inverse=True)
        # recompute names consistently: use joint unique
        joint = np.concatenate([ca.copy(), cb.copy()])
        joint[a] = big; joint[len(GA) + b] = big
        _, joint = np.unique(joint, return_inverse=True)
        r = search(GA, GB, joint[:len(GA)], None, joint[len(GA):], None, depth + 1)
        if r is not None:
            return r
    return None

if __name__ == "__main__":
    GA = load_gp(sys.argv[1], sys.argv[2])
    GB = load_gp(sys.argv[3], sys.argv[4])
    print("shapes", GA.shape, GB.shape, "symmetric", (GA == GA.T).all(), (GB == GB.T).all())
    p, msg = canon_pair(GA, GB)
    print(msg)
    if p is None:
        print("RESULT: NO ISOMORPHISM FOUND")
    else:
        ok = np.array_equal(GB[np.ix_(p, p)], GA)
        print("RESULT: ISOMORPHIC, explicit permutation verified entrywise:", ok)
        np.save(sys.argv[5], p)
