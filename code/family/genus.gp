read("curves.gp");
{for(i=1,#CURVES, f = CURVES[i](x,t); d = poldegree(f,x);
  if(d==1, print(CNAMES[i], ": linear in E -> rational, E = ", -polcoeff(f,0,x)/polcoeff(f,1,x)); next);
  D = poldisc(f, x); F = factor(D); sq = prod(k=1,#F[,1], if(F[k,2]%2, F[k,1], 1)); c = content(sq);
  print(CNAMES[i], ": quadratic in E, disc(t) = square * ", sq, "   deg ", poldegree(sq,t), " -> genus ", max(0, ceil(poldegree(sq,t)/2)-1)));}
quit
