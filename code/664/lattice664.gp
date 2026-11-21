\\ lattice664.gp (CERT664, adapted from exactub/lattice.gp): lattice route on the EXACT Gram gram_exact.gp
\\ (hc = indicator of the two conics on one plane, so h = hc).  |det S| = 240 = k^2 |disc NS| allows k in {1,2,4};
\\ an even overlattice of index 4 contains one of index 2 (a group of order 4 has a subgroup of order 2), so
\\ excluding every even index-2 overlattice gives NS = S.
\\ S = Z-span of the 664 conic classes = Z^656 / radical(Gc). Basis via mathnf(Gc,1).
default(parisizemax, 4000000000);
read("gram_exact.gp");
N = #Gc;
print("N = ", N, "  symmetric: ", Gc == Gc~);
[H, U] = mathnf(Gc, 1);
r = #H; print("rank of Gram (columns of HNF): ", r);
Y = U[, N - r + 1 .. N];               \\ Gc * Y = H (the image basis); Y = preimages
S = Y~ * Gc * Y;
print("det S = ", matdet(S), "   snf: ", matsnf(S));
sig = [#select(x -> x > 0, qfjacobi(S * 1.)[1]), #select(x -> x < 0, qfjacobi(S * 1.)[1])];
print("signature: ", sig);
\\ each conic class in the basis: Gc * e_i = H * a_i  ->  a_i = H^-1 Gc[,i]
Ainv = matinverseimage(H, Gc);
print("all conic coordinates integral: ", denominator(Ainv) == 1);
hv = Ainv * hc;
print("h^2 = ", hv~ * S * hv, "   (expect 4)");
\\ consistency: S-Gram of the conic coordinates reproduces Gc
print("Gram reproduced: ", Ainv~ * S * Ainv == Gc);
\\ h-parity of S
print("h.v even for all basis v: ", vector(r, i, (S * hv)[i] % 2) == vector(r));

\\ ---- index-2 overlattices: classes x = v/2 with S v = 0 mod 2
K2 = matker(Mod(S, 2));
print("dim ker(S mod 2) = ", #K2);
cand = List();
{forvec(e = vector(#K2, i, [0, 1]), if (e == vector(#K2), next);
  my(v = lift(K2 * e~), x = v / 2, q = x~ * S * x, integ = denominator(S * x) == 1);
  listput(cand, [v, q, integ]);
  print("class v/2: x^2 = ", q, "   (S x integral: ", integ, ")  even-isotropic (x^2 in 2Z): ", denominator(q) == 1 && q % 2 == 0));}

\\ positive-definite form 2B(v) = -2 v^2 + (v.h)^2 on a lattice with Gram M and polarisation hh
posform(M, hh) = my(w = M * hh); -2 * M + w * w~;
census(M, hh, bound, tag) =
{
  my(Q = posform(M, hh), L = qfminim(Q, bound)[3], tally = Map(), c = 0);
  for (i = 1, #L, my(v = L[, i], n = v~ * M * v, d = abs((M * hh)~ * v), key = [n, d]);
    if (mapisdefined(tally, key), mapput(tally, key, mapget(tally, key) + 1), mapput(tally, key, 1)));
  print(tag, ": vectors (up to sign) with 2B <= ", bound, ": ", #L);
  print(tag, ": [v^2, |v.h|] -> count (up to sign): ", Mat(tally));
  tally;
}
TS = census(S, hv, 8, "S");
nconS = if (mapisdefined(TS, [-2, 2]), mapget(TS, [-2, 2]), 0);
print("S: #{v : v^2 = -2, v.h = 2} = ", nconS);

\\ ---- each even overlattice
{for (k = 1, #cand, my(v = cand[k][1], q = cand[k][2], integ = cand[k][3]);
  if (!(integ && denominator(q) == 1 && q % 2 == 0), print("class ", k, ": not an even integral overlattice -> excluded"); next);
  my(Bm = mathnf(concat(2 * matid(r), v)) / 2, Mo = Bm~ * S * Bm, ho = matsolve(Bm, hv));
  print("class ", k, ": even overlattice, det ", matdet(Mo), "; h coords integral: ", denominator(ho) == 1);
  census(Mo, ho, 8, Str("N", k)));}
print("LATTICE_DONE");
