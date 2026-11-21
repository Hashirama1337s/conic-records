\\ exact.gp (CERT664): exact recognition of the 17 orbit representatives over L = Q(i, sqrt3, sqrt5),
\\ exact identities F|plane = mu*Q1*Q2, smoothness, orbit closure under the 192 exact symmetries,
\\ exact distinctness of planes and conics, and an EXACT intersection Gram (resultants/gcds over L).
default(parisizemax, 6000000000);
if (type(DOGRAM) == "t_POL", DOGRAM = 1);
read("hipol.gp");
dummy = [x, y, z, w, u0, u1, u2, s];
t = varlower("t");
\\ ---------- the field L = Q(theta), theta = i + sqrt3 + sqrt5
P2 = polresultant(y^2 + 1, (x - y)^2 - 3, y);
P3 = polresultant(subst(P2, x, y), (x - y)^2 - 5, y);
Pt = subst(P3, x, t);
print("P(t) = ", Pt, "   irreducible: ", polisirreducible(Pt), "   degree: ", poldegree(Pt));
th0 = I + sqrt(3) + sqrt(5);
print("|P(theta0)| = ", abs(subst(Pt, t, th0)));
pickroot(f, target) = {
  my(R = nfroots(Pt, f), best = 0, bd = 1e9);
  for (j = 1, #R, my(d = abs(subst(lift(R[j]), t, th0) - target)); if (d < bd, bd = d; best = R[j]));
  if (bd > 1e-100, error("no matching root"));
  Mod(lift(best), Pt);
}
eI = pickroot(x^2 + 1, I); e3 = pickroot(x^2 - 3, sqrt(3)); e5 = pickroot(x^2 - 5, sqrt(5));
print("checks: eI^2 = ", eI^2, ", e3^2 = ", e3^2, ", e5^2 = ", e5^2, ", eI + e3 + e5 = ", lift(eI + e3 + e5));
Bnum = [1, I, sqrt(3), I*sqrt(3), sqrt(5), I*sqrt(5), sqrt(3)*sqrt(5), I*sqrt(3)*sqrt(5)];
Bex = [Mod(1, Pt), eI, e3, eI*e3, e5, eI*e5, e3*e5, eI*e3*e5];
\\ coordinates of an element of L in the basis Bex
Mbas = matrix(8, 8, i, j, polcoef(lift(Bex[j]), i - 1, t));
Mbinv = Mbas^-1;
tocoords(a) = Mbinv * vector(8, i, polcoef(lift(Mod(a, Pt)), i - 1, t))~;
cE = 3 * eI * e5;
F(X) = X[1]^4 + X[2]^4 + X[3]^4 + X[4]^4 - (X[1]^2*X[2]^2 + X[1]^2*X[3]^2 + X[1]^2*X[4]^2 + X[2]^2*X[3]^2 + X[2]^2*X[4]^2 + X[3]^2*X[4]^2) + cE*X[1]*X[2]*X[3]*X[4];
U = [u0, u1, u2];
MON2 = [u0^2, u0*u1, u0*u2, u1^2, u1*u2, u2^2];
sym3(q) = [q[1], q[2]/2, q[3]/2; q[2]/2, q[4], q[5]/2; q[3]/2, q[5]/2, q[6]];
\\ ---------- recognition
lindep330(v) = localprec(330); lindep(concat([v], Bnum));
recog(v) = {
  my(rel = lindep330(v), res);
  if (#rel == 0 || rel[1] == 0, error("no relation"));
  res = abs(rel[1]*v + sum(k = 1, 8, rel[k+1]*Bnum[k]));
  if (res > 1e-390, error("holdout failed ", res));
  RECH = max(RECH, vecmax(abs(rel))); RECRES = max(RECRES, res);
  if (abs(v) > 1e-300, my(vn = v + 1e-200*Pi, reln = lindep330(vn), resn);
    resn = if (#reln == 0 || reln[1] == 0, 1, abs(reln[1]*vn + sum(k = 1, 8, reln[k+1]*Bnum[k])));
    NNULL++; if (resn > 1e-390, NREJ++));
  -sum(k = 1, 8, rel[k+1]*Bex[k]) / rel[1];
}
RECH = 0; RECRES = 0.; NNULL = 0; NREJ = 0;
print("working precision (digits): ", default(realprecision));
REPS = vector(#HP);
nid = 0;
{
for (r = 1, #HP,
  my(o = HP[r][1], sz = HP[r][2], wh = HP[r][3], k = HP[r][4] + 1, vals = HP[r][7], ex, n, q1, q2, mu, keep, X, D, Q1, Q2, d1, d2, prop);
  ex = vector(17, j, recog(vals[j]));
  n = ex[1..4]; q1 = ex[5..10]; q2 = ex[11..16]; mu = ex[17];
  if (n[k] != 1, error("pivot"));
  keep = select(i -> i != k, [1..4]);
  X = vector(4); for (j = 1, 3, X[keep[j]] = U[j]); X[k] = -sum(j = 1, 3, n[keep[j]] * U[j]);
  Q1 = sum(i = 1, 6, q1[i]*MON2[i]); Q2 = sum(i = 1, 6, q2[i]*MON2[i]);
  D = F(X) - mu*Q1*Q2;
  d1 = matdet(sym3(q1)); d2 = matdet(sym3(q2));
  prop = (matrank(matrix(2, 6, i, j, if (i == 1, q1[j], q2[j]))) < 2);
  print("orbit ", o, " size ", sz, ": F|plane - mu Q1 Q2 == 0: ", D == 0, "; det Q1 != 0: ", d1 != 0, "; det Q2 != 0: ", d2 != 0, "; Q1, Q2 proportional: ", prop);
  if (D != 0 || d1 == 0 || d2 == 0 || prop, error("exact check failed at orbit ", o));
  nid++;
  REPS[r] = [o, sz, wh, k, n, q1, q2, mu]);
print("EXACT identities verified: ", nid, " of ", #HP);
print("recognition: max height ", RECH, ", max holdout residual (full precision) ", RECRES, ", perturbation null rejected ", NREJ, " of ", NNULL);
}
\\ ---------- fields of definition per orbit: Galois group of L = {i -> +-i, sqrt3 -> +-sqrt3, sqrt5 -> +-sqrt5}
gal(a, e) = { my(cf = tocoords(a)); sum(k = 1, 8, cf[k] * ((-1)^(e[1]*((k-1)%2) + e[2]*(((k-1)\2)%2) + e[3]*(((k-1)\4)%2))) * Bex[k]); }
GAL = [[a, b, c] | a <- [0, 1]; b <- [0, 1]; c <- [0, 1]];
fixgroup(lst) = select(e -> vector(#lst, j, gal(lst[j], e)) == lst, GAL);
{
for (r = 1, #REPS,
  my(R = REPS[r], cq = if (R[3] == 1, R[6], R[7]), Hp = fixgroup(R[5]), Hc = fixgroup(concat(R[5], cq)));
  print("orbit ", R[1], " size ", R[2], ": Gal-stabiliser of plane ", Hp, "  of plane+conic ", Hc));
}
\\ ---------- orbit closure, exact canonical forms
SG = List();
{forperm([1, 2, 3, 4], p, forvec(sg = vector(4, i, [0, 1]), if (vecsum(sg) % 2 == 1, next);
   listput(SG, matrix(4, 4, i, j, if (j == p[i], (-1)^sg[i], 0)))));}
SG = Vec(SG); print("symmetry matrices: ", #SG);
embed4(k, q) = { my(keep = select(i -> i != k, [1..4]), E = matrix(4, 3, i, j, i == keep[j])); E * sym3(q) * E~; }
canon(n, M) = {
  my(f = 1, nn, keep, T, Mq, qv, g = 0);
  while (n[f] == 0, f++);
  nn = n / n[f];
  keep = select(i -> i != f, [1..4]);
  T = matrix(4, 3, i, j, if (i == keep[j], 1, if (i == f, -nn[keep[j]], 0)));
  Mq = T~ * M * T;
  qv = [Mq[1,1], 2*Mq[1,2], 2*Mq[1,3], Mq[2,2], 2*Mq[2,3], Mq[3,3]];
  for (j = 1, 6, if (qv[j] != 0, g = qv[j]; break));
  qv = qv / g;
  [nn, qv, f];
}
lk(v) = Str(apply(a -> lift(Mod(a, Pt)), v));
CON = List(); CKEY = Map(); PKEY = Map(); NPL = 0;
{
for (r = 1, #REPS,
  my(R = REPS[r], k = R[4], n = R[5]);
  foreach([R[6], R[7]], q,
    my(M = embed4(k, q));
    for (gi = 1, #SG,
      my(g = SG[gi], cn = canon(g * n~, g * M * g~), ck = Str(lk(cn[1]), lk(cn[2])), pk = lk(cn[1]));
      if (!mapisdefined(CKEY, ck),
        if (!mapisdefined(PKEY, pk), NPL++; mapput(PKEY, pk, NPL));
        listput(CON, [cn[1], cn[2], cn[3], R[1], mapget(PKEY, pk)]); mapput(CKEY, ck, #CON)))));
}
PL = vector(NPL, j, []); for (j = 1, #CON, PL[CON[j][5]] = concat(PL[CON[j][5]], j));
print("distinct conics (exact canonical forms): ", #CON, "   distinct planes: ", #PL);
print("conics per plane: ", Set(vector(#PL, j, #PL[j])));
\\ every conic smooth (det of canonical 3x3 != 0)
print("all conics smooth (det != 0 exactly): ", vecprod(vector(#CON, j, matdet(sym3(CON[j][2])) != 0)));
\\ the two conics on each plane are the two factors: check F|plane = mu*Q1*Q2 for every plane (cheap, exact)
okall = 1;
{
for (j = 1, #PL,
  my(a = CON[PL[j][1]], b = CON[PL[j][2]], f = a[3], n = a[1], keep = select(i -> i != f, [1..4]), X = vector(4), G, Q1, Q2, mu);
  for (m = 1, 3, X[keep[m]] = U[m]); X[f] = -sum(m = 1, 3, n[keep[m]] * U[m]);
  G = F(X); Q1 = sum(i = 1, 6, a[2][i]*MON2[i]); Q2 = sum(i = 1, 6, b[2][i]*MON2[i]);
  my(P12 = Q1*Q2, pt = [1, 2, 5], den);
  den = substvec(P12, U, pt); if (den == 0, pt = [3, -7, 11]; den = substvec(P12, U, pt)); if (den == 0, error("den"));
  mu = substvec(G, U, pt) / den;
  if (G - mu*P12 != 0, okall = 0; print("plane ", j, " FAILS")));
print("all 332-type planes: F|plane = mu*Q1*Q2 exactly: ", okall);
}
\\ ---------- export exact data (coordinates in the basis Bex) for the ball-arithmetic and Singular replays
{
if (DOGRAM, my(ff = fileopen("conics_exact.txt", "w"));
for (j = 1, #CON,
  my(c = CON[j]);
  filewrite(ff, Str([j, c[3], c[4], vector(4, i, tocoords(c[1][i])~), vector(6, i, tocoords(c[2][i])~)])));
fileclose(ff);
print("wrote conics_exact.txt");
ff = fileopen("reps_exact.txt", "w");
for (r = 1, #REPS,
  my(R = REPS[r]);
  filewrite(ff, Str([R[1], R[2], R[3], R[4], vector(4, i, tocoords(R[5][i])~), vector(6, i, tocoords(R[6][i])~), vector(6, i, tocoords(R[7][i])~), tocoords(R[8])~])));
fileclose(ff);
print("wrote reps_exact.txt");
ff = fileopen("planes_exact.txt", "w");
for (j = 1, #PL, filewrite(ff, Str([PL[j][1], PL[j][2]])));
fileclose(ff));
}
print("EXACT_PART1_DONE");
