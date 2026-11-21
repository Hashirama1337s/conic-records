read("bb.gp");
TP = [[4,0],[6,0],[12,0],[12,1],[12,2]];  /* types 3..7 -> index t-2 */
okS = select(s->!isK(s) && !isO(s) && par(s)==0, Vec(CW));
cand(t) = { my(p=TP[t-2][1], q=TP[t-2][2], L=List(), S=select(s->#s==p, okS)); for(i=1,#S, my(rest=setminus([1..16],S[i])); forsubset([#rest,q], w, listput(L, [S[i], Set(vecextract(rest, Vec(w)))]))); Vec(L); }
/* lattice with r extra conics U (list of [s1,s2]) and products Pr (r x r matrix off-diag) */
lat(U, Pr) = { my(r=#U, n=17+r, G=matrix(n,n), L=List(), B, Gz, hv);
  for(i=1,16, G[i,i]=-2; G[i,17]=2; G[17,i]=2); G[17,17]=4;
  for(a=1,r, my(R=17+a); G[R,R]=-2; G[R,17]=2; G[17,R]=2; for(i=1,16, my(v = if(setsearch(U[a][1],i),1, if(setsearch(U[a][2],i),2,0))); G[R,i]=v; G[i,R]=v); for(b=1,r, if(b!=a, G[R,17+b]=Pr[a,b])));
  for(i=1,n, listput(L, vector(n,j,j==i)~)); for(k=1,#OCT, listput(L, vector(n,j,if(j<=16 && setsearch(OCT[k],j),1/2,0))~));
  for(k=1,#KK, listput(L, vector(n,j,if(j==17,1/2, if(j<=16 && setsearch(KK[k],j),1/2,0)))~));
  if(matrank(G)<n, return([matrix(1,1),0,0,G])); B = mathnf(2*Mat(Vec(L)))/2; Gz = B~*G*B; hv = matsolve(B, vector(n,j,j==17)~); [Gz, hv, B, G]; }
info(X) = { my(Gz=X[1]); if(denominator(Gz)!=1 || matsize(Gz)[1]!=matsize(Gz)[2] || matdet(Gz)==0, return(0)); my(s=qfsign(Gz)); if(s[1]!=1, return(0)); [matdet(Gz), cens(Gz, X[2])]; }
