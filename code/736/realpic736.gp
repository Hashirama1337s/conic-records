/* realpic736.gp (cert736): symmetry bookkeeping and the EXACT real picture of X736.
   Dwork model F_c = sum X_i^4 + c X1X2X3X4, c = sqrt6 (1+i), over N = Q(zeta24) = Q[th]/Phi24 (embedding: root #1 of
   polroots(Phi24), where c = sqrt6(1+i) numerically; recog736.gp).
   (a) rational model: X = M v, M = diag(zeta8^-1, 1, 1, sqrt3) gives F_c(M v) = -x^4+y^4+z^4+9w^4+6xyzw (exact).
   (b) real structures from projective maps: sigma_h(X) = h conj(X).  sigma_h preserves X iff h maps X_cbar to X_c, so
       h runs over the coset G h0, h0 = diag(1,1,1,u), u = conj(c)/c in mu4 (G = the 384 monomial automorphisms).
       sigma_h is an involution iff h conj(h) = s I (s = +1 or -1; s = -1: no real points in P^3).
       Classes under g . sigma_h . g^-1 = sigma_{g h conj(g)^-1}.
   (c) per class: a conic is sigma-real iff key(h conj(Cs) h~) == key(Cs) (exact, dual quadrics).  For s = +1, a real
       model X = A X' with h conj(A) = A; real conics are written in X' coordinates, checked exactly to be real, and
       their real points decided by EXACT signs of the leading minors in Q(sqrt2, sqrt3) (recursive squaring).
   conj on N is th -> th^-1 (complex conjugation on a cyclotomic field, any embedding). */
default(nbthreads,1); default(parisizemax, 4000000000);
vv = ['c0,'c1,'c2,'s,'y1,'y2,'y3,'y4]; th = varlower("th");
read("exact736.gp");
P8 = subst(P8x, x, th);
keyv(v) = vector(#v, i, vector(8, j, polcoef(lift(Mod(v[i],P8)), j-1, th)));
keyM(g) = keyv(concat(vector(#g, j, g[,j]~)));
q3(Q) = [Q[1],Q[2]/2,Q[3]/2; Q[2]/2,Q[4],Q[5]/2; Q[3]/2,Q[5]/2,Q[6]];
Mbof(k, n) = { my(M=matrix(4,3), keep=select(i->i!=k+1,[1..4])); for(j=1,3, M[keep[j],j]=1; M[k+1,j]=-n[keep[j]]); M; }
Eof(k) = { my(E=matrix(3,4), keep=select(i->i!=k+1,[1..4])); for(j=1,3, E[j,keep[j]]=1); E; }
normv(v) = { my(i=1); while(v[i]==0, i++); v/v[i]; };
normM(M) = { my(v=vector(10), t=0); for(a=1,4, for(b=a,4, t++; v[t]=M[a,b])); normv(v); };
normg(g) = { my(j=1); while(g[4,j]==0, j++); g/g[4,j]; };
RT = polroots(P8x); r1 = RT[1];
ev(a) = subst(lift(Mod(a,P8)), th, r1);
pick(pol, target) = { my(R = nfroots(P8, pol)); R = select(z->abs(ev(z)-target)<1e-30, R); if(#R!=1, error("pick")); Mod(R[1],P8); };
iN = pick(x^2+1, I); s2 = pick(x^2-2, sqrt(2)); s3 = pick(x^2-3, sqrt(3));
cN = EX[1][5];
print("i, sqrt2, sqrt3 in N fixed by root #1; c == sqrt2*sqrt3*(1+i): ", cN == s2*s3*(1+iN));
thinv = lift(Mod(th,P8)^-1);
cj(a) = Mod(subst(lift(Mod(a,P8)), th, thinv), P8);
cjm(M) = matrix(#M[,1], #M, i, j, cj(M[i,j]));
cjv(v) = apply(cj, v);
print("conj: i -> ", cj(iN)==-iN, " (-i)   sqrt2 fixed ", cj(s2)==s2, "   sqrt3 fixed ", cj(s3)==s3, "   involution on th ", cj(cj(Mod(th,P8)))==Mod(th,P8));
/* (a) rational model */
z8 = (1+iN)/s2; print("zeta8^2 == i: ", z8^2 == iN);
Mrat = matdiagonal([1/z8, 1, 1, s3]);
FX(X, c) = X[1]^4+X[2]^4+X[3]^4+X[4]^4 + c*X[1]*X[2]*X[3]*X[4];
XV = ['y1,'y2,'y3,'y4]~;
print("(a) F_c(M v) == -x^4+y^4+z^4+9w^4+6xyzw : ", FX(Mrat*XV, cN) == -y1^4+y2^4+y3^4+9*y4^4+6*y1*y2*y3*y4);
/* group */
mu = [1, iN, -1, -iN];
G = List(); {forperm(4, p, forvec(e=vector(3,i,[0,3]), if(vecsum(e)%4, next);
   my(g=matrix(4,4)); for(i=1,3, g[i,p[i]] = mu[e[i]+1]); g[4,p[4]] = 1; listput(G, g)));}
G = Vec(G);
detg = apply(g->matdet(g), G); print("det of the normalised lifts: ", Set(apply(d->lift(d), detg)), "  #(det = +1) = ", #select(d->d==1, detg), "  (symplectic part: g^* omega = det(g) omega since F(gX) = F(X))");
GIDX = Map(); for(gi=1,#G, mapput(GIDX, keyM(G[gi]), gi));
gidx(g) = mapget(GIDX, keyM(normg(g)));
/* conics: closure as in gram736.gp, same ordering */
SEED = List();
{for(o=1,#EX, my(k=EX[o][1], n=EX[o][2], Mb=Mbof(k,n), E=Eof(k));
  foreach([EX[o][3], EX[o][4]], Q, my(M=q3(Q)); listput(SEED, [n~, E~*M*E, Mb*matadjoint(M)*Mb~, o])));}
GT = apply(g->(g^-1)~, G);
KEY = Map(); CON = List();
{for(a=1,#SEED, for(gi=1,#G, my(g=G[gi], Cs=g*SEED[a][3]*g~, kk=keyv(normM(Cs)));
   if(!mapisdefined(KEY, kk), listput(CON, [a, gi, normv(GT[gi]*SEED[a][1]), Cs, GT[gi]*SEED[a][2]*GT[gi]~]); mapput(KEY, kk, #CON))));}
NC = #CON; print("conics: ", NC);
ORBOF = vector(NC, j, SEED[CON[j][1]][4]);   /* numerical-chart orbit label 1..8 of the seed */
/* Gram invariance after the transpose fill (gram736_cert.gp) under the 384 permutations */
read("gram736_cert.gp");
permof(g) = vector(NC, j, mapget(KEY, keyv(normM(g*CON[j][4]*g~))));
PERM = apply(permof, G);
print("final Gram invariant under all 384 permutations: ", #select(p->vecextract(Gc,p,p)==Gc, PERM) == #G, "   faithful: ", #Set(PERM)==#G);
/* orbits of G and of Sp = det +1 */
orbs(L) = { my(seen=vector(NC), out=List()); for(j=1,NC, if(seen[j], next); my(o=Set([j]), fr=[j]);
   while(#fr, my(nf=List()); foreach(fr, t, foreach(L, p, my(u=p[t]); if(!setsearch(o,u), o=setunion(o,[u]); listput(nf,u)))); fr=Vec(nf));
   foreach(o, t, seen[t]=1); listput(out, #o)); vecsort(Vec(out)); };
print("orbit sizes on conics, G (384): ", orbs(PERM));
print("orbit sizes on conics, Sp (192): ", orbs(vector(#G, t, if(detg[t]==1, PERM[t], [1..NC]))));
/* (b) real structures */
u = cj(cN)/cN; print("u = conj(c)/c: ", lift(u), "   u == -i: ", u == -iN, "   u^4 == 1: ", u^4 == 1);
h0 = matdiagonal([1,1,1,u]);
print("h0 maps X_cbar to X_c: F_c(h0 X) == F_cbar(X): ", FX(h0*XV, cN) == FX(XV, cj(cN)));
H = apply(g->normg(g*h0), G);
isinv(h) = { my(P = h*cjm(h)); if(P == P[1,1]*matid(4), P[1,1], 0); };
INV = select(h->isinv(h)!=0, H);
print("coset elements: ", #H, "   involutive (h conj(h) scalar): ", #INV, "   scalars seen: ", Set(apply(h->lift(isinv(h)), INV)));
tw(g, h) = normg(g*h*cjm(g)^-1);
CL = List(); seenk = Map();
{foreach(INV, h, my(k=keyM(h)); if(mapisdefined(seenk,k), next);
   my(orb = Set(apply(g->keyM(tw(g,h)), G))); foreach(orb, kk, mapput(seenk, kk, 1)); listput(CL, [h, #orb, isinv(h)]));}
print("classes of real structures (twisted conjugation by G): ", #CL, "   sizes ", apply(c->c[2], Vec(CL)), "   h conj(h): ", apply(c->lift(c[3]), Vec(CL)));
hrat = Mrat*cjm(Mrat)^-1; print("rational model's structure h_rat = M conj(M)^-1 = ", lift(hrat), "  in coset: ", setsearch(Set(apply(keyM,H)), keyM(normg(hrat)))>0);
ratclass = 0; {for(t=1,#CL, if(setsearch(Set(apply(g->keyM(tw(g,CL[t][1])), G)), keyM(normg(hrat))), ratclass = t));}
print("rational model belongs to class ", ratclass);
/* exact signs in Q(sqrt2, sqrt3) */
BAS = [1, s2, s3, s2*s3, iN, iN*s2, iN*s3, iN*s2*s3];
BM = matrix(8, 8, a, b, polcoef(lift(BAS[b]), a-1, th)); BMi = BM^-1;
coords(a) = BMi * vector(8, j, polcoef(lift(Mod(a,P8)), j-1, th))~;
sgn2(a, b) = { if(b==0, return(sign(a))); if(a==0, return(sign(b))); if(sign(a)==sign(b), return(sign(a))); sign(a)*sign(a^2-2*b^2); };   /* sign(a + b sqrt2) */
sgnR(z) = { my(c = coords(z), p0, p2, q0, q2, sp, sq, d0, d2);
  if(c[5]!=0 || c[6]!=0 || c[7]!=0 || c[8]!=0, error("not real"));
  p0=c[1]; p2=c[2]; q0=c[3]; q2=c[4];             /* z = (p0 + p2 sqrt2) + (q0 + q2 sqrt2) sqrt3 */
  sp = sgn2(p0,p2); sq = sgn2(q0,q2);
  if(sq==0, return(sp)); if(sp==0, return(sq)); if(sp==sq, return(sp));
  d0 = p0^2 + 2*p2^2 - 3*(q0^2 + 2*q2^2); d2 = 2*p0*p2 - 6*q0*q2;      /* p^2 - 3 q^2 = d0 + d2 sqrt2 */
  sp*sgn2(d0, d2); };
print("exact sign test: sign(sqrt3 - sqrt2 - 0.3) = ", sgnR(s3 - s2 - 3/10), " (expect +1: 0.0178...),  sign(5*sqrt6 - 7*sqrt2 - 2) = ", sgnR(5*s2*s3-7*s2-2), " (expect +1)");
isreal(z) = my(c=coords(z)); c[5]==0 && c[6]==0 && c[7]==0 && c[8]==0;
/* real model matrix A with h conj(A) = A, from sigma-fixed vectors e_k + h conj(e_k) and i e_k - i h conj(e_k) */
realA(h) = { my(W = List()); for(k=1,4, my(e=vector(4,i,i==k)~); listput(W, e + h*e); listput(W, iN*e - iN*h*e));
   my(A = matrix(4,0)); foreach(W, w, if(matrank(matconcat([A, w])) > matrank(A), A = matconcat([A, w]))); A; };
{for(t=1,#CL, my(h=CL[t][1], s=CL[t][3], nreal=0, nrp=0, nrealpl=0, perorb=Map(), pat=Map(), A, FA, lead, cfs);
  for(j=1,NC, my(c=CON[j], im=keyv(normM(h*cjm(c[4])*h~)));
    if(keyv(normv(cjv(c[3])~*h^-1)) == keyv(c[3]), nrealpl++);  /* plane n.X=0 maps to n'.X = 0 with n' ~ conj(n) h^-1 */
    if(im == keyv(normM(c[4])), nreal++; mapput(perorb, ORBOF[j], if(mapisdefined(perorb, ORBOF[j]), mapget(perorb, ORBOF[j]), 0) + 1)));
  print("class ", t, " (size ", CL[t][2], ", h conj(h) = ", lift(s), (if(t==ratclass, ", = the rational model -x^4+y^4+z^4+9w^4+6xyzw", "")), "): sigma-real conics ", nreal, ";  sigma-real planes ", nrealpl, ";  real conics per numerical orbit label ", Mat(perorb));
  if(s == -1, print("   h conj(h) = -I: sigma has no fixed points on P^3, so no conic has real points"); next);
  A = if(t==ratclass, my(g0 = select(g->tw(g,CL[t][1])==normg(hrat), G)[1]); g0^-1*Mrat, realA(h));
  /* tw(g0, h_t) = h_rat, so with X = g0^-1 Y the structure becomes h_rat; A = g0^-1 M maps v to X */
  my(P = h*cjm(A), lam = 0, Fn, ok = 1, terms = 0);
  for(a=1,4, for(b=1,4, if(A[a,b]!=0 && lam==0, lam = P[a,b]/A[a,b])));
  print("   h conj(A) == lam*A: ", P == lam*A, " (lam = ", lift(lam), ")   det A != 0: ", matdet(A)!=0);
  FA = FX(A*XV, cN);
  lc = pollead(pollead(pollead(pollead(FA,y1),y2),y3),y4);
  Fn = FA/lc;
  forvec(ex=vector(4,i,[0,4]), if(vecsum(ex)!=4, next); my(cf = polcoef(polcoef(polcoef(polcoef(Fn,ex[1],y1),ex[2],y2),ex[3],y3),ex[4],y4)); if(cf!=0, terms++; if(!isreal(cf), ok=0)));
  print("   real model F(A X')/lead: all ", terms, " coefficients real: ", ok, "   F(A X')/lead = ", Fn);
  /* real points of the sigma-real conics, in X' coordinates */
  for(j=1,NC, my(c=CON[j]); if(keyv(normM(h*cjm(c[4])*h~)) != keyv(normM(c[4])), next);
    my(n2 = normv(A~*c[3]), Ap = A~*c[5]*A, kk, Mb2, Q2, Qn, m1, m2, m3, rp, sg);
    if(!(isreal(n2[1])&&isreal(n2[2])&&isreal(n2[3])&&isreal(n2[4])), error("plane not real in X' at conic ", j));
    kk = 1; while(n2[kk]==0, kk++); n2 = n2/n2[kk];   /* pivot 1 */
    Mb2 = Mbof(kk-1, n2); Q2 = Mb2~*Ap*Mb2;
    my(ii=1); while(Q2[(ii-1)%3+1, (ii-1)\3+1]==0, ii++); Qn = Q2/Q2[(ii-1)%3+1, (ii-1)\3+1];
    for(a=1,3, for(b=1,3, if(!isreal(Qn[a,b]), error("conic not real in X' at conic ", j))));
    m1 = sgnR(Qn[1,1]); m2 = sgnR(Qn[1,1]*Qn[2,2]-Qn[1,2]^2); m3 = sgnR(matdet(Qn));
    if(m3==0, error("degenerate conic ", j));
    if(m1==0 || m2==0, rp = 1, rp = !([m1,m2,m3]==[1,1,1] || [m1,m2,m3]==[-1,1,-1]));
    sg = [m1,m2,m3]; mapput(pat, sg, if(mapisdefined(pat,sg), mapget(pat,sg), 0)+1);
    if(rp, nrp++));
  print("   real conics with real points: ", nrp, " of ", nreal, ";  leading-minor sign patterns ", Mat(pat)));}
print("REALPIC_DONE");
