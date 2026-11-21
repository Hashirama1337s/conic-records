/* degtgram736b.gp (cert736): Degtyarev's (5.10) conic Gram in the NS form (r736/c736.py convention:
   x o y = (1/2)(x.h)(y.h) - x.y in the N-form G of ns736.gp), so for conics (x.h = 2): Gd_NS = 2 - Gd_N.  Output gd736.gp. */
default(parisizemax, 2000000000);
read("ns736.gp");
X = matsolve(Bm~*1, C2~); hx = matsolve(Bm~*1, hv~);
w = G*hx; GNS = w*w~/2 - G;
print("NS-form basis Gram: det ", matdet(GNS), "  snf ", matsnf(GNS), "  signature ", qfsign(GNS), "  h o h = ", hx~*GNS*hx);
Gd = X~*GNS*X;
print("diag: ", Set(vector(#Gd,i,Gd[i,i])), "   h o c: ", Set(hx~*GNS*X), "   Gd == 2 - Gd_N: ", Gd == matrix(#Gd,#Gd,i,j,2) - X~*G*X);
VC = Map(); {for(i=1,#Gd, for(j=1,#Gd, my(v=Gd[i,j]); mapput(VC, v, if(mapisdefined(VC,v), mapget(VC,v)+1, 1))));}
print("Gram value counts: ", Mat(VC));
write("gd736.gp", "Gd = ", Gd, ";");
print("DEGT_DONE");
