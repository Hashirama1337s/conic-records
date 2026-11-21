/* Step 3 (BUILD): recompute O_h(NS), Sym, Sp as in design/probe/lead_grp.gp and export to GAP. */
default(nbthreads,1); read("ns656.gp"); hc = matinverseimage(Bm~, hv~); H=(G*hc)*(G*hc)~;
A=qfauto([G,H]); gens=A[2]; S=Set([matid(20)]); todo=[matid(20)];
while(#todo, x=todo[#todo]; todo=todo[1..#todo-1]; for(i=1,#gens, y=gens[i]*x; if(!setsearch(S,y), S=setunion(S,[y]); todo=concat(todo,[y]))));
Oh=select(g->g*hc==hc, Vec(S)); Gi=G^-1;
minus=select(g->denominator((g+1)*Gi*4)==1 && denominator((g-1)*Gi*61)==1, Oh);
plus=select(g->denominator((g-1)*Gi*4)==1 && denominator((g-1)*Gi*61)==1, Oh);
Sym=concat(plus,minus);
print("closure ",#S," |O_h| ",#Oh," |Sym| ",#Sym," |Sp| ",#plus);
\ sanity: each element preserves G and h
print("all isometries: ", #select(g->g~*G*g==G, Sym)==#Sym, "  all fix h: ", #select(g->g*hc==hc, Sym)==#Sym);
tog(M)=my(s="["); for(i=1,matsize(M)[1], s=concat(s, concat(Str(vector(matsize(M)[2],j,M[i,j])), if(i<matsize(M)[1],",","]")))); s;
f="grp48_v2.g"; write1(f,"Sym := [");
for(k=1,#Sym, write1(f, concat(tog(Sym[k]), if(k<#Sym,",\n","];\n"))));
write1(f,"SpL := ["); for(k=1,#plus, write1(f, concat(tog(plus[k]), if(k<#plus,",\n","];\n"))));
write1(f,"Oh := ["); for(k=1,#Oh, write1(f, concat(tog(Oh[k]), if(k<#Oh,",\n","];\n"))));
quit
