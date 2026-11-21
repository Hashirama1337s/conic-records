# RAID-656 design probe: rebuild Degtyarev's configuration (5.14) of arXiv 2407.00493v2
# directly from the pictograph (Convention 5.6, condition (5.3)) inside N(24A1) = Golay lattice.
# No GAP needed. Pure Python, exact rationals (coordinates doubled to integers).
# Output: counts, Gram invariants, det of span, and a gp script for automorphisms.
import itertools, random, sys, json
from fractions import Fraction

# --- extended binary Golay code from g(x) = 1+x^2+x^4+x^5+x^6+x^10+x^11 (cyclic [23,12,7]) ---
g = [0, 2, 4, 5, 6, 10, 11]
gens = []
for s in range(12):
    w = 0
    for e in g:
        w |= 1 << (e + s)
    if bin(w).count("1") % 2:
        w |= 1 << 23           # parity bit
    gens.append(w)
code = {0}
for gw in gens:
    code |= {c ^ gw for c in code}
assert len(code) == 4096
wts = {}
for c in code:
    wts[bin(c).count("1")] = wts.get(bin(c).count("1"), 0) + 1
assert wts == {0: 1, 8: 759, 12: 2576, 16: 759, 24: 1}, wts
octads = [frozenset(i for i in range(24) if c >> i & 1) for c in code if bin(c).count("1") == 8]

def labelling(rng):
    """random relabelling pi: old index -> new position 1..24 with {1..8},{7..14} octads."""
    while True:
        O1 = rng.choice(octads); O2 = rng.choice(octads)
        if len(O1 & O2) == 2:
            break
    A = sorted(O1 - O2); rng.shuffle(A)       # -> 1..6
    I = sorted(O1 & O2); rng.shuffle(I)       # -> 7,8
    B = sorted(O2 - O1); rng.shuffle(B)       # -> 9..14
    R = sorted(set(range(24)) - O1 - O2); rng.shuffle(R)  # -> 15..24
    order = A + I + B + R                     # order[p-1] = old index at new position p
    return order

def build(order):
    pos_oct = [frozenset(order.index(i) + 1 for i in o) for o in octads]  # octads in new labels 1..24
    assert frozenset(range(1, 9)) in pos_oct and frozenset(range(7, 15)) in pos_oct
    # vectors stored as dict pos->Fraction coefficient on e_pos; e_i.e_j = 2 delta_ij
    def dot(a, b):
        return sum(2 * a[k] * b.get(k, 0) for k in a)
    F = Fraction
    h = {1: F(1), 2: F(1)}
    v2 = {1: F(1)}
    CFG = __import__("os").environ.get("CFG", "5.13")
    if CFG == "5.14":
        v3 = {7: F(1)}
        v4 = {7: F(1, 2), 8: F(-1, 2)}; v4.update({k: F(1, 2) for k in range(9, 15)})
        v5 = {k: F(1, 2) for k in range(1, 25)}
    elif CFG == "5.10":  # 736: row3 bullet col 4; row4 '-' cols 1,2,4..8, '=' col 3; row5 all '-'
        v3 = {4: F(1)}
        v4 = {k: F(1, 2) for k in range(1, 9)}; v4[3] = F(-1, 2)
        v5 = {k: F(1, 2) for k in range(1, 25)}
    elif CFG == "5.8":   # control: 800, det 160
        v3 = {3: F(1)}
        v4 = {k: F(1, 2) for k in range(1, 9)}
        v5 = {k: F(1, 2) for k in range(1, 25)}
    else:  # (5.13): row3 bullet col 3; row4 dashes cols 1-8; row5 dashes, '+' (3/2) at col 9
        v3 = {3: F(1)}
        v4 = {k: F(1, 2) for k in range(1, 9)}
        v5 = {k: F(1, 2) for k in range(1, 25)}; v5[9] = F(3, 2)
    orth = [h, v2, v3, v4, v5]
    # all conics O_h: e_i +- e_j (i in s={1,2}, j not in s) and (5.5)
    Oh = []
    for i in (1, 2):
        for j in range(3, 25):
            for sg in (1, -1):
                Oh.append({i: F(1), j: F(sg)})
    for o in pos_oct:
        if 1 in o and 2 in o:
            rest = sorted(o - {1, 2})
            for signs in itertools.product((1, -1), repeat=6):
                l = {1: F(1, 2), 2: F(1, 2)}
                l.update({k: F(s, 2) for k, s in zip(rest, signs)})
                Oh.append(l)
    for l in Oh:
        assert dot(l, l) == 4 and dot(l, h) == 2
    C = [l for l in Oh if all(2 * dot(l, v) == dot(h, v) for v in orth)]
    return Oh, C, h, orth, dot

def hnf_rank_det(vecs):
    """vecs: integer lists. returns integer row basis (echelon) of the Z-span."""
    rows = [list(v) for v in vecs]
    basis = []
    ncol = len(rows[0])
    col = 0
    while rows and col < ncol:
        nz = [r for r in rows if r[col] != 0]
        z = [r for r in rows if r[col] == 0]
        while len(nz) > 1:
            nz.sort(key=lambda r: abs(r[col]))
            p = nz[0]
            new = [p]
            for r in nz[1:]:
                q = r[col] // p[col]
                r2 = [a - q * b for a, b in zip(r, p)]
                if r2[col] != 0:
                    new.append(r2)
                elif any(r2):
                    z.append(r2)
            nz = new
        if nz:
            basis.append(nz[0])
        rows = [r for r in z if any(r)]
        col += 1
    return basis

def det_int(M):
    M = [[Fraction(x) for x in r] for r in M]; n = len(M); d = Fraction(1)
    for c in range(n):
        p = next((r for r in range(c, n) if M[r][c] != 0), None)
        if p is None:
            return 0
        if p != c:
            M[c], M[p] = M[p], M[c]; d = -d
        d *= M[c][c]
        for r in range(c + 1, n):
            f = M[r][c] / M[c][c]
            if f:
                M[r] = [a - f * b for a, b in zip(M[r], M[c])]
    return d

def main():
    rng = random.Random(int(sys.argv[1]) if len(sys.argv) > 1 else 1)
    results = []
    for trial in range(int(sys.argv[2]) if len(sys.argv) > 2 else 4):
        order = labelling(rng) if trial else list(range(24))
        try:
            Oh, C, h, orth, dot = build(order)
        except AssertionError:
            # identity labelling may not have the octads; skip
            continue
        G = [[dot(a, b) for b in C] for a in C]
        degs = sorted(sorted(row).__repr__() for row in G)
        prof = {}
        for row in G:
            key = tuple(sorted({x: row.count(x) for x in set(row)}.items()))
            prof[key] = prof.get(key, 0) + 1
        results.append((len(Oh), len(C), sorted(prof.items())))
        print("trial", trial, "|O_h| =", len(Oh), "|C| =", len(C))
        for k, v in sorted(prof.items()):
            print("   row profile (N-dot: count) ", dict(k), "x", v)
    # lattice data for the last trial
    vecs = [[int(2 * l.get(k, 0)) for k in range(1, 25)] for l in C] + [[int(2 * h.get(k, 0)) for k in range(1, 25)]]
    B = hnf_rank_det(vecs)
    print("rank span_Z(C u h) =", len(B))
    gram = [[Fraction(sum(a[k] * b[k] for k in range(24)), 2) for b in B] for a in B]  # (x/2).(y/2)*2 = x.y/2
    dN = det_int(gram)
    print("det span in N-form =", dN)
    # NS (modified back) form: x o y = (1/2)(x.h)(y.h) - x.y ; hvec in doubled coords
    hv = vecs[-1]
    xh = [Fraction(sum(a[k] * hv[k] for k in range(24)), 2) for a in B]
    gramNS = [[xh[i] * xh[j] / 2 - gram[i][j] for j in range(len(B))] for i in range(len(B))]
    print("det span in NS-form =", det_int(gramNS))
    # NS-form conic Gram: 2 - l.l'
    vals = sorted({2 - x for row in G for x in row})
    print("NS conic-conic intersection values:", vals)
    # write conic list (doubled integer coords) for later stages
    with open(sys.argv[3] if len(sys.argv) > 3 else "conics656.json", "w") as f:
        json.dump({"h2": vecs[-1], "conics2": vecs[:-1], "basis2": B}, f)

main()
