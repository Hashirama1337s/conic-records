default(parisizemax, 2000000000);
read("bbext.gp");
lA(G) = #select(x->x>1, matsnf(G));
TT = eval(getenv("TT")); if(TT==0 || type(TT)!="t_VEC", TT = [4,6,7]);
c1 = cand(TT[1]); c2 = cand(TT[2]); c3 = cand(TT[3]);
print("candidates: ", #c1, " ", #c2, " ", #c3);
u1 = c1[1];
pairs = Map(); t0=getabstime();
{ for(i=1,#c2, for(p=0,2, my(X=lat([u1,c2[i]], [0,p;p,0]), I=info(X)); if(I==0, next); if(I[2][1]!=0 || I[2][4]!=0 || lA(X[1])>3, next);
   if(!mapisdefined(pairs, I), mapput(pairs, I, [c2[i], p])))); }
PR = Mat(pairs); print("pair classes: ", matsize(PR)[1], " (", getabstime()-t0, " ms)"); print(PR[,1]~);
FOUND = List(); res = Map();
{ for(j=1,matsize(PR)[1], my(u2=PR[j,2][1], p12=PR[j,2][2]); t0=getabstime();
   for(k=1,#c3, for(p13=0,2, for(p23=0,2, my(X=lat([u1,u2,c3[k]], [0,p12,p13;p12,0,p23;p13,p23,0]), I=info(X)); if(I==0, next); if(I[2][1]!=0 || I[2][4]!=0 || lA(X[1])>2, next);
      my(key=[abs(I[1]), I[2][2], I[2][3]]); if(mapisdefined(res,key,&nn), mapput(res,key,nn+1), mapput(res,key,1));
      if(I[2][3] == 704, print("  HIT ", I, " ", matsnf(X[1])[1..2], " U=", [u1,u2,c3[k]], " Pr=", [p12,p13,p23]); write("degt704.gp", "GD = ", X[1], ";"); write("degt704.gp", "HD = ", X[2], ";"); write("degt704.gp", "UD = ", [u1,u2,c3[k]], ";"); write("degt704.gp", "PD = ", [p12,p13,p23], ";"); quit)))); print(" pair ", j, " done (", getabstime()-t0, " ms)")); }
print(Mat(res));
write("bb704found_"TT[1]TT[2]TT[3]".gp", "FOUND=", FOUND);
