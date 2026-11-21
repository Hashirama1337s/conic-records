default(parisizemax, 4000000000); default(parisize, 256000000);
/* realpic660.gp (cert660, adapted from cert736/realpic736.gp): symmetry bookkeeping and the EXACT real picture of X660.
   Model: P3 coords x1..x4 (x5 = -(x1+..+x4)), F = 6(sum_1^5 x_i^4) + (sum_1^5 x_i^2)^2, rational.
   N = Q[th]/PX = Q(i, sqrt3, sqrt5) (CM; complex conjugation = the automorphism fixing sqrt3, sqrt5, sending i -> -i).
   Real structures from projective maps: sigma_h(X) = h conj(X), h in G (F is rational, so the coset is G itself);
   sigma_h is an involution iff h conj(h) = h^2 is scalar.  Classes: g h conj(g)^-1 = g h g^-1 (ordinary conjugacy).
   A conic is sigma-real iff key(h conj(Cs) h~) == key(Cs).  Real points: real model X = A X' with h conj(A) = lam A,
   conic written in X', checked real, leading minors signed EXACTLY in Q(sqrt3, sqrt5) by recursive squaring. */
default(nbthreads,1);
vv = ['c0,'c1,'c2,'s,'y1,'y2,'y3,'y4]; th = varlower("th");
/* rebuild seeds, group and conic list exactly as gramN.gp does (same order, so indices match gram660_cert.gp) */
read("exact660.gp");
P8 = subst(P8x, x, th);
q3(Q) = [Q[1],Q[2]/2,Q[3]/2; Q[2]/2,Q[4],Q[5]/2; Q[3]/2,Q[5]/2,Q[6]];
Eof(k) = { my(E=matrix(3,4), keep=select(i->i!=k+1,[1..4])); for(j=1,3, E[j,keep[j]]=1); E; }
Mbof0(k, n) = { my(M=matrix(4,3), keep=select(i->i!=k+1,[1..4])); for(j=1,3, M[keep[j],j]=1; M[k+1,j]=-n[keep[j]]); M; }
SEED = List();
{for(o=1,#EX, my(k=EX[o][1], n=EX[o][2], Mb=Mbof0(k,n), E=Eof(k));
  foreach([EX[o][3], EX[o][4]], Q, my(M=q3(Q)); listput(SEED, [n~, E~*M*E, Mb*matadjoint(M)*Mb~, o])));}
s5mat(p) = { my(g = matrix(4,4)); for(i=1,4, if(p[i] <= 4, g[i,p[i]] = 1, for(j=1,4, g[i,j] = -1))); g; };
nrm(g) = { my(j=1); while(g[4,j]==0, j++); g/g[4,j]; };
mkG() = { my(L = List([matid(4)])); forperm(5, p, my(g = nrm(s5mat(Vec(p)))); if(g != matid(4), listput(L, g))); Vec(L); };
G = mkG();
keyv0(v) = vector(#v, i, vector(poldegree(P8,th), j, polcoef(lift(Mod(v[i],P8)), j-1, th)));
normv0(v) = { my(i=1); while(v[i]==0, i++); v/v[i]; };
normM0(M) = { my(v=vector(10), t=0); for(a=1,4, for(b=a,4, t++; v[t]=M[a,b])); normv0(v); };
KEY0 = Map(); CON = List();
{for(a=1,#SEED, for(gi=1,#G, my(g=G[gi], Cs=g*SEED[a][3]*g~, kk=keyv0(normM0(Cs)));
   if(!mapisdefined(KEY0, kk), listput(CON, [a, gi]); mapput(KEY0, kk, #CON))));}
CON = Vec(CON); NC = #CON;
PERM = vector(#G, gi, vector(NC, j, my(c=CON[j], g=G[gi]*G[c[2]]); mapget(KEY0, keyv0(normM0(g*SEED[c[1]][3]*g~)))));
keyv(v) = vector(#v, i, vector(poldegree(P8,th), j, polcoef(lift(Mod(v[i],P8)), j-1, th)));
keyM(g) = keyv(concat(vector(#g, j, g[,j]~)));
Mbof(k, n) = { my(M=matrix(4,3), keep=select(i->i!=k+1,[1..4])); for(j=1,3, M[keep[j],j]=1; M[k+1,j]=-n[keep[j]]); M; }
normv(v) = { my(i=1); while(v[i]==0, i++); v/v[i]; };
normM(M) = { my(v=vector(10), t=0); for(a=1,4, for(b=a,4, t++; v[t]=M[a,b])); normv(v); };
normg(g) = { my(j=1); while(g[4,j]==0, j++); g/g[4,j]; };
FX(X) = my(s5 = X[1]+X[2]+X[3]+X[4]); 6*(X[1]^4+X[2]^4+X[3]^4+X[4]^4+s5^4) + (X[1]^2+X[2]^2+X[3]^2+X[4]^2+s5^2)^2;
XV = ['y1,'y2,'y3,'y4]~;
GT = apply(g->(g^-1)~, G);
DUAL = vector(NC, j, my(c=CON[j], g=G[c[2]]); g*SEED[c[1]][3]*g~);
PTQ = vector(NC, j, my(c=CON[j], gt=GT[c[2]]); gt*SEED[c[1]][2]*gt~);
PLN = vector(NC, j, my(c=CON[j]); GT[c[2]]*SEED[c[1]][1]);
ORBOF = vector(NC, j, SEED[CON[j][1]][4]);
KEY = Map(); for(j=1,NC, mapput(KEY, keyv(normM(DUAL[j])), j));
print("conics: ", NC, "   distinct dual keys: ", #KEY);
RT = polroots(P8x); r1 = RT[1];
ev(a) = subst(lift(Mod(a,P8)), th, r1);
pick(pol, target) = { my(R = nfroots(P8, pol)); R = select(z->abs(ev(z)-target)<1e-30, R); if(#R!=1, error("pick")); Mod(R[1],P8); };
iN = pick(x^2+1, I); s3 = pick(x^2-3, sqrt(3)); s5 = pick(x^2-5, sqrt(5));
/* complex conjugation: the automorphism th -> tau(th) with tau(th) = conj(th) at root #1 */
AUT = nfgaloisconj(P8x); tau = select(a->abs(subst(a,x,r1) - conj(r1)) < 1e-30, AUT);
if(#tau!=1, error("conj")); tau = subst(tau[1], x, th);
cj(a) = Mod(subst(lift(Mod(a,P8)), th, tau), P8);
cjm(M) = matrix(#M[,1], #M, i, j, cj(M[i,j]));
cjv(v) = apply(cj, v);
print("conj: i -> -i ", cj(iN)==-iN, "   sqrt3 fixed ", cj(s3)==s3, "   sqrt5 fixed ", cj(s5)==s5, "   involution ", cj(cj(Mod(th,P8)))==Mod(th,P8));
/* group facts */
print("|G| = ", #G, "   F(gX) == F(X) for all g: ", #select(g->FX(g*XV)==FX(XV), G)==#G);
detg = apply(g->matdet(g), G); print("det of the lifts: ", Set(detg), "   #(det = +1) = ", #select(d->d==1, detg), "  (g^* omega = det(g) omega since F(gX) = F(X))");
read("gram660_cert.gp");
print("final Gram invariant under all ", #G, " permutations: ", #select(p->vecextract(Gc,p,p)==Gc, PERM) == #G, "   faithful: ", #Set(PERM)==#G);
orbs(L) = { my(seen=vector(NC), out=List()); for(j=1,NC, if(seen[j], next); my(o=Set([j]), fr=[j]);
   while(#fr, my(nf=List()); foreach(fr, t, foreach(L, p, my(u=p[t]); if(!setsearch(o,u), o=setunion(o,[u]); listput(nf,u)))); fr=Vec(nf));
   foreach(o, t, seen[t]=1); listput(out, #o)); vecsort(Vec(out)); };
print("orbit sizes on conics, G: ", orbs(PERM));
print("orbit sizes on conics, Sp (det +1): ", orbs(vector(#G, t, if(detg[t]==1, PERM[t], [1..NC]))));
/* real structures */
GIDX = Map(); for(gi=1,#G, mapput(GIDX, keyM(normg(G[gi])), gi));
isinv(h) = { my(P = h*cjm(h)); if(P == P[1,1]*matid(4), P[1,1], 0); };
INV = select(h->isinv(h)!=0, G);
print("involutive h (h conj(h) scalar): ", #INV, "   scalars: ", Set(apply(h->lift(isinv(h)), INV)));
tw(g, h) = normg(g*h*cjm(g)^-1);
CL = List(); seenk = Map();
{foreach(INV, h, my(k=keyM(normg(h))); if(mapisdefined(seenk,k), next);
   my(orb = Set(apply(g->keyM(tw(g,h)), G))); foreach(orb, kk, mapput(seenk, kk, 1)); listput(CL, [h, #orb, isinv(h)]));}
print("classes of real structures: ", #CL, "   sizes ", apply(c->c[2], Vec(CL)), "   h conj(h): ", apply(c->lift(c[3]), Vec(CL)));
/* exact signs in Q(sqrt3, sqrt5) */
BAS = [1, s3, s5, s3*s5, iN, iN*s3, iN*s5, iN*s3*s5];
BM = matrix(8, 8, a, b, polcoef(lift(BAS[b]), a-1, th)); BMi = BM^-1;
coords(a) = BMi * vector(8, j, polcoef(lift(Mod(a,P8)), j-1, th))~;
sgnd(a, b, d) = { if(b==0, return(sign(a))); if(a==0, return(sign(b))); if(sign(a)==sign(b), return(sign(a))); sign(a)*sign(a^2-d*b^2); };  /* sign(a + b sqrt d) */
sgnR(z) = { my(c = coords(z), sp, sq, d0, d1);
  if(c[5]!=0 || c[6]!=0 || c[7]!=0 || c[8]!=0, error("not real"));
  /* z = (c1 + c2 sqrt3) + (c3 + c4 sqrt3) sqrt5 */
  sp = sgnd(c[1],c[2],3); sq = sgnd(c[3],c[4],3);
  if(sq==0, return(sp)); if(sp==0, return(sq)); if(sp==sq, return(sp));
  d0 = c[1]^2 + 3*c[2]^2 - 5*(c[3]^2 + 3*c[4]^2); d1 = 2*c[1]*c[2] - 10*c[3]*c[4];   /* p^2 - 5 q^2 = d0 + d1 sqrt3 */
  sp*sgnd(d0, d1, 3); };
print("exact sign test: sign(sqrt5 - sqrt3 - 1/2) = ", sgnR(s5-s3-1/2), " (expect +1: 0.004...),  sign(4*sqrt15 - 9*sqrt3 - 0.13) = ", sgnR(4*s3*s5-9*s3-13/100), " (expect -1)");
isreal(z) = my(c=coords(z)); c[5]==0 && c[6]==0 && c[7]==0 && c[8]==0;
realA(h) = { my(W = List()); for(k=1,4, my(e=vector(4,i,i==k)~); listput(W, e + h*e); listput(W, iN*e - iN*h*e));
   my(A = matrix(4,0)); foreach(W, w, if(matrank(matconcat([A, w])) > matrank(A), A = matconcat([A, w]))); A; };
{for(t=1,#CL, my(h=CL[t][1], s=CL[t][3], nreal=0, nrp=0, nrealpl=0, perorb=Map(), pat=Map(), A, FA, lc, Fn, ok=1, terms=0, P, lam=0);
  for(j=1,NC,
    if(keyv(normv(cjv(PLN[j])~*h^-1)) == keyv(normv(PLN[j]~)), nrealpl++);
    if(keyv(normM(h*cjm(DUAL[j])*h~)) == keyv(normM(DUAL[j])), nreal++; mapput(perorb, ORBOF[j], if(mapisdefined(perorb, ORBOF[j]), mapget(perorb, ORBOF[j]), 0) + 1)));
  print("class ", t, " (size ", CL[t][2], ", h = ", h, ", trace ", trace(h), "): sigma-real planes ", nrealpl, ";  sigma-real conics ", nreal, ";  per numerical orbit label ", Mat(perorb));
  A = realA(h); P = h*cjm(A);
  for(a=1,4, for(b=1,4, if(A[a,b]!=0 && lam==0, lam = P[a,b]/A[a,b])));
  print("   h conj(A) == lam*A: ", P == lam*A, " (lam = ", lift(lam), ")   det A != 0: ", matdet(A)!=0, "   A = ", lift(A));
  FA = FX(A*XV);
  lc = pollead(pollead(pollead(pollead(FA,y1),y2),y3),y4); Fn = FA/lc;
  forvec(ex=vector(4,i,[0,4]), if(vecsum(ex)!=4, next); my(cf = polcoef(polcoef(polcoef(polcoef(Fn,ex[1],y1),ex[2],y2),ex[3],y3),ex[4],y4)); if(cf!=0, terms++; if(!isreal(cf), ok=0)));
  print("   real model F(A X')/lead: all ", terms, " coefficients real: ", ok, "   F(A X')/lead = ", lift(Fn));
  for(j=1,NC, if(keyv(normM(h*cjm(DUAL[j])*h~)) != keyv(normM(DUAL[j])), next);
    my(n2 = normv(A~*PLN[j]), Ap = A~*PTQ[j]*A, kk, Mb2, Q2, Qn, m1, m2, m3, rp, sg, ii=1);
    if(!(isreal(n2[1])&&isreal(n2[2])&&isreal(n2[3])&&isreal(n2[4])), error("plane not real in X' at conic ", j));
    kk = 1; while(n2[kk]==0, kk++); n2 = n2/n2[kk];
    Mb2 = Mbof(kk-1, n2); Q2 = Mb2~*Ap*Mb2;
    while(Q2[(ii-1)%3+1, (ii-1)\3+1]==0, ii++); Qn = Q2/Q2[(ii-1)%3+1, (ii-1)\3+1];
    for(a=1,3, for(b=1,3, if(!isreal(Qn[a,b]), error("conic not real in X' at conic ", j))));
    m1 = sgnR(Qn[1,1]); m2 = sgnR(Qn[1,1]*Qn[2,2]-Qn[1,2]^2); m3 = sgnR(matdet(Qn));
    if(m3==0, error("degenerate conic ", j));
    if(m1==0 || m2==0, rp = 1, rp = !([m1,m2,m3]==[1,1,1] || [m1,m2,m3]==[-1,1,-1]));
    sg = [m1,m2,m3]; mapput(pat, sg, if(mapisdefined(pat,sg), mapget(pat,sg), 0)+1);
    if(rp, nrp++));
  print("   real conics with real points: ", nrp, " of ", nreal, ";  leading-minor sign patterns ", if(#pat, Mat(pat), "none")));}
print("REALPIC_DONE");
