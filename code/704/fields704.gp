/* fields704.gp (cert704): the field N8 and the field of definition of each conic orbit (exact, via Gal(N8/Q)) */
vv = ['c0,'c1,'c2,'s]; th = varlower("th");
read("exact704.gp");
P8 = subst(P8x, x, th);
nf = nfinit(P8x);
A = nfgaloisconj(nf); print("#Aut(N8) = ", #A, "  (Galois iff 8)");
ap(s, z) = Mod(subst(lift(s), x, th), P8) ;  /* sigma as polmod in th */
act(s, z) = subst(lift(z), th, ap(s));       /* apply sigma to z in N8 */
/* group structure: composition table */
comp(i,j) = { my(z = act(A[i], ap(A[j]))); select(k->ap(A[k])==z, [1..8])[1]; };
T = matrix(8,8,i,j,comp(i,j));
print("abelian: ", T==T~);
ordr(i) = { my(k=1, c=i, id=select(k->ap(A[k])==Mod(th,P8),[1..8])[1]); while(c!=id, c=T[i,c]; k++); k; };
print("element orders: ", vecsort(vector(8,i,ordr(i))));
print("polredabs(P8) = ", polredabs(P8x), "   P8 itself polredabs-reduced: ", polredabs(P8x)==P8x);
print("quadratic subfields: ", apply(v->polredabs(v[1]), nfsubfields(P8x, 2)));
print("quartic subfields: ", apply(v->polredabs(v[1]), nfsubfields(P8x, 4)));
/* fixer of each orbit's coefficients */
{for(o=1,#EX, my(cs = concat([EX[o][2], EX[o][3], EX[o][4]]), fix = 0);
  for(i=1,8, if(vector(#cs,j,act(A[i], cs[j])) == cs, fix++));
  my(csp = EX[o][2], fixp = 0); for(i=1,8, if(vector(4,j,act(A[i], csp[j]))==csp, fixp++));
  print("orbit ", o, ": [Q(plane):Q] = ", 8/fixp, "   [Q(plane, conic pair):Q] = ", 8/fix));}
