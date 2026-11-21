/* discown.gp (cert660): transcendental lattice from OUR certified NS = S (both surfaces).  T is even, positive definite,
   rank 2, det |det S|, with discriminant form -q_S (Nikulin, CITED).  Enumerate all reduced even binary forms of that det
   and compare the discriminant-form profile ([order, q mod 2] counts, from r664/disc.gp); a unique match determines T. */
default(parisizemax, 4000000000);
dprof(G, sgn) = { my(S=matsnf(G,1), U=S[1], V=S[2], D=S[3], n=matsize(G)[1], gens=List(), ords=List(), L=Map());
  for(j=1,n, if(D[j,j]!=1 && D[j,j]!=-1, listput(gens, V[,j]/D[j,j]); listput(ords, abs(D[j,j]))));
  gens=Vec(gens); ords=Vec(ords);
  forvec(a=vector(#gens,i,[0,ords[i]-1]), my(x=sum(i=1,#gens,a[i]*gens[i]), q, o); q = sgn*x~*G*x; q = q - 2*floor(q/2); o = denominator(content(x)); my(k=[o,q]); if(mapisdefined(L,k,&m), mapput(L,k,m+1), mapput(L,k,1)));
  [ords, Mat(L)]; }
Sof(file) = { read(file); my(N = #Gc, H, U, r, Y); [H, U] = mathnf(Gc, 1); r = #H; Y = U[, N - r + 1 .. N]; Y~ * Gc * Y; };
chk(f) = { my(S = Sof(f), d = abs(matdet(S)), P = dprof(S, 1), nh = 0);
   print(f, ": det S = ", matdet(S), "   discriminant group ", P[1]);
   forstep(a=2, sqrtint(floor(4*d/3))+2, 2, for(b=0, a/2, if((d + b^2) % a == 0, my(c = (d + b^2)/a); if(c >= a && c % 2 == 0,
      my(T = [a, b; b, c], Pt = dprof(T, -1)); print("   T = [", a, ",", b, ",", c, "] ", if(Pt[2]==P[2], "MATCHES -q_S", "no")); if(Pt[2]==P[2], nh++)))));
   print("   matching forms: ", nh); }
chk("gram660_cert.gp");
chk("gram640_cert.gp");
