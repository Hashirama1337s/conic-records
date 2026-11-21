/* had640.gp (cert660): the exact link between the Dwork model and X640, and between X640 and the brief's form. */
H = [1,1,1,1; 1,1,-1,-1; 1,-1,1,-1; 1,-1,-1,1]; XV = [y1,y2,y3,y4]~;
FD(X) = X[1]^4+X[2]^4+X[3]^4+X[4]^4 + 28*X[1]*X[2]*X[3]*X[4];
F640 = y1^4+y2^4+y3^4+y4^4 - (y1^2*y2^2+y1^2*y3^2+y1^2*y4^2+y2^2*y3^2+y2^2*y4^2+y3^2*y4^2) + 10*y1*y2*y3*y4;
print("F_Dwork(H v) == 32*F640(v): ", FD(H*XV) == 32*F640, "   det H = ", matdet(H), "   H^2 = 4 I: ", H^2 == 4*matid(4));
