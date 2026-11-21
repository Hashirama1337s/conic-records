\\ realpic.gp (CERT664): the real picture, EXACT reality test.
\\ Real structures of X664 (group.py): sigma_h = h o conj, h in the odd signed-permutation coset with h^2 = I,
\\ two classes: h1 = diag(-1,-1,-1,1) (the given real form, w -> i w) and h2 = (x -> -x, y -> y, z <-> -w).
\\ Complex conjugation on L = Q(i, sqrt3, sqrt5) is the Galois element i -> -i (sqrt3, sqrt5 real).
\\ A conic C is sigma_h-real iff canon(h conj(C)) == canon(C) exactly.  For a real conic, X = A X' with
\\ h conj(A) = A gives real coordinates; the plane and conic in X' are real after normalisation (checked exactly),
\\ and their coordinates are exported for certified sign checks (ballreal.py).
\\ run as: (echo "DOGRAM = 0;"; cat exact.gp realpic.gp) > realpic_all.gp
cj(a) = gal(a, [1, 0, 0]);
cjv(v) = apply(cj, v);
cjm(M) = matrix(#M[, 1], #M, i, j, cj(M[i, j]));
H = [matdiagonal([-1, -1, -1, 1]), [-1, 0, 0, 0; 0, 1, 0, 0; 0, 0, 0, -1; 0, 0, -1, 0]];
AA = [[0, 2*eI, 0, 0; 0, 0, 2*eI, 0; 0, 0, 0, 2*eI; 2, 0, 0, 0], [0, 0, 2*eI, 0; 2, 0, 0, 0; 0, 1, 0, eI; 0, -1, 0, eI]];
{
for (s = 1, 2,
  my(h = H[s], A = AA[s], nreal = 0, nrealpl = 0, perorb = Map(), fo = Str("realconics_h", s, ".txt"), ff = fileopen(fo, "w"));
  print("structure h", s, ": h conj(A) == A: ", h * cjm(A) == A, "; h^2 = I: ", h^2 == matid(4));
  for (j = 1, #CON,
    my(c = CON[j], M = embed4(c[3], c[2]), im = canon(h * Col(cjv(c[1])), h * cjm(M) * h~), ck = Str(lk(im[1]), lk(im[2])), ij = mapget(CKEY, ck));
    if (lk(im[1]) == lk(c[1]), nrealpl++);
    if (ij == j,
      nreal++;
      my(n2 = A~ * Col(c[1]), M2 = A~ * M * A, cr = canon(n2, M2));
      if (cjv(cr[1]) != cr[1] || cjv(cr[2]) != cr[2], error("real coordinates not real at conic ", j));
      filewrite(ff, Str([j, c[4], cr[3], vector(4, i, tocoords(cr[1][i])~), vector(6, i, tocoords(cr[2][i])~)]));
      mapput(perorb, c[4], if (mapisdefined(perorb, c[4]), mapget(perorb, c[4]), 0) + 1)));
  fileclose(ff);
  print("structure h", s, ": sigma-real conics ", nreal, " of ", #CON, ";  conics whose plane is sigma-real ", nrealpl, ";  real conics per orbit ", Mat(perorb)));
}
print("REALPIC_DONE");
