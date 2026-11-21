default(nbthreads,1);
dprof(G, sgn) = { my(S=matsnf(G,1), U=S[1], V=S[2], D=S[3], n=matsize(G)[1], gens=List(), ords=List(), L=Map());
  for(j=1,n, if(D[j,j]!=1 && D[j,j]!=-1, listput(gens, V[,j]/D[j,j]); listput(ords, abs(D[j,j]))));
  gens=Vec(gens); ords=Vec(ords);
  forvec(a=vector(#gens,i,[0,ords[i]-1]), my(x=sum(i=1,#gens,a[i]*gens[i]), q, o); q = sgn*x~*G*x; q = q - 2*floor(q/2); o = denominator(content(x)); my(k=[o,q]); if(mapisdefined(L,k,&m), mapput(L,k,m+1), mapput(L,k,1)));
  [ords, Mat(L)]; }
read("ns736.gp"); hc = matinverseimage(Bm~, hv~); NSf = -G + (G*hc)*(G*hc)~/2; print("det NS = ", matdet(NSf), "  signature-check h^2 = ", hc~*NSf*hc);
PN = dprof(NSf, 1); print("NS discr: ", PN[1]);
{ for(a=2,30, for(b=0,a, for(c=a,200, if(a*c-b^2==192 && a%2==0 && c%2==0, my(T=[a,b;b,c], P=dprof(T,-1)); print("[",a,",",2*b,",",c,"] ", if(P[2]==PN[2],"MATCHES -q_NS","no")))))); }
quit
