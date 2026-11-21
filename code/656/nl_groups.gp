/* BUILD: group the conditional Sp-orbits by their NL direction in NS^Sp / h (logic copied from design/probe/grp3.gp, grp4.gp) */
default(nbthreads,1); default(parisizemax, 2000000000);
read("ns656.gp");
hc = matinverseimage(Bm~, hv~); H=(G*hc)*(G*hc)~;
A = qfauto([G, H]); gens = A[2]; Gi = G^-1;
S=Set([matid(20)]); todo=[matid(20)];
while(#todo, x=todo[#todo]; todo=todo[1..#todo-1]; for(i=1,#gens, y=gens[i]*x; if(!setsearch(S,y), S=setunion(S,[y]); todo=concat(todo,[y]))));
els = Vec(S);
ok = select(g-> g*hc==hc && denominator((g-1)*61*Gi)==1, els);
sym = select(g-> denominator((g-1)*4*Gi)==1, ok);
print("|Sym| ", #ok, " |Sp| ", #sym);
Ksym = matker(matconcat(vector(#sym,i,sym[i]-1)~));
Cc = matinverseimage(Bm~, C2~);
col = Map(); for(j=1,#Cc, mapput(col, Cc[,j], j));
OS = List(); seen=vector(#Cc);
for(j=1,#Cc, if(!seen[j], o=List(); for(i=1,#sym, k = mapget(col, sym[i]*Cc[,j]); if(!seen[k], seen[k]=1; listput(o,k))); listput(OS, Vec(o))));
OS = Vec(OS);
Pj(v) = Ksym~*G*v;
hp = Pj(hc);
sums = vector(#OS, t, Pj(sum(u=1,#OS[t], Cc[,OS[t][u]])));
cond = select(t-> matrank(matconcat([hp, sums[t]]))==2, [1..#OS]);
print("generic conics: ", sum(t=1,#OS, if(setsearch(Set(cond),t),0,#OS[t])), "  conditional orbits: ", #cond);
cent = select(g-> g^2==1 && !setsearch(Set(sym),g) && vecsum(vector(#sym,i, g*sym[i]==sym[i]*g))==#sym, ok);
s = cent[1];
swp = select(t-> Cc[,mapget(col, s*Cc[,OS[t][1]])]==hc-Cc[,OS[t][1]], [1..#OS]);
print("Sp-orbits with sigma c = h - c: ", swp, " sizes ", apply(t->#OS[t], swp));
done = vector(#OS); 
{for(i=1,#cond, t=cond[i]; if(!done[t], grp = select(r-> matrank(matconcat([hp, sums[t], sums[r]]))==2, cond); for(k=1,#grp, done[grp[k]]=1);
   print("NL class: orbits ", grp, " sizes ", apply(r->#OS[r], grp), " total ", sum(k=1,#grp,#OS[grp[k]]), if(#setintersect(Set(grp),Set(swp)), "   <- contains the sigma-swapped orbits (NL1)", ""))));}
quit
