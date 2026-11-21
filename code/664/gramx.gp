\\ gramx.gp (CERT664): EXACT Gram; run after exact.gp (read("exact.gp"); read("gramx.gp")).
\\ ---------- EXACT Gram
N = #CON;
G = matrix(N, N);
for (j = 1, N, G[j, j] = -2);
for (j = 1, #PL, G[PL[j][1], PL[j][2]] = 4; G[PL[j][2], PL[j][1]] = 4);
\\ restriction of conic c (in its plane coordinates) to the point X: Q(X_keep)
qeval(c, X) = { my(keep = select(i -> i != c[3], [1..4]), v = vector(3, m, X[keep[m]])); v * sym3(c[2]) * v~; }
\\ v2 rule: C, A smooth curves on the smooth surface X, C in plane 1, A in plane 2, ell = plane1 cap plane2.
\\ The scheme C cap A has ideal I_C + I_A, which contains F and the two linear forms, so it lives on ell and is cut
\\ out there by (q_C, q_A); and since C, A are Cartier on X, its length at p is (C.A)_p.  Hence
\\ C.A = deg gcd(q_C, q_A) exactly.  Consistency: deg gcd(q_C, q_A) + deg gcd(q_C, q_B) = C.h = 2.
ent(qC, qA, qB) = {
  my(dA = poldegree(gcd(qC, qA)), dB = poldegree(gcd(qC, qB)));
  if (dA + dB != 2, return(-99));
  if (dA == 1 && dB == 1 && poldegree(gcd(gcd(qC, qA), qB)) == 1, NTRIPLE++);
  dA;
}
NTRIPLE = 0;
nund = 0; nasym = 0;
{
my(tt = getabstime());
for (a = 1, #PL, if (a % 20 == 0, print("  plane ", a, " of ", #PL, ", ms ", getabstime() - tt)); for (b = a + 1, #PL,
  my(ca = [CON[PL[a][1]], CON[PL[a][2]]], cb = [CON[PL[b][1]], CON[PL[b][2]]], n1 = ca[1][1], n2 = cb[1][1], Mn = matrix(2, 4, i, j, if (i == 1, n1[j], n2[j])), idx = 0, mn, Pp, Rr, rest, lam, q, e);
  \\ choose a pivot pair (i1, i2) with nonzero 2x2 minor
  forvec(ij = [[1, 4], [1, 4]], if (Mn[1, ij[1]]*Mn[2, ij[2]] - Mn[1, ij[2]]*Mn[2, ij[1]] != 0, idx = ij; break), 2);
  my(i1 = idx[1], i2 = idx[2], free = select(i -> i != i1 && i != i2, [1..4]), Ms = matconcat([Mn[, i1], Mn[, i2]]), Msi = Ms^-1, pts = vector(2));
  for (m = 1, 2, my(X = vector(4), sol); X[free[m]] = 1; sol = -Msi * Mn[, free[m]]; X[i1] = sol[1]; X[i2] = sol[2]; pts[m] = X);
  Pp = pts[1]; Rr = pts[2];
  lam = 0;
  while (1,
    my(PP = Pp + lam*Rr, okl = 1);
    q = vector(4);
    for (m = 1, 4, my(c = if (m <= 2, ca[m], cb[m - 2])); q[m] = qeval(c, s*PP + Rr); if (polcoef(q[m], 2, s) == 0, okl = 0));
    if (okl, break); lam++);
  \\ from the side of plane a and from the side of plane b
  for (m = 1, 2,
    my(e1 = ent(q[m], q[3], q[4]), e2 = ent(q[m + 2], q[1], q[2]));
    if (e1 < 0 || e2 < 0, nund++);
    G[PL[a][m], PL[b][1]] = e1; G[PL[a][m], PL[b][2]] = 2 - e1;
    G[PL[b][m], PL[a][1]] = e2; G[PL[b][m], PL[a][2]] = 2 - e2)));
print("Gram time (ms): ", getabstime() - tt);
}
print("entries failing the sum rule: ", nund, "   Gram symmetric: ", G == G~, "   (conic, plane) incidences at a point of C cap C' cap C'' (each 1+1): ", NTRIPLE);
tally = Map(); for (i = 1, N, for (j = 1, N, my(v = G[i, j]); mapput(tally, v, if (mapisdefined(tally, v), mapget(tally, v), 0) + 1)));
print("value counts: ", Mat(tally));
{
my(ff = fileopen("gram_exact.gp", "w"));
filewrite(ff, Str("Gc = ", G, ";"));
filewrite(ff, Str("hc = ", vector(N, j, (j == PL[1][1]) || (j == PL[1][2]))~, ";"));
fileclose(ff);
}
print("EXACT_DONE");
