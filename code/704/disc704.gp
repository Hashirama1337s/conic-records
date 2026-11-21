/* disc704.gp (cert704): discriminant-form profile of NS(X704) vs -q of the even positive binary forms of det 208 */
default(nbthreads,1); default(parisizemax, 2000000000);
dprof(G, sgn) = { my(S=matsnf(G,1), V=S[2], D=S[3], n=matsize(G)[1], gens=List(), ords=List(), L=Map());
  for(j=1,n, if(D[j,j]!=1 && D[j,j]!=-1, listput(gens, V[,j]/D[j,j]); listput(ords, abs(D[j,j]))));
  gens=Vec(gens); ords=Vec(ords);
  forvec(a=vector(#gens,i,[0,ords[i]-1]), my(x=sum(i=1,#gens,a[i]*gens[i]), q, o); q = sgn*x~*G*x; q = q - 2*floor(q/2); o = denominator(content(x)); my(k=[o,q]); if(mapisdefined(L,k,&m), mapput(L,k,m+1), mapput(L,k,1)));
  [ords, Mat(L)]; }
read("gram704_cert.gp"); N=#Gc; [H,U]=mathnf(Gc,1); r=#H; Y=U[,N-r+1..N]; S=Y~*Gc*Y;
PNS = dprof(S, 1); print("NS discriminant group: ", PNS[1]);
read("degt704.gp"); PD = dprof(GD, 1); print("rebuilt Degtyarev lattice: same profile as NS: ", PD[2]==PNS[2]);
{ for(a=2,30, for(b=0,a/2, for(c=a,208, if(a*c-b^2==208 && a%2==0 && c%2==0, my(T=[a,b;b,c], P=dprof(T,-1)); print("[",a,",",2*b,",",c,"] (Gram [",a,",",b,";",b,",",c,"]) ", if(P[2]==PNS[2],"MATCHES -q_NS","no")))))); }
