/* gram736.gp (cert736, from cert704/gram704.gp): EXACT orbit closure, distinct planes/conics, and EXACT intersection
   Gram of all conics on X736 (Dwork form sum x^4 + c xyzw, c = sqrt6 (1+i)), from exact736.gp (recog736.gp).
   All arithmetic in N = Q(zeta24) = Q[th]/Phi24.  Group: the 384 monomial maps g[i,p(i)] = a_i, a_i in mu4,
   a1a2a3a4 = 1, normalised so that the row-4 entry is 1.  Points X -> gX; planes/point quadrics transform by
   gT = (g^-1)~ (g is NOT orthogonal here, unlike W(B4) in cert704); dual quadrics by g Cs g~. */
default(nbthreads,1); default(parisizemax, 4000000000);
vv = ['c0,'c1,'c2,'s,'y1,'y2,'y3,'y4]; th = varlower("th");
read("exact736.gp");
P8 = subst(P8x, x, th);
iN = Mod(th^6, P8); print("i = th^6 in N: i^2 == -1: ", iN^2 == -1);
cN = EX[1][5]; print("c^4 == -144: ", cN^4 == -144);
q3(Q) = [Q[1],Q[2]/2,Q[3]/2; Q[2]/2,Q[4],Q[5]/2; Q[3]/2,Q[5]/2,Q[6]];
adj3(M) = matadjoint(M);
Mbof(k, n) = { my(M=matrix(4,3), keep=select(i->i!=k+1,[1..4])); for(j=1,3, M[keep[j],j]=1; M[k+1,j]=-n[keep[j]]); M; }
Eof(k) = { my(E=matrix(3,4), keep=select(i->i!=k+1,[1..4])); for(j=1,3, E[j,keep[j]]=1); E; }
normv(v) = { my(i=1); while(v[i]==0, i++); v/v[i]; };
normM(M) = { my(v=vector(10), t=0); for(a=1,4, for(b=a,4, t++; v[t]=M[a,b])); normv(v); };
keyv(v) = vector(#v, i, vector(8, j, polcoef(lift(Mod(v[i],P8)), j-1, th)));   /* canonical: coefficient vectors (lift alone mixes t_INT/t_FRAC and constant t_POL, which broke Map keys) */
keyM(g) = keyv(concat(vector(4, j, g[,j]~)));
/* exact check that each seed lies on F: F restricted to the plane equals Qrep*Qres was checked in recog736/replay736. */
SEED = List();
{for(o=1,#EX, my(k=EX[o][1], n=EX[o][2], Mb=Mbof(k,n), E=Eof(k));
  foreach([EX[o][3], EX[o][4]], Q, my(M=q3(Q)); listput(SEED, [n~, E~*M*E, Mb*adj3(M)*Mb~, o])));}
print("seed conics: ", #SEED);
/* the group */
mu = [1, iN, -1, -iN];
normg(g) = { my(j=1); while(g[4,j]==0, j++); g/g[4,j]; };
G = List(); {forperm(4, p, forvec(e=vector(3,i,[0,3]), if(vecsum(e)%4, next);
   my(g=matrix(4,4)); for(i=1,3, g[i,p[i]] = mu[e[i]+1]); g[4,p[4]] = 1; listput(G, g)));}
G = Vec(G); print("|G| = ", #G, "   G[1] identity: ", G[1]==matid(4));
/* exact invariance of F under every g (F(gX) == F(X)) */
FX(X) = X[1]^4+X[2]^4+X[3]^4+X[4]^4 + cN*X[1]*X[2]*X[3]*X[4];
XV = ['y1,'y2,'y3,'y4]~;
print("F(gX) == F(X) for all 384 g: ", #select(g->FX(g*XV)==FX(XV), G) == #G);
print("pairwise projectively distinct: ", #Set(apply(g->keyM(normg(g)), G)) == #G);
GT = apply(g->(g^-1)~, G);
KEY = Map(); CON = List();
{for(a=1,#SEED, for(gi=1,#G, my(g=G[gi], Cs=g*SEED[a][3]*g~, kk=keyv(normM(Cs)));
   if(!mapisdefined(KEY, kk), listput(CON, [a, gi, normv(GT[gi]*SEED[a][1])]); mapput(KEY, kk, #CON))));}
N = #CON; print("distinct conics (exact dual-quadric keys): ", N);
PK = Map();
{for(i=1,N, my(kk=keyv(CON[i][3])); if(!mapisdefined(PK,kk), mapput(PK,kk,[i]), mapput(PK,kk,concat(mapget(PK,kk),[i]))));}
print("distinct planes (exact): ", #PK);
PM = Mat(PK); szs = vecsort(apply(v->#v, PM[,2]~)); print("conics per plane: ", Set(szs));
RES = vector(N); {for(t=1,#PM[,2], my(v=PM[t,2]); if(#v==2, RES[v[1]]=v[2]; RES[v[2]]=v[1]));}
ORB = vector(#SEED, a, #select(c->c[1]==a, Vec(CON))); print("new conics contributed by each seed: ", ORB);
/* each conic lies on X: point quadric A restricted to the plane times residual = F on the plane, inherited from the
   seed identity because F(gX) = F(X); smoothness (det != 0) is inherited as well. */
cn(i) = my(c=CON[i], gt=GT[c[2]]); [gt*SEED[c[1]][1], gt*SEED[c[1]][2]*gt~];
inter(i, j) = { my(di=cn(i), dj=cn(j), dr=cn(RES[j]), K=matker(matconcat([di[1], dj[1]])~), b1, b2, qi, qj, qr, P, g12);
  if(#K!=2, error("planes not distinct"));
  b1=K[,1]; b2=K[,2];
  for(tr=0,20, P = b1*'s + b2; qi = (P~*di[2]*P); if(poldegree(qi,'s)==2, break); b2 = b2 + b1; b1 = b1 + (tr+1)*K[,2]);
  if(poldegree(qi,'s)!=2, error("bad line param"));
  qj = P~*dj[2]*P; qr = P~*dr[2]*P;
  g12 = gcd(gcd(qi, qj), qr); if(poldegree(g12,'s)>0, return(-99));
  poldegree(gcd(qi, qj^2), 's); }
GEN = select(a->ORB[a]>0, [1..#SEED]); print("generator seeds: ", GEN);
IDX = vector(#SEED); {for(i=1,N, if(CON[i][2]==1 && IDX[CON[i][1]]==0, IDX[CON[i][1]]=i));}
ROW = Map(); t0=getabstime(); UND=0;
{foreach(GEN, a, my(i=IDX[a], r=vector(N));
  for(j=1,N, r[j] = if(j==i, -2, if(j==RES[i], 4, inter(i,j))); if(r[j]==-99, UND++));
  mapput(ROW, i, r); print("row of seed ", a, " (conic ", i, ") done, value counts ", [#select(x->x==-2,r), #select(x->x==0,r), #select(x->x==1,r), #select(x->x==2,r), #select(x->x==4,r)], "  ", getabstime()-t0, " ms"));}
print("undecided entries: ", UND);
permof(g) = vector(N, j, my(c=CON[j], Cs=g*G[c[2]]*SEED[c[1]][3]*(g*G[c[2]])~); mapget(KEY, keyv(normM(Cs))));
GIDX = Map(); for(gi=1,#G, mapput(GIDX, keyM(G[gi]), gi));
gidx(g) = mapget(GIDX, keyM(normg(g)));
GINV = vector(#G, gi, gidx(G[gi]^-1));
GENS = [matrix(4,4,a,b, b==(a%4)+1), matrix(4,4,a,b, if(a<=2, b==3-a, a==b)), matdiagonal([iN,-iN,1,1])];
GP = vector(#GENS, t, permof(GENS[t])); print("generator permutations computed (", getabstime()-t0, " ms)");
PERM = vector(#G); PERM[gidx(matid(4))] = [1..N];
{my(queue = List([matid(4)]), qi = 1); while(qi <= #queue, my(g = queue[qi]); qi++;
   for(t=1,#GENS, my(h = normg(GENS[t]*g), hi = gidx(h)); if(PERM[hi]==0, PERM[hi] = vecextract(GP[t], PERM[gidx(g)]); listput(queue, h))));}
print("all permutations composed: ", #select(v->v!=0, PERM), " (", getabstime()-t0, " ms)");
{for(r=1,8, my(gi = 1 + random(#G)); if(permof(G[gi]) != PERM[gi], error("perm composition mismatch at ", gi)));} print("spot check of 8 composed permutations against direct computation: OK");
print("action on conics faithful (384 distinct permutations): ", #Set(PERM) == #G);
Gc = matrix(N,N);
{for(i=1,N, my(c=CON[i], a=c[1], gi=c[2], r, pinv);
  if(ORB[a]==0, error("conic from non-generator seed"));
  r = mapget(ROW, IDX[a]); pinv = PERM[GINV[gi]];
  for(j=1,N, Gc[i,j] = r[pinv[j]]));}
print("Gram symmetric: ", Gc==Gc~);
VC = Map(); {for(i=1,N, for(j=1,N, my(v=Gc[i,j]); mapput(VC, v, if(mapisdefined(VC,v), mapget(VC,v)+1, 1))));}
print("value counts: ", Mat(VC));
INV=1; {for(gi=1,#G, my(p=PERM[gi]); if(vecextract(Gc, p, p)!=Gc, INV=0; break));}
print("Gram invariant under all 384 permutations: ", INV);
write("gram736_cert.gp", "Gc = ", Gc, ";");
writebin("conics736.bin", [P8x, SEED, G, CON, RES, PERM]);
print("GRAM_DONE");
