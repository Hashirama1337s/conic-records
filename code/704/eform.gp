/* eform.gp (cert704): exact equivalence of the E-form and the Smith form on 9t^2+36t+52 = 0 */

T = Mod(t, 9*t^2+36*t+52);
lam = 1/T; E = -(36*T+108)/25; s2 = 2*lam/(1+lam);
print("52 lam^2 + 36 lam + 9 = ", 52*lam^2+36*lam+9);
print("E == 4 lam/(1+lam): ", E == 4*lam/(1+lam), "   E == 2 s^2: ", E == 2*s2, "   E(1+t) == 4: ", E*(1+T) == 4);
q = x^2+y^2+z^2; p4 = x^4+y^4+z^4;
G = p4 + s2^2*w^4 + lam*(q + s2*w^2)^2;
print("G/lam - (E w^4 + E q w^2 + q^2 + t p4) == 0: ", G/lam - (E*w^4 + E*q*w^2 + q^2 + T*p4) == 0);
print("lam roots: ", polroots(52*x^2+36*x+9), "   t = 1/lam: ", polroots(9*x^2+36*x+52));
print("s^2 = ", lift(s2), "  (mod 9t^2+36t+52); at lam=(-9+6i)/26: ", subst(lift(s2), t, 26/(-9+6*I)));
