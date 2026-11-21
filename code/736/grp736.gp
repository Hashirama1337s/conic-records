/* Torelli symmetry group of (5.10): O_h(NS), then g = +-1 on discriminant (T = [12,0,16]: Hodge isometries +-1) */
default(nbthreads,1); read("ns736.gp");
n=#G; hc = matinverseimage(Bm~, hv~); H=(G*hc)*(G*hc)~;
print("SNF of G: ", matsnf(G));
A = qfauto([G, H]); gens = A[2]; print("qfauto order ", A[1]);
L = Map(); todo = List([matid(n)]); mapput(L, matid(n), 1); els = List([matid(n)]);
while(#todo, x = todo[#todo]; listpop(todo); for(i=1,#gens, y = gens[i]*x; if(!mapisdefined(L,y), mapput(L,y,1); listput(els,y); listput(todo,y))));
Oh = select(g->g*hc==hc, Vec(els)); print("|O_h| = ", #Oh);
Gi = G^-1;
plus = select(g->denominator((g-1)*Gi)==1, Oh); minus = select(g->denominator((g+1)*Gi)==1 && denominator((g-1)*Gi)!=1, Oh);
print("|Sp| (id on discr) = ", #plus, "   |Sym| (+-1) = ", #plus+#minus);
sym = concat(plus, minus);
Ksp = matker(matconcat(vector(#plus,i,plus[i]-1)~)); Ksy = matker(matconcat(vector(#sym,i,sym[i]-1)~));
print("rank NS^Sp = ", #Ksp, "  rank NS^Sym = ", #Ksy);
Cc = matinverseimage(Bm~, C2~); col = Map(); for(j=1,#Cc, mapput(col, Cc[,j], j));
OS = List(); seen=vector(#Cc);
for(j=1,#Cc, if(!seen[j], o=0; for(i=1,#plus, k = mapget(col, plus[i]*Cc[,j]); if(!seen[k], seen[k]=1; o++)); listput(OS, o)));
print("Sp-orbit sizes on conics: ", vecsort(Vec(OS)), "  #", #OS);
/* element orders */
ordr(g)= my(k=1,x=g); while(x!=matid(n), x=x*g; k++); k;
st = Map(); for(i=1,#plus, o=ordr(plus[i]); if(mapisdefined(st,o), mapput(st,o,mapget(st,o)+1), mapput(st,o,1)));
print("Sp element orders: ", Mat(st));
writebin("sym736.bin", [plus, minus]);
quit
