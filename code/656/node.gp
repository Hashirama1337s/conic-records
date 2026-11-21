NB=21097*E^2*t^4+80104*E^2*t^3+157848*E^2*t^2+33952*E^2*t+1936*E^2-73368*E*t^5-486792*E*t^4-1211264*E*t^3-1129920*E*t^2-11904*E*t-15488*E+63504*t^6+598752*t^5+2120976*t^4+3256704*t^3+1564288*t^2-495616*t+30976;
NA=73*E^2*t^2+244*E^2*t+196*E^2-216*E*t^3-1896*E*t^2-3328*E*t-1568*E+1296*t^4+6048*t^3+11088*t^2+9408*t+3136;
N1=E*(t-1)^2-2*(t+2)*(3*t+1)^2;
P=[E,t]; v=[784/361,-10/9];
ev(f)=substvec(f,P,v);
print("NB, dNB/dE, dNB/dt at Q3: ", [ev(NB), ev(deriv(NB,E)), ev(deriv(NB,t))]);
H=[ev(deriv(deriv(NB,E),E)), ev(deriv(deriv(NB,E),t)); ev(deriv(deriv(NB,t),E)), ev(deriv(deriv(NB,t),t))]; print("Hessian det ", matdet(H), " sign ", sign(matdet(H)));
print("N1 at Q3 ", ev(N1), "  NA at Q3 ", ev(NA));
\ the three curves at the target
f=9*t^3+48*t^2+125*t+122; Et=(1688-1140*t-1044*t^2)/361;
print("N1,NA,NB mod cubic at target: ", [lift(Mod(subst(N1,E,Et),f)), lift(Mod(subst(NA,E,Et),f)), lift(Mod(subst(NB,E,Et),f))]);
