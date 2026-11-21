/* recog736.gp (cert736, from cert704/recog704.gp): exact recognition of the 8 orbit representatives of conics on
   X736 (Dwork form): sum x^4 + c xyzw, c = sqrt6 (1+i), c^4 = -144, over N = Q(zeta24) = Q[th]/Phi24.
   lindep at 330 digits, holdout at 510 digits (threshold 1e-480), perturbation null (+1e-200*Pi must fail).
   Exact check: F|plane - Qrep*Qres == 0 in N[c0,c1,c2]. Output: exact736.gp (EX[o] = [k, n, Qrep, Qres, cN, ri, H]). */
read("vals.gp");
default(nbthreads,1);
P8x = polcyclo(24);
vv = ['c0,'c1,'c2,'s]; th = varlower("th");
P8 = subst(P8x, x, th);
print("P8 = ", P8x, " irreducible: ", polisirreducible(P8), "  nfdisc ", factor(nfdisc(P8x)), "  #galoisconj ", #nfgaloisconj(P8x));
RT = polroots(P8x);
CR = apply(z->subst(lift(z),th,x), nfroots(P8, x^4+144));   /* the four c in N */
print("roots of x^4+144 in N: ", #CR);
rec(xv, r, dig) = { my(v = concat([xv], vector(8, k, r^(k-1))), L = lindep(v, dig), res);
  if(L[1]==0, return(0));
  res = abs(L~ * v~);
  if(res > 1e-480 * vecmax(abs(L)), return(0));
  [-sum(k=1,8, L[k+1]*x^(k-1))/L[1], vecmax(abs(L))]; }
EX = vector(#V); NULLFAIL = 0; NULLTRY = 0; ri = 1; r = RT[ri];
cpol = select(p->abs(subst(p,x,r) - sqrt(6)*(1+I)) < 1e-100, CR); print("c = sqrt6(1+i) at root #1: ", #cpol==1);
cpol = cpol[1]; cN = Mod(subst(cpol,x,th),P8); print("c in N: ", lift(cN), "   c^4 + 144 == 0: ", cN^4+144==0);
{for(o=1,#V, my(ok=1, polys=vector(16), H=0);
    for(j=1,16, my(xv=V[o][2+j], R);
      if(abs(xv) < 1e-480, polys[j]=0; next);
      R = rec(xv, r, 330); if(R==0, ok=0; break); polys[j]=R[1]; H=max(H,R[2]));
    if(!ok, print("orbit ", o, ": NOT RECOGNISED"); next);
    for(j=1,16, my(xv=V[o][2+j]); if(abs(xv)<1e-480, next); NULLTRY++; if(rec(xv + 1e-200*Pi, r, 330)!=0, print("  NULL FALSE POSITIVE o=",o," j=",j); NULLFAIL++));
    EX[o] = [V[o][1], vector(4,j,Mod(subst(polys[j],x,th),P8)), vector(6,j,Mod(subst(polys[4+j],x,th),P8)), vector(6,j,Mod(subst(polys[10+j],x,th),P8)), cN, ri, H];
    print("orbit ", o, " size ", SZ[o], ": recognised, max lindep coefficient ", H));}
print("perturbation null: ", NULLTRY, " tries, ", NULLFAIL, " false positives");
MON2 = [[2,0,0],[1,1,0],[1,0,1],[0,2,0],[0,1,1],[0,0,2]];
qp(Q) = sum(m=1,6, Q[m]*c0^MON2[m][1]*c1^MON2[m][2]*c2^MON2[m][3]);
Xof(k, n) = { my(X=vector(4), cs=[c0,c1,c2], keep=select(i->i!=k+1,[1..4])); for(j=1,3, X[keep[j]]=cs[j]); X[k+1] = -sum(j=1,3, n[keep[j]]*cs[j]); X; }
Fof(X, c) = sum(i=1,4, X[i]^4) + c*X[1]*X[2]*X[3]*X[4];
NOK = 0;
{for(o=1,#V, if(EX[o]==0, next); my(k=EX[o][1], n=EX[o][2], Q1=EX[o][3], Q2=EX[o][4], c=EX[o][5], D, d1, d2, M1, M2, prop);
  D = Fof(Xof(k,n), c) - qp(Q1)*qp(Q2);
  M1 = matrix(3,3,a,b, if(a==b, Q1[[1,4,6][a]], Q1[[0,2,3;2,0,5;3,5,0][a,b]]/2));
  M2 = matrix(3,3,a,b, if(a==b, Q2[[1,4,6][a]], Q2[[0,2,3;2,0,5;3,5,0][a,b]]/2));
  d1 = matdet(M1); d2 = matdet(M2);
  prop = matrank(Mat([Q1~, Q2~]));
  print("orbit ", o, ": F|plane - Qrep*Qres == 0 : ", D==0, "   n[k+1]==1: ", n[k+1]==1, "   det Qrep != 0: ", d1!=0, "   det Qres != 0: ", d2!=0, "   rank[Qrep,Qres] = ", prop);
  if(D==0 && d1!=0 && d2!=0 && prop==2 && n[k+1]==1, NOK++));}
print("EXACT OK: ", NOK, " / ", #V);
write("exact736.gp", "P8x = ", P8x, ";"); write("exact736.gp", "EX = ", EX, ";");
