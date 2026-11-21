read("tgen.gp");
n=0; forvec(v=vector(4,i,[-6,6]), if(v!=0 && v*GT*v~==0, n++; if(n<=3, print("isotropic: ", v))));
print("isotropic vectors in box 6: ", n);
print("qfsign ", qfsign(GT), " det ", matdet(GT), " issquare(det) ", issquare(matdet(GT)));
quit
