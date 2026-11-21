/* FAMILYMAP meet2: all pairwise intersections and singular points of the 8 NL curves, off the discriminant.
   For each t-factor: degree, E as a function (via gcd), number of real points, and whether the point lies on a third curve. */
default(nbthreads,1);
default(parisizemax, 1000000000);
read("curves.gp");
P = vector(#CURVES, i, CURVES[i](x, t));   \\ polynomials in x (=E) over Q[t]
DT = t*(t+1)*(t+2)*(t+3);
DE = [x-2*t-4, 3*x-4*t-12, x-4*t-4];
\\ for an irreducible t-factor ft and two curve polys, get the common E root factor over Q[t]/ft
report(name, ft, f1, f2) = {
  my(a = Mod(t, ft), g, Ex, onr, rr, dsc, d);
  g = gcd(subst(f1, t, a), subst(f2, t, a));
  d = poldegree(g, x);
  if(d!=1, print("   ", name, "  t: ", ft, "   (E not unique over Q(t): gcd degree ", d, ")"); return);
  Ex = lift(-polcoeff(g,0,x)/polcoeff(g,1,x));
  dsc = lift(subst(subst(DT,t,a),x,0)*prod(i=1,3, subst(subst(DE[i],x,Ex),t,a)));
  if(dsc==0, return);   \\ on the discriminant: skip
  onr = vector(#P, i, if(lift(subst(subst(P[i], x, Ex), t, a))==0, CNAMES[i], ""));
  rr = #select(r-> abs(imag(r))<1e-30, polroots(ft));
  print("   ", name, "  t: ", ft, "  E = ", Ex, "   real points: ", rr, "   on: ", select(s->s!="", onr));
};
{for(i=1,#P, for(j=i,#P,
   if(i==j,
     print("== singular points of ", CNAMES[i]);
     R = polresultant(P[i], deriv(P[i], x), x); R2 = polresultant(P[i], deriv(P[i], t), x);
     g = gcd(R, R2); if(poldegree(g)<1, next);
     F = factor(g)[,1];
     for(k=1,#F, ft=F[k]; if(poldegree(ft,t)<1, next);
        \\ check it is a genuine singular point: common root of P, P_E, P_t
        K = Mod(t, ft); h = gcd(gcd(subst(P[i],t,K), subst(deriv(P[i],x),t,K)), subst(deriv(P[i],t),t,K));
        if(poldegree(h,x)>=1, report(Str(CNAMES[i], " node"), ft, subst(lift(h),t,t), deriv(P[i],x))));
   ,
     print("== ", CNAMES[i], " x ", CNAMES[j]);
     R = polresultant(P[i], P[j], x);
     if(R==0, print("   common component!"); next);
     F = factor(R);
     for(k=1,#F[,1], ft=F[k,1]; if(poldegree(ft,t)<1, next);
        report(Str("mult ", F[k,2]), ft, P[i], P[j])) )));}
quit
