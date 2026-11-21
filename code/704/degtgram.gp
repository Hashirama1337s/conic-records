/* degtgram.gp (cert704): conic Gram of the rebuilt Degtyarev lattice S_h[u1,u2,u3] (704 row, Table 6 of 2108.11181) */
default(parisizemax, 2000000000);
read("degt704.gp");
G = GD; hp = HD;
print("det ", matdet(G), "  snf ", matsnf(G), "  sign ", qfsign(G), "  h^2 = ", hp~*G*hp);
w = G*hp; Mp = w*w~ - 2*G; L = qfminim(Mp, 8)[3];
V = List(); {for(i=1,#L, my(v=L[,i], s=v~*G*v, d=w~*v); if(s==-2 && abs(d)==2, listput(V, sign(d)*v)); if(s==-2 && abs(d)<2, print("ROOT/LINE ", d)));}
V = Mat(Vec(V)); print("conic classes: ", #V);
Gd = V~*G*V;
print("span of conics: rank ", matrank(V), "  index in lattice: ", abs(matdet(mathnf(V))));
VC = Map(); {for(i=1,#Gd, for(j=1,#Gd, my(v=Gd[i,j]); mapput(VC, v, if(mapisdefined(VC,v), mapget(VC,v)+1, 1))));}
print("Gram value counts: ", Mat(VC));
/* discriminant form of G vs T = [8,4,28]: q on generators of G^*/G */
dq(M) = { my(Mi=M^-1, [U,Vv,D]=matsnf(M,1), gens=List()); for(i=1,#D, if(D[i,i]>1, my(x=Mi*Vv[,i]*D[i,i]/D[i,i]); listput(gens,[D[i,i], x]))); gens; };
T = [8,4;4,28]; print("T = [8,4,28]: det ", matdet(T), " snf ", matsnf(T));
write("gd704.gp", "Gd = ", Gd, ";");
print("DEGT_DONE");
