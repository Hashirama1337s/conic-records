default(parisizemax, 2000000000)
x;y;z;
vR = varlower("vR"); vK = varlower("vK");
Tu = vK^3 + 48*vK^2 + 1125*vK + 9882; nfK = nfinit(Tu);
L = readvec("exact_conics.txt");
{
my(seen = List());
for (i = 1, #L, my(d = L[i][4], r = #d, rel, P, Pr);
  if (r == 1, rel = vR^2 - d[1], rel = (vR^2 - d[1] - d[2])^2 - 4*d[1]*d[2]);
  P = rnfequation(nfK, rel);
  Pr = polredabs(P);
  my(id = 0); for (j = 1, #seen, if (seen[j] == Pr, id = j)); if (!id, listput(seen, Pr); id = #seen);
  print("orbit ", L[i][1], ": irreducible ", polisirreducible(P), "  deg ", poldegree(P), "  field #", id,
        "  disc ", factor(abs(nfdisc(Pr)))[,1]~, "  signature ", nfinit(Pr).sign));
print("distinct fields: ", #seen);
for (j = 1, #seen, print("field #", j, ": ", seen[j]));
}
