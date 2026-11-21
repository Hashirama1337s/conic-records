\\ recog2.gp (EXACT seat, RAID-656, route E2): exact recognition + exact verification of the 30 orbit representatives.
\\ Surface (E-form over K): F_E = E W^4 - E q W^2 + q^2 + t p4, t real root of 9t^3+48t^2+125t+122,
\\   E = (1688-1140t-1044t^2)/361.  Real isomorphism with X-: w = sqrt(e') W, e' = +sqrt(E) (s = sqrt(e') > 0).
\\ K = Q(u), u = 9t, u^3 + 48u^2 + 1125u + 9882 = 0.
\\ Data (valsE400.gp): plane NE (pivot coefficient 1), Qrep, Qres (each normalised: largest coefficient 1), QL = mu,
\\   with F_E|plane = mu * Qrep * Qres; plane coordinates (x,y,z) = the three coordinates other than the pivot, in order.
\\ Step A: for every value, its degree over K (1 or 2) via lindep at RDIG digits, discriminant Delta in K;
\\   Delta classes mod K*^2 -> generators d_1..d_r; field N = K(sqrt d_1, ..., sqrt d_r).
\\ Step B: every value recognised in the Q-basis t^i prod_{j in S} sqrt(d_j) of N (lindep at RDIG digits), holdout at FULL
\\   digits, perturbation null (value + 10^-PERT must FAIL).
\\ Step C (EXACT): in the absolute field N = Q(theta): F_E|plane - mu*Qrep*Qres == 0; det != 0; non-proportional;
\\   real points via exact leading minors with signs from the real embedding.
default(parisizemax, 4000000000)
x;y;z;
vR = varlower("vR"); vK = varlower("vK");
\p 410
read("valsE400.gp");
FULL = 395; RDIG = 330; PERT = 200;
Tu = vK^3 + 48*vK^2 + 1125*vK + 9882;
nfK = nfinit(Tu);
tn = tt; un = 9*tn;
BK = [1, tn, tn^2];
isint(q) = type(q) == "t_INT";

rec(v, B) =
{
  my(V = concat([v], B), Vt, L, r);
  if (abs(v) < 10^-(FULL-5), return(vector(#B)));
  Vt = apply(a -> precision(a, RDIG), V);
  L = lindep(Vt);
  if (#L == 0 || L[1] == 0, return(0));
  r = abs(L~ * V~) / vecmax(abs(V));
  if (r > 10^-(FULL-10), return(0));
  -vector(#B, i, L[i+1]) / L[1];
}
ht(q) = if (isint(q), -1, my(m = 1); for (i = 1, #q, m = max(m, max(abs(numerator(q[i])), abs(denominator(q[i]))))); m);
Kel(q) = Mod(q[1] + q[2]*vK/9 + q[3]*vK^2/81, Tu);      \\ element of K from coordinates in (1, t, t^2)
Knum(a) = subst(lift(a), vK, un);

\\ quadratic relation over K: v^2 + s v + p = 0, s, p in K; returns Delta = s^2 - 4p (element of K) or 0
quadK(v) =
{
  my(B = [v, tn*v, tn^2*v, 1, tn, tn^2], q = rec(v^2, B), s, p);
  if (isint(q), return(0));
  s = -Kel([q[1], q[2], q[3]]); p = -Kel([q[4], q[5], q[6]]);
  s^2 - 4*p;
}
issqK(a) = if (a == 0, 1, #nfroots(nfK, vR^2 - lift(a)) > 0);

SYM = List();
{
  forperm(3, p, forvec(sg = vector(3, i, [0, 1]),
    my(g = matrix(4, 4)); g[4, 4] = 1;
    for (i = 1, 3, g[i, p[i]] = (-1)^sg[i]);
    listput(SYM, g)));
}
MON = [x^2, x*y, x*z, y^2, y*z, z^2];
symm(Q) = { my(c = vector(6, j, polcoef(polcoef(polcoef(Q, [2,1,1,0,0,0][j], x), [0,1,0,2,1,0][j], y), [0,0,1,0,1,2][j], z)));
  [c[1], c[2]/2, c[3]/2; c[2]/2, c[4], c[5]/2; c[3]/2, c[5]/2, c[6]]; }
summary = List(); allplanes = List(); minminor = 10^10; mind = 10^10;
\ which basis blocks (1, sqrt d2, sqrt d1, sqrt d1 d2 for r = 2; 1, sqrt d1 for r = 1) occur in a set of coordinate vectors
supp(L, r) = { my(nb = 2^r, u = vector(nb));
  for (i = 1, #L, for (b = 0, nb - 1, for (m = 1, 3, if (L[i][3*b + m] != 0, u[b + 1] = 1))));
  u; }
texf(q, r, sqd, tK) =
{
  my(s = 0, idx = 0);
  forvec(e = vector(r, j, [0, 1]), my(pr = prod(j = 1, r, if (e[j], sqd[j], 1))); for (m = 0, 2, idx++; s += q[idx]*tK^m*pr));
  s;
}
evf(m, P, thr) = if (type(m) == "t_POLMOD", subst(lift(m), variable(P), thr), m);

{
for (i = 1, NR,
  my(vals = concat(concat(concat(NE[i], QR[i]), QS[i]), [QL[i]]), nv = #vals, ds = List(), qs, bad, r, sq, B, sub, P, a, k, rel,
     th, thr, tK, sqd, tex, ev, nex, Qr, Qs, mu, X, G, zero, M1, M2, d1, d2, rk, rp, hmax, nt, kk, keep, alpha, alr, relpol, dnum);
  \\ Step A: discriminant classes
  for (j = 1, nv, my(v = vals[j]); if (abs(v) < 10^-(FULL-5), next);
    if (!isint(rec(v, BK)), next);
    my(D = quadK(v)); if (D == 0, next);
    my(new = 1);
    for (m = 1, #ds, if (issqK(D/ds[m]), new = 0; break));
    \\ also skip if D is a square times a product of two existing generators
    if (new && #ds >= 2, for (m1 = 1, #ds, for (m2 = m1+1, #ds, if (issqK(D/(ds[m1]*ds[m2])), new = 0))));
    if (new, listput(ds, D)));
  r = #ds;
  \\ positivity at the real embedding (real square roots)
  dnum = vector(r, j, Knum(ds[j]));
  sq = vector(r, j, sqrt(dnum[j]));
  B = List();
  forvec(e = vector(r, j, [0, 1]), my(pr = prod(j = 1, r, if (e[j], sq[j], 1))); for (m = 0, 2, listput(B, tn^m*pr)));
  B = Vec(B);
  qs = vector(nv, j, rec(vals[j], B));
  bad = select(isint, qs, 1);
  if (#bad, print("orbit ", ORB[i], ": ", #bad, " values not recognised over N, r = ", r); listput(summary, [ORB[i], "FAIL"]); next);
  hmax = vecmax(apply(ht, qs));
  \\ perturbation null on every nonzero value
  nt = [0, 0]; for (j = 1, nv, if (abs(vals[j]) < 10^-(FULL-5), next); nt[2]++;
    if (isint(rec(vals[j] + 10^-PERT*Pi*(1 + j/7), B)), nt[1]++));
  \\ Step C: absolute field
  if (r == 0,
    P = Tu; tK = Mod(vK, Tu)/9; sqd = []; thr = un;
  , if (r == 1,
    relpol = vR^2 - lift(ds[1]); alr = sq[1];
  , if (r == 2,
    relpol = (vR^2 - lift(ds[1]) - lift(ds[2]))^2 - 4*lift(ds[1])*lift(ds[2]); alr = sq[1] + sq[2];
  , error("r > 2")));
    rel = rnfequation(nfK, relpol, 1); P = rel[1]; a = Mod(lift(rel[2]), P); k = rel[3];
    thr = alr + k*un;
    tK = a/9; alpha = Mod(vR, P) - k*a;
    my(dK = vector(r, j, subst(lift(ds[j]), vK, a)));
    if (r == 1, sqd = [alpha], my(s1 = (alpha^2 + dK[1] - dK[2])/(2*alpha)); sqd = [s1, alpha - s1]);
  );
  if (abs(subst(P, variable(P), thr)) > 10^-300 * abs(subst(P', variable(P), thr)), print("orbit ", ORB[i], ": theta_real not a root"));
  \\ consistency of the embedding: sqd numerically = sq
  for (j = 1, r, if (abs(evf(sqd[j], P, thr) - sq[j]) > 10^-300, print("orbit ", ORB[i], ": embedding mismatch ", j)));
  my(Eex = (1688 - 1140*tK - 1044*tK^2)/361);
  nex = vector(4, j, texf(qs[j], r, sqd, tK));
  Qr = sum(j = 1, 6, texf(qs[4 + j], r, sqd, tK)*MON[j]);
  Qs = sum(j = 1, 6, texf(qs[10 + j], r, sqd, tK)*MON[j]);
  mu = texf(qs[17], r, sqd, tK);
  kk = KP[i] + 1; keep = select(j -> j != kk, [1, 2, 3, 4]);
  if (nex[kk] != 1, print("orbit ", ORB[i], ": pivot not 1"));
  X = vector(4); for (j = 1, 3, X[keep[j]] = [x, y, z][j]);
  X[kk] = -sum(j = 1, 3, nex[keep[j]]*[x, y, z][j]);
  my(q = X[1]^2 + X[2]^2 + X[3]^2, p4 = X[1]^4 + X[2]^4 + X[3]^4);
  G = Eex*X[4]^4 - Eex*q*X[4]^2 + q^2 + tK*p4;
  if (variable(G) != x, error("variable priority"));
  zero = (simplify(lift(G - mu*Qr*Qs)) == 0);
  M1 = symm(Qr); M2 = symm(Qs);
  d1 = matdet(M1); d2 = matdet(M2);
  rk = 0;
  my(cr = vector(6, j, texf(qs[4+j], r, sqd, tK)), cs = vector(6, j, texf(qs[10+j], r, sqd, tK)));
  for (a1 = 1, 6, for (b1 = a1 + 1, 6, if (cr[a1]*cs[b1] - cr[b1]*cs[a1] != 0, rk = 2)));
  rp = vector(2);
  for (c = 1, 2, my(Mq = if (c == 1, M1, M2), m1 = Mq[1,1], m2 = Mq[1,1]*Mq[2,2] - Mq[1,2]^2, m3 = matdet(Mq), s1, s2, s3);
    if (m1 == 0 || m2 == 0, rp[c] = 1; next);
    if (min(min(abs(evf(m1, P, thr)), abs(evf(m2, P, thr))), abs(evf(m3, P, thr))) < 10^-100, rp[c] = -9; next);
    minminor = min(minminor, min(min(abs(evf(m1, P, thr)), abs(evf(m2, P, thr))), abs(evf(m3, P, thr))));
    s1 = sign(evf(m1, P, thr)); s2 = sign(evf(m2, P, thr)); s3 = sign(evf(m3, P, thr));
    rp[c] = if ((s1 > 0 && s2 > 0 && s3 > 0) || (s1 < 0 && s2 > 0 && s3 < 0), 0, 1));
  \\ exact-to-numeric planes for distinctness; normalise by the first exactly nonzero coefficient
  my(nnum = vector(4, j, evf(nex[j], P, thr)), nz = vector(4, j, nex[j] != 0));
  for (g = 1, #SYM, my(m = SYM[g]*nnum~, zz = SYM[g]*nz~, f = 0);
     for (j = 1, 4, if (!f && zz[j] != 0, f = j));
     listput(allplanes, [ORB[i], m~ / m[f]]));
  print("orbit ", ORB[i], " size ", SZ[i], " | N = K", if (r, Str("(sqrt ", vector(r, j, lift(ds[j])), ")"), ""), " [u=9t], [N:Q] = ", poldegree(P),
        " | reals d_j: ", vector(r, j, sign(dnum[j])),
        " | height ", ceil(log(hmax)/log(10)), " dig | null ", nt[1], "/", nt[2], " fail",
        " | F|plane = mu Qrep Qres EXACT: ", zero, " | det!=0: ", (d1 != 0) && (d2 != 0), " | non-prop: ", rk == 2,
        " | real pts (rep,res): ", rp);
  if (r, mind = min(mind, vecmin(dnum)));
  my(spl = supp(vector(4, j, qs[j]), r), sr = supp(concat(vector(4, j, qs[j]), vector(6, j, qs[4+j])), r),
     ss = supp(concat(vector(4, j, qs[j]), vector(6, j, qs[10+j])), r));
  print("   blocks used [1, sqrt d2, sqrt d1, sqrt d1d2] (r=2) or [1, sqrt d1] (r=1): plane ", spl, "  plane+Qrep ", sr, "  plane+Qres ", ss);
  write("exact_conics.txt", [ORB[i], SZ[i], KP[i], vector(r, j, lift(ds[j])), qs]);
  listput(summary, [ORB[i], r, vector(r, j, lift(ds[j])), poldegree(P), zero, (d1 != 0) && (d2 != 0), rk == 2, rp, nt]);
);
}
{
  my(L = Vec(allplanes), uniq = List(), dmin);
  for (i = 1, #L, my(v = L[i][2], found = 0);
    for (j = 1, #uniq, if (vecmax(abs(uniq[j] - v)) < 10^-200, found = 1; break));
    if (!found, listput(uniq, v)));
  print("distinct planes (48 images of each representative plane): ", #uniq);
  dmin = 10^10;
  for (i = 1, #uniq, for (j = i + 1, #uniq, dmin = min(dmin, vecmax(abs(uniq[i] - uniq[j])))));
  print("min separation between distinct normalised planes: ", dmin);
  write("summary_final.txt", Vec(summary));
  print("min |leading minor| over all 60 conics: ", minminor);
  print("min d_j at the real embedding: ", mind);
}
