\\ dump.gp (lab 0.28.0 Lean proof of concept): the 20x20 lattice S of exactub/lattice.gp and the basis of ker(S mod 2),
\\ written as Lean list literals. Same construction as lattice.gp lines 7-11 and 27-28 (read-only reuse).
default(parisizemax, 4000000000);
read("gram_cert.gp");
N = #Gc;
[H, U] = mathnf(Gc, 1);
r = #H;
Y = U[, N - r + 1 .. N];
S = Y~ * Gc * Y;
Ainv = matinverseimage(H, Gc);
hv = Ainv[,1] + Ainv[,2];
K2 = lift(matker(Mod(S, 2)));
print("rank ", r, " det ", matdet(S), " dimker2 ", #K2, " h^2 ", hv~*S*hv);
lst(v) = my(s = "["); for (i = 1, #v, s = concat(s, Str(v[i])); if (i < #v, s = concat(s, ", "))); concat(s, "]");
rows = "["; for (i = 1, r, rows = concat(rows, lst(S[i,])); if (i < r, rows = concat(rows, ",\n  "))); rows = concat(rows, "]");
write("S20.txt", rows);
for (k = 1, #K2, my(v = K2[,k]); write("K2.txt", lst(v)); print("v", k, " vSv = ", v~*S*v, "  x^2 = ", v~*S*v/4));
my(v = (K2[,1] + K2[,2]) % 2); print("v1+v2 mod 2: vSv = ", v~*S*v, "  x^2 = ", v~*S*v/4);
write("h.txt", lst(hv~));
quit;
