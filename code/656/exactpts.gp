/* MATH: exact E = e^2 at each intersection factor (minimal polynomial of E), and the target in a reduced basis */
N1(E,t) = E*(t-1)^2 - 2*(t+2)*(3*t+1)^2;
NA(E,t) = 73*E^2*t^2+244*E^2*t-216*E*t^3+196*E^2-1896*E*t^2+1296*t^4-3328*E*t+6048*t^3-1568*E+11088*t^2+9408*t+3136;
NB(E,t) = 21097*E^2*t^4+80104*E^2*t^3-73368*E*t^5+157848*E^2*t^2-486792*E*t^4+63504*t^6+33952*E^2*t-1211264*E*t^3+598752*t^5+1936*E^2-1129920*E*t^2+2120976*t^4-11904*E*t+3256704*t^3-15488*E+1564288*t^2-495616*t+30976;
{
facs = [[1,2, 13*y^2+17*y+6], [1,2, 5*y+7], [1,3, 9*y+10], [1,3, 1913*y^3+3760*y^2+301*y+218], [2,3, 17*y+26], [2,3, 9*y^2+36*y+52], [2,3, 657*y^2+660*y+292], [2,3, 9*y^3+6*y^2-4*y+8], [1,2, 9*y^3+48*y^2+125*y+122]];
C = [N1, NA, NB];
for(k = 1, #facs,
  my(i = facs[k][1], j = facs[k][2], f = facs[k][3], T = Mod(y, f), g, Ev, mp);
  g = gcd(C[i](x, T), C[j](x, T));
  if(poldegree(g, x) != 1, print(f, ": gcd degree ", poldegree(g,x), " ", g); next);
  Ev = -polcoef(g, 0, x) / polcoef(g, 1, x);
  mp = charpoly(Ev, x);
  print("t-factor ", f, "  curves ", [i,j], "  E = ", lift(Ev), "   charpoly(E) = ", factor(mp)));
}
f = 9*y^3+48*y^2+125*y+122;
[P, a] = polredabs(f, 1);
print("reduced field poly ", P, "; t = ", lift(a), " (in a root th of it)");
T = a; Eth = (1688 - 1140*T - 1044*T^2)/361;
print("E in th: ", lift(Eth));
print("check t, E satisfy all three curves: ", [N1(Eth, T), NA(Eth, T), NB(Eth, T)]);
print("norm of E: ", norm(Eth), "  trace: ", trace(Eth));
quit
