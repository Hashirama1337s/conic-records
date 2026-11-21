/* mksing736.gp (cert736, from cert704/mksing704.gp): write replay736.sing, a Singular replay of the 8 identities F|plane = Qrep*Qres over N = Q(zeta24). */
vv = ['c0,'c1,'c2,'s]; th = varlower("th");
read("exact736.gp");
f = "replay736_regen.sing";
S(z) = { my(t = Str(lift(z))); t = strjoin(strsplit(t, "th"), "a"); Str("(", t, ")"); };
write(f, "ring r = (0,a),(c0,c1,c2),dp;");
write(f, "minpoly = ", strjoin(strsplit(Str(P8x), "x"), "a"), ";");
write(f, "int ok = 0; poly X0,X1,X2,X3,F,Q1,Q2,D; number cc;");
{for(o=1,#EX, my(k=EX[o][1], n=EX[o][2], Q1=EX[o][3], Q2=EX[o][4], iN=EX[o][5], keep=select(i->i!=k+1,[1..4]), cs=["c0","c1","c2"], X=vector(4), mons=["c0^2","c0*c1","c0*c2","c1^2","c1*c2","c2^2"]);
  for(j=1,3, X[keep[j]] = cs[j]);
  X[k+1] = Str("-(", S(n[keep[1]]), "*c0+", S(n[keep[2]]), "*c1+", S(n[keep[3]]), "*c2)");
  write(f, "X0=", X[1], "; X1=", X[2], "; X2=", X[3], "; X3=", X[4], ";");
  write(f, "cc = ", S(iN), "; \"   cc^4+144 == 0:\", cc^4+144 == 0;");
  write(f, "F = X0^4+X1^4+X2^4+X3^4 + cc*X0*X1*X2*X3;");
  write(f, "Q1 = ", strjoin(vector(6,m,Str(S(Q1[m]),"*",mons[m])), "+"), ";");
  write(f, "Q2 = ", strjoin(vector(6,m,Str(S(Q2[m]),"*",mons[m])), "+"), ";");
  write(f, "D = F - Q1*Q2; if (D == 0) { ok = ok + 1; } \"orbit ", o, ": F|plane - Qrep*Qres == 0 :\", D == 0;");
  write(f, "D = F - (Q1+1/1000000)*Q2; \"   negative control (Qrep + 1e-6) nonzero:\", D != 0;"));}
write(f, "\"Singular identities OK:\", ok, \"/ ", #EX, "\";");
write(f, "quit;");
