# Referee re-decode of (5.14), independent of design/probe/c656.py.
# Golay code built from the icosahedron ([I | J - A]), not from a cyclic generator.
# Usage: decode514.py <seed> <outprefix>
import sys, itertools, random, json
import numpy as np

seed = int(sys.argv[1]); out = sys.argv[2]
rng = random.Random(seed)

# icosahedron
phi = (1 + 5 ** 0.5) / 2
V = []
for a in (1, -1):
    for b in (phi, -phi):
        V += [(0, a, b), (a, b, 0), (b, 0, a)]
A = np.zeros((12, 12), dtype=int)
for i in range(12):
    for j in range(12):
        d = sum((V[i][k] - V[j][k]) ** 2 for k in range(3))
        if abs(d - 4) < 1e-9:
            A[i, j] = 1
assert all(A.sum(1) == 5)
G = np.hstack([np.eye(12, dtype=int), (1 - A) % 2])
words = set()
for m in range(1 << 12):
    c = np.zeros(24, dtype=int)
    for i in range(12):
        if m >> i & 1:
            c ^= G[i]
    words.add(tuple(c))
wts = {}
for w in words:
    wts[sum(w)] = wts.get(sum(w), 0) + 1
assert wts == {0: 1, 8: 759, 12: 2576, 16: 759, 24: 1}, wts
octads = [frozenset(i for i in range(24) if w[i]) for w in words if sum(w) == 8]

# relabel: O1 -> positions 0..7, O2 -> 6..13, O1&O2 = {6,7}; s = {0,1} in O1 - O2
pairs = [(a, b) for a in octads for b in octads if len(a & b) == 2]
O1, O2 = rng.choice(pairs)
p1 = sorted(O1 - O2); rng.shuffle(p1)
p12 = sorted(O1 & O2); rng.shuffle(p12)
p2 = sorted(O2 - O1); rng.shuffle(p2)
rest = sorted(set(range(24)) - O1 - O2); rng.shuffle(rest)
order = p1 + p12 + p2 + rest          # new index k <- old index order[k]
newoct = [frozenset(order.index(i) for i in o) for o in octads]
assert frozenset(range(8)) in newoct and frozenset(range(6, 14)) in newoct

# doubled coordinates (d = 2x); N product x.y = sum d d' / 2 (A1 roots of norm 2)
def dot(d1, d2):
    return sum(a * b for a, b in zip(d1, d2)) / 2

h = [2, 2] + [0] * 22
v2 = [2] + [0] * 23                         # e1
v3 = [0] * 6 + [2] + [0] * 17               # e7
v4 = [0] * 6 + [1, -1] + [1] * 6 + [0] * 10  # (e7 - e8 + e9..e14)/2
v5 = [1] * 24                                # (e1..e24)/2
gens = [v2, v3, v4, v5]

O = []
for i in (0, 1):
    for j in range(2, 24):
        for sg in (1, -1):
            d = [0] * 24; d[i] = 2; d[j] = 2 * sg; O.append(d)
for o in newoct:
    if 0 in o and 1 in o:
        rest6 = sorted(o - {0, 1})
        for signs in itertools.product((1, -1), repeat=6):
            d = [0] * 24; d[0] = 1; d[1] = 1
            for k, s_ in zip(rest6, signs):
                d[k] = s_
            O.append(d)
assert all(dot(d, d) == 4 and dot(d, h) == 2 for d in O)
C = [d for d in O if all(2 * dot(d, v) == dot(h, v) for v in gens)]
print("seed", seed, "|O_h| =", len(O), "|C| =", len(C))
json.dump({"h2": h, "conics2": C}, open(out + ".json", "w"))
# NS Gram of conics: c.c' = 2 - l.l'
with open(out + "_gram.gp", "w") as f:
    rows = []
    for a in C:
        rows.append(",".join(str(int(2 - dot(a, b))) for b in C))
    f.write("GR=[" + ";".join(rows) + "];\n")
    f.write("M=[" + ";".join(",".join(map(str, d)) for d in C) + "];\n")
