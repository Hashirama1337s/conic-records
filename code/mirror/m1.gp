/* MIRROR m1: O(NS_gen,h) -> O(q_NS); |O(q_NS)|; index. Convention: Gg is the P-form, I = -Gg + (Gg h)(Gg h)~/2. */
default(nbthreads,1);
default(parisizemax, 2000000000);
read("nsgen.gp");
Ph = Gg*hg; Ig = -Gg + Ph*Ph~/2;
print("I sign ", qfsign(Ig), " det ", matdet(Ig));
A = qfauto([Gg, Ph*Ph~]);
print("|O(NS_gen,h)| (P-form autos fixing h-flag; may include -h) = ", A[1]);
gens = A[2];
gens = select(g-> g*hg==hg, gens);
\\ group closure restricted to h-fixing elements: easier to take all gens and multiply by -1 where needed
gens2 = vector(#A[2], i, my(g=A[2][i]); if(g*hg==hg, g, -g));
print("all gens fix h after sign fix: ", vecprod(vector(#gens2,i,gens2[i]*hg==hg)));
redc(x) = x - apply(floor, x);
[U,Vm,Dm] = matsnf(Ig, 1);
gA = List(); od = List();
for(i=1,18, if(Dm[i,i]>1, listput(gA, Vm[,i]/Dm[i,i]); listput(od, Dm[i,i])));
gA = Vec(gA); od = Vec(od); print("A_NS orders ", od);
Vi = Vm^-1;
coords(x) = vector(#od, i, my(c = (Vi*x)[ #Dm - #od + i ]); 0);
\\ simpler: index by full enumeration
Aall = List(); forvec(k=vector(#od,i,[0,od[i]-1]), listput(Aall, redc(sum(i=1,#od,k[i]*gA[i]))));
Aall = Vec(Aall); As = Aall; print("|A| ", #As);
kv(x) = my(c = Vi*x); vector(#od, i, (c[i]*od[i]) % od[i]);
idx(x) = my(k = kv(x), r = 0); for(i=1,#od, r = r*od[i] + k[i]); r+1;
qq(x) = my(v = x~*Ig*x); v - 2*floor(v/2);
bb(x,y) = my(v = x~*Ig*y); v - floor(v);
\\ permutation of A induced by g
perm(g) = vector(#As, i, idx(g*As[i]));
P = vector(#gens2, i, perm(gens2[i]));
print("perms ok: ", vecmin(vector(#P,i,vecmin(P[i]))) > 0);
\\ closure of permutation group
pmul(a,b) = vector(#a, i, a[b[i]]);
S = Set([vector(#As,i,i)]); todo = [vector(#As,i,i)];
while(#todo, x = todo[#todo]; todo = todo[1..#todo-1]; for(i=1,#P, y = pmul(P[i],x); if(!setsearch(S,y), S = setunion(S,[y]); todo = concat(todo,[y]))));
print("|H| = |image of O(NS_gen,h) in O(A_NS)| = ", #S);
\\ O(q_NS) by brute force on generator images
cands = vector(#od, i, select(y -> denominator(od[i]*y)==1 && (qq(y)==qq(gA[i])) && ( od[i]*y - 0 == od[i]*y), As));
\\ keep only elements of exact order od[i]
ordr(y) = my(k=1); while(denominator(k*y)>1, k++); k;
cands = vector(#od, i, select(y-> ordr(y)==od[i] && qq(y)==qq(gA[i]), As));
print("cand sizes ", vector(#od,i,#cands[i]));
Oq = List();
{for(a=1,#cands[1], y1=cands[1][a];
 for(b=1,#cands[2], y2=cands[2][b]; if(bb(y1,y2)!=bb(gA[1],gA[2]), next);
  for(c=1,#cands[3], y3=cands[3][c]; if(bb(y1,y3)!=bb(gA[1],gA[3]) || bb(y2,y3)!=bb(gA[2],gA[3]), next);
   for(d=1,#cands[4], y4=cands[4][d]; if(bb(y1,y4)!=bb(gA[1],gA[4]) || bb(y2,y4)!=bb(gA[2],gA[4]) || bb(y3,y4)!=bb(gA[3],gA[4]), next);
     \\ q of sums is determined by q and b for even forms; check bijectivity
     im = Set(vector(#As, i, 0));
     listput(Oq, [y1,y2,y3,y4])))));}
\\ filter bijective
kco(x) = 0;
bij(Y) = { my(T = Set()); forvec(k=vector(#od,i,[0,od[i]-1]), T = setunion(T, [redc(sum(i=1,#od,k[i]*Y[i]))])); #T == #As };
Oq = select(bij, Vec(Oq));
print("|O(q_NS)| = ", #Oq);
print("index [O(q_NS) : H] = ", #Oq / #S);
writebin("runs/m1.bin", [As, P, Vec(S), Oq, gA, od]);
quit
