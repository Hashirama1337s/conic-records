/* gramfix736.gp (cert736): resolve the -99 entries of gram736 (point on C_i, C_j and the residual C_j'' of C_j, so
   the gcd rule on row i cannot split C_i.(C_j + C_j'') = 2).  Rule 1 (EXACT): the same intersection number computed
   from the other side, row j (triple C_j, C_i, C_i''), when decided there.  Rule 2 (EXACT given rho <= 20, CITED):
   a value in {0,1,2} for which the full Gram keeps rank <= 20, if unique.  Output gram736_cert.gp (final). */
default(parisizemax, 4000000000);
read("runs/gram736_raw.gp");
N = #Gc; U = []; for(i=1,N, for(j=1,N, if(Gc[i,j]==-99, U = concat(U, [[i,j]]))));
print("undecided entries in raw Gram: ", #U);
both = 0; fixed = 0;
{foreach(U, ij, my(i=ij[1], j=ij[2]); if(Gc[j,i] != -99, Gc[i,j] = Gc[j,i]; fixed++, both++));}
print("rule 1 (transpose decided): fixed ", fixed, ", still undecided (both sides) ", both);
print("symmetric now: ", Gc == Gc~, "   values: ", Set(concat(Vec(Gc))));
print("rank: ", matrank(Gc));
if(both == 0, write("gram736_cert.gp", "Gc = ", Gc, ";"); print("WROTE gram736_cert.gp"));
