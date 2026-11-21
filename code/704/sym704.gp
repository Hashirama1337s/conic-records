/* sym704.gp (cert704): O_h(NS) from the certified Gram (NS = S, EXACT from lattice704.gp), its action on the 704 conic
   classes and on the discriminant group S^*/S; writes sym704.g for GAP. */
default(parisizemax, 4000000000);
read("gram704_cert.gp");
N = #Gc;
[H, U] = mathnf(Gc, 1); r = #H; Y = U[, N - r + 1 .. N]; S = Y~ * Gc * Y;
A = matinverseimage(H, Gc);                 /* conic coordinates, columns */
J4 = select(j->Gc[1,j]==4, [1..N]); hv = A[,1] + A[,J4[1]];
w = S*hv; Q1 = -2*S + w*w~; Q2 = w*w~;
print("Q1 positive definite: ", qfsign(Q1)==[20,0]);
AU = qfauto([Q1, Q2]);
print("common automorphism group of (2B, (v.h)^2): order ", AU[1]);
/* keep g with g*hv == hv; the group is O_h(S) x {+-1} */
gens = AU[2]; print("#generators ", #gens);
/* check: qfauto returns matrices g with g~*Q*g == Q acting on coordinates (column vectors) */
{for(t=1,#gens, my(g=gens[t]); if(g~*S*g != S, error("not an isometry of S")));}
fixh(g) = if(g*hv == hv, g, -g);
gens = apply(fixh, gens);
{for(t=1,#gens, if(gens[t]*hv != hv, error("does not fix +-h")));}
/* conic permutation */
CK = Map(); for(i=1,N, mapput(CK, A[,i], i));
cperm(g) = vector(N, i, mapget(CK, g*A[,i]));
/* discriminant group: S^* = S^-1 Z^20, elements as fractional-part vectors */
Si = S^-1;
fr(v) = v - floor(v);
D = Map(); DL = List(); listput(DL, vector(r)~ ); mapput(D, vector(r)~, 1);
{my(qi=1); while(qi <= #DL, my(x=DL[qi]); qi++; for(i=1,r, my(y=fr(x + Si[,i])); if(!mapisdefined(D,y), listput(DL,y); mapput(D,y,#DL))));}
print("|S^*/S| = ", #DL);
dperm(g) = vector(#DL, k, mapget(D, fr(g*DL[k])));
minus = vector(#DL, k, mapget(D, fr(-DL[k])));
f = "sym704.g";
write(f, "lat := [");
{for(t=1,#gens, write(f, "PermList(", cperm(gens[t]), ")", if(t<#gens, ",", "")));}
write(f, "];");
write(f, "dis := [");
{for(t=1,#gens, write(f, "PermList(", dperm(gens[t]), ")", if(t<#gens, ",", "")));}
write(f, "];");
write(f, "minus := PermList(", minus, ");");
/* discriminant form value q(x) mod 2Z for checking: */
print("SYM_DONE");
