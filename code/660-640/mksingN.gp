/* mksingN.gp (cert660, generic from cert736/mksing736.gp): write a Singular replay of the identities F|plane = Qrep*Qres over N.
   Header defines EXFILE, SINGFILE, FSING (Singular expression of F in X0..X3). */
vv = ['c0,'c1,'c2,'s]; th = varlower("th");
read(EXFILE);
f = SINGFILE;
S(z) = { my(t = Str(lift(z))); t = strjoin(strsplit(t, "th"), "a"); Str("(", t, ")"); };
write(f, "ring r = (0,a),(c0,c1,c2),dp;");
write(f, "minpoly = ", strjoin(strsplit(Str(P8x), "x"), "a"), ";");
write(f, "int ok = 0; int nc = 0; poly X0,X1,X2,X3,F,Q1,Q2,D;");
{for(o=1,#EX, my(k=EX[o][1], n=EX[o][2], Q1=EX[o][3], Q2=EX[o][4], keep=select(i->i!=k+1,[1..4]), cs=["c0","c1","c2"], X=vector(4), mons=["c0^2","c0*c1","c0*c2","c1^2","c1*c2","c2^2"]);
  for(j=1,3, X[keep[j]] = cs[j]);
  X[k+1] = Str("-(", S(n[keep[1]]), "*c0+", S(n[keep[2]]), "*c1+", S(n[keep[3]]), "*c2)");
  write(f, "X0=", X[1], "; X1=", X[2], "; X2=", X[3], "; X3=", X[4], ";");
  write(f, "F = ", FSING, ";");
  write(f, "Q1 = ", strjoin(vector(6,m,Str(S(Q1[m]),"*",mons[m])), "+"), ";");
  write(f, "Q2 = ", strjoin(vector(6,m,Str(S(Q2[m]),"*",mons[m])), "+"), ";");
  write(f, "D = F - Q1*Q2; if (D == 0) { ok = ok + 1; } \"orbit ", o, ": F|plane - Qrep*Qres == 0 :\", D == 0;");
  write(f, "D = F - (Q1+1/1000000)*Q2; if (D != 0) { nc = nc + 1; } \"   negative control (Qrep + 1e-6) nonzero:\", D != 0;"));}
write(f, "\"Singular identities OK:\", ok, \"/ ", #EX, "   negative controls nonzero:\", nc;");
write(f, "quit;");
