default(nbthreads,1);
/* Barth-Bauer lattice S_h(K) of Degtyarev arXiv 2108.11181 sec 2, and extensions S_h[u1,u2,u3] (sec 3.2) */
pt(i) = binary(i-1+16)[2..5];   /* point i of F2^4 as 4 bits */
P16 = vector(16, i, pt(i));
dotb(a,b) = sum(j=1,4,a[j]*b[j])%2;
OCT = List(); for(a=1,15, av=binary(a+16)[2..5]; for(b=0,1, listput(OCT, select(i->dotb(av,P16[i])==b, [1..16])))); OCT=Vec(OCT);
qf(x) = (x[1]*x[2]+x[3]*x[4])%2;
KK = List(); for(a=0,15, av=binary(a+16)[2..5]; for(b=0,1, listput(KK, select(i->(qf(P16[i])+dotb(av,P16[i])+b)%2==1, [1..16])))); KK=Vec(KK);
print("octads ", #OCT, " sizes ", Set(apply(length,OCT)), "  K sets ", #KK, " sizes ", vecsort(apply(length,KK)));
/* RM(2,4) words */
mons = List(); listput(mons, vector(16,i,1)); for(j=1,4, listput(mons, vector(16,i,P16[i][j]))); for(j=1,4, for(l=j+1,4, listput(mons, vector(16,i,P16[i][j]*P16[i][l])))); mons=Vec(mons);
CW = List(); forvec(c=vector(11,i,[0,1]), w = vector(16,i, sum(j=1,11,c[j]*mons[j][i])%2); listput(CW, select(i->w[i],[1..16]))); CW = Set(Vec(CW));
print("|C| = ", #CW);
isK(s) = setsearch(Set(KK), s) > 0;
isO(s) = #s==0 || #s==16 || setsearch(Set(OCT), s) > 0;
par(s) = #setintersect(s, KK[1]) % 2;  /* even/odd */
/* basis of Q^20: e1..e16, h (17), u1,u2,u3 (18..20) */
gram0(U, Pr) = { my(G = matrix(20,20)); for(i=1,16, G[i,i]=-2; G[i,17]=2; G[17,i]=2); G[17,17]=4;
  for(a=1,3, my(r=17+a); G[r,r]=-2; G[r,17]=2; G[17,r]=2; for(i=1,16, my(v = if(setsearch(U[a][1],i),1, if(setsearch(U[a][2],i),2,0))); G[r,i]=v; G[i,r]=v));
  G[18,19]=G[19,18]=Pr[1]; G[18,20]=G[20,18]=Pr[2]; G[19,20]=G[20,19]=Pr[3]; G; }
mkgens() = { my(L=List()); for(i=1,20, listput(L, vector(20,j,j==i)~)); for(k=1,#OCT, listput(L, vector(20,j,if(j<=16 && setsearch(OCT[k],j),1/2,0))~));
  for(k=1,#KK, listput(L, vector(20,j,if(j==17,1/2, if(j<=16 && setsearch(KK[k],j),1/2,0)))~)); Mat(Vec(L)); }
GENS0 = mkgens();
zbasis(GN) = mathnf(2*GN)/2;
BZ = zbasis(GENS0); HV = matsolve(BZ, vector(20,j,j==17)~);
cens(G, hp) = my(Mp=(G*hp)*(G*hp)~ - 2*G, L=qfminim(Mp,8,,2)[3], c=[0,0,0,0], s, d); for(i=1,#L, s=L[,i]~*G*L[,i]; d=abs(L[,i]~*G*hp); if(s==-2, c[d+1]++); if(s==0, c[4]++)); c;
sig(G) = my(q=qfsign(G)); q;
/* check open stratum: rank 17 */
{ my(G17 = gram0([[[],[]],[[],[]],[[],[]]],[0,0,0])[1..17,1..17], B17, Gs, hv);
  B17 = mathnf(2*matconcat([matid(17), GENS0[1..17,21..#GENS0]]))/2; Gs = B17~*G17*B17; hv = matsolve(B17, vector(17,j,j==17)~);
  print("S_h: det ", matdet(Gs), " sign ", qfsign(Gs), " census [exc,lines,conics,iso] ", cens(Gs,hv)); }
