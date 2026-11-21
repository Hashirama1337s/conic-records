/* recog704.gp (cert704): exact recognition of the 11 W(B4)-orbit representatives of conics on
   X704: sum x^4 + lam (sum x^2)^2, lam = (-9+6i)/26, over the octic field N8 = Q[th]/P8.
   lindep at 330 digits, holdout at 430 digits, perturbation null (+1e-200*Pi must fail).
   Exact check: F|plane - Qrep*Qres == 0 in N8[c0,c1,c2]. Output: exact704.gp (EX[o] = [k, n, Qrep, Qres]). */
read("vals.gp");
default(nbthreads,1);
P8x = x^8 - 4*x^7 + 8*x^6 - 6*x^5 + 7*x^4 - 10*x^3 + 2*x^2 - 6*x + 9;
vv = ['c0,'c1,'c2,'s]; th = varlower("th");  /* th has the lowest variable priority */
P8 = subst(P8x, x, th);
print("P8 irreducible: ", polisirreducible(P8), "  nfdisc ", factor(nfdisc(P8x)), "  #galoisconj ", #nfgaloisconj(P8x));
RT = polroots(P8x);
IR = apply(z->subst(lift(z),th,x), nfroots(P8, x^2+1));  /* the two square roots of -1 in N8, as polys in x */
print("square roots of -1 in N8: ", IR);
S13 = apply(z->subst(lift(z),th,x), nfroots(P8, x^2-13)); print("square roots of 13 in N8: ", S13);
rec(xv, r, dig) = { my(v = concat([xv], vector(8, k, r^(k-1))), L = lindep(v, dig), res);
  if(L[1]==0, return(0));
  res = abs(L~ * v~) ;  /* evaluated at full precision */
  if(res > 1e-400 * vecmax(abs(L)), return(0));
  [-sum(k=1,8, L[k+1]*x^(k-1))/L[1], vecmax(abs(L))]; }
EX = vector(#V); NULLFAIL = 0; NULLTRY = 0;
{for(o=1,#V, my(found=0);
  for(ri=1,8, my(r=RT[ri], ok=1, polys=vector(16), H=0);
    for(j=1,16, my(xv=V[o][2+j], R);
      if(abs(xv) < 1e-400, polys[j]=0; next);
      R = rec(xv, r, 330); if(R==0, ok=0; break); polys[j]=R[1]; H=max(H,R[2]));
    if(!ok, next);
    /* perturbation null on every nonzero value */
    for(j=1,16, my(xv=V[o][2+j]); if(abs(xv)<1e-400, next); NULLTRY++; if(rec(xv + 1e-200*Pi, r, 330)!=0, print("  NULL FALSE POSITIVE o=",o," j=",j); NULLFAIL++));
    my(ipol = if(abs(subst(IR[1],x,r)-I)<1e-100, IR[1], IR[2]));
    EX[o] = [V[o][1], vector(4,j,Mod(subst(polys[j],x,th),P8)), vector(6,j,Mod(subst(polys[4+j],x,th),P8)), vector(6,j,Mod(subst(polys[10+j],x,th),P8)), Mod(subst(ipol,x,th),P8), ri, H];
    print("orbit ", o, " size ", SZ[o], ": recognised with root #", ri, ", max lindep coefficient ", H);
    found=1; break);
  if(!found, print("orbit ", o, ": NOT RECOGNISED")));}
print("perturbation null: ", NULLTRY, " tries, ", NULLFAIL, " false positives");
/* exact identity */
MON2 = [[2,0,0],[1,1,0],[1,0,1],[0,2,0],[0,1,1],[0,0,2]];
qp(Q) = sum(m=1,6, Q[m]*c0^MON2[m][1]*c1^MON2[m][2]*c2^MON2[m][3]);
Xof(k, n) = { my(X=vector(4), cs=[c0,c1,c2], keep=select(i->i!=k+1,[1..4])); for(j=1,3, X[keep[j]]=cs[j]); X[k+1] = -sum(j=1,3, n[keep[j]]*cs[j]); X; }
Fof(X, lam) = sum(i=1,4, X[i]^4) + lam*(sum(i=1,4,X[i]^2))^2;
NOK = 0;
{for(o=1,#V, if(EX[o]==0, next); my(k=EX[o][1], n=EX[o][2], Q1=EX[o][3], Q2=EX[o][4], iN=EX[o][5], lam, D, d1, d2, M1, M2, prop);
  lam = (-9 + 6*iN)/26;
  D = Fof(Xof(k,n), lam) - qp(Q1)*qp(Q2);
  M1 = matrix(3,3,a,b, if(a==b, Q1[[1,4,6][a]], Q1[[0,2,3;2,0,5;3,5,0][a,b]]/2));
  M2 = matrix(3,3,a,b, if(a==b, Q2[[1,4,6][a]], Q2[[0,2,3;2,0,5;3,5,0][a,b]]/2));
  d1 = matdet(M1); d2 = matdet(M2);
  prop = matrank(Mat([Q1~, Q2~]));   /* rank 2 = not proportional */
  print("orbit ", o, ": F|plane - Qrep*Qres == 0 : ", D==0, "   n[k+1]==1: ", n[k+1]==1, "   det Qrep != 0: ", d1!=0, "   det Qres != 0: ", d2!=0, "   rank[Qrep,Qres] = ", prop);
  if(D==0 && d1!=0 && d2!=0 && prop==2 && n[k+1]==1, NOK++));}
print("EXACT OK: ", NOK, " / ", #V);
writebin("exact704.bin", [P8x, EX]); write("exact704.gp", "P8x = ", P8x, ";"); write("exact704.gp", "EX = ", EX, ";");
