/* geo704.gp (cert704): geometric W(B4) action on the 704 conics, same indexing as gram704.gp; writes geo704.g for GAP.
   (prefix copied from gram704.gp) gram704.gp (cert704): EXACT orbit closure, distinct planes/conics, and EXACT intersection Gram of all conics
   on X704, from the exact orbit representatives in exact704.bin (recog704.gp). All arithmetic in N8 = Q[th]/P8. */
default(nbthreads,1); default(parisizemax, 4000000000);
vv = ['c0,'c1,'c2,'s]; th = varlower("th");  /* th has the lowest variable priority */
read("exact704.gp");
/* symmetric 3x3 from 6 coefficients (c0^2,c0c1,c0c2,c1^2,c1c2,c2^2) */
q3(Q) = [Q[1],Q[2]/2,Q[3]/2; Q[2]/2,Q[4],Q[5]/2; Q[3]/2,Q[5]/2,Q[6]];
adj3(M) = matadjoint(M);
/* plane basis Mb (4x3): X = Mb*c, c = X_keep */
Mbof(k, n) = { my(M=matrix(4,3), keep=select(i->i!=k+1,[1..4])); for(j=1,3, M[keep[j],j]=1; M[k+1,j]=-n[keep[j]]); M; }
Eof(k) = { my(E=matrix(3,4), keep=select(i->i!=k+1,[1..4])); for(j=1,3, E[j,keep[j]]=1); E; }
normv(v) = { my(i=1); while(v[i]==0, i++); v/v[i]; };
normM(M) = { my(v=vector(10), t=0); for(a=1,4, for(b=a,4, t++; v[t]=M[a,b])); normv(v); };
keyv(v) = lift(v);
/* 22 seed conics: [n (4), A (4x4 point quadric with A|plane = Q), Cs (4x4 dual quadric)] */
SEED = List();
{for(o=1,#EX, my(k=EX[o][1], n=EX[o][2], Mb=Mbof(k,n), E=Eof(k));
  foreach([EX[o][3], EX[o][4]], Q, my(M=q3(Q)); listput(SEED, [n~, E~*M*E, Mb*adj3(M)*Mb~, o])));}
print("seed conics: ", #SEED);
/* W(B4): 384 signed permutation matrices */
G = List(); {forperm(4, p, forvec(s=vector(4,i,[0,1]), my(g=matrix(4,4)); for(i=1,4, g[i,p[i]] = (-1)^s[i]); listput(G, g)));}
G = Vec(G); print("|W(B4)| = ", #G);
/* orbit closure with exact keys */
KEY = Map(); CON = List();
{for(a=1,#SEED, for(gi=1,#G, my(g=G[gi], Cs=g*SEED[a][3]*g~, kk=keyv(normM(Cs)));
   if(!mapisdefined(KEY, kk), listput(CON, [a, gi, normv(g*SEED[a][1])]); mapput(KEY, kk, #CON))));}
N = #CON; print("distinct conics (exact dual-quadric keys): ", N);
PK = Map(); PL = vector(N);
{for(i=1,N, my(kk=keyv(CON[i][3])); if(!mapisdefined(PK,kk), mapput(PK,kk,[i]), mapput(PK,kk,concat(mapget(PK,kk),[i]))));}
print("distinct planes (exact): ", #PK);
PM = Mat(PK); szs = vecsort(apply(v->#v, PM[,2]~)); print("conics per plane: ", Set(szs));
RES = vector(N); {for(t=1,#PM[,2], my(v=PM[t,2]); if(#v==2, RES[v[1]]=v[2]; RES[v[2]]=v[1]));}
/* which seeds are W(B4)-orbit generators: orbit of each seed */
ORB = vector(#SEED, a, #select(c->c[1]==a, Vec(CON))); print("new conics contributed by each seed: ", ORB);
/* data of conic i: n, A */
cn(i) = my(c=CON[i], g=G[c[2]]); [g*SEED[c[1]][1], g*SEED[c[1]][2]*g~];
/* intersection number of conics i, j in distinct planes */
inter(i, j) = { my(di=cn(i), dj=cn(j), dr=cn(RES[j]), K=matker(matconcat([di[1], dj[1]])~), b1, b2, s, qi, qj, qr, P, tries=0, g1, g2, g12);
  if(#K!=2, error("planes not distinct"));
  b1=K[,1]; b2=K[,2];
  for(tr=0,20, P = b1*'s + b2 + tr*b1*0; qi = (P~*di[2]*P); if(poldegree(qi,'s)==2, break); b2 = b2 + b1; b1 = b1 + (tr+1)*K[,2]);
  if(poldegree(qi,'s)!=2, error("bad line param"));
  qj = P~*dj[2]*P; qr = P~*dr[2]*P;
  g12 = gcd(gcd(qi, qj), qr); if(poldegree(g12,'s)>0, return(-99));   /* point on C_i, C_j, C_j'' : undecided */
  poldegree(gcd(qi, qj^2), 's); }
permof(g) = vector(N, j, my(c=CON[j], Cs=g*G[c[2]]*SEED[c[1]][3]*(g*G[c[2]])~); mapget(KEY, keyv(normM(Cs))));
/* permutations: computed exactly for 3 generators of W(B4), then composed over the group (BFS) */
GIDX = Map(); for(gi=1,#G, mapput(GIDX, G[gi], gi));
GENS = [matrix(4,4,a,b, b==(a%4)+1), matrix(4,4,a,b, if(a<=2, b==3-a, a==b)), matdiagonal([-1,1,1,1])];
GP = vector(#GENS, t, permof(GENS[t])); print("generator permutations computed (", getabstime()-t0, " ms)");
GW = "geo704.g";
write(GW, "geo := [");
{for(t=1,#GP, my(p=GP[t]); write(GW, "PermList(", p, ")", if(t<#GP, ",", "")));}
write(GW, "];");
/* determinant of each generator (symplectic iff det = +1 for a linear automorphism preserving F) */
write(GW, "geodet := ", vector(#GENS, t, matdet(GENS[t])), ";");
print("GEO_DONE");
