default(parisizemax, 2000000000);
read("gram736_cert.gp"); read("gd736.gp"); read("iso736_perm.gp");
print("PI is a permutation of 1..736: ", vecsort(PI)==[1..736]);
print("Gd[PI,PI] == Gc (exact, PARI): ", vecextract(Gd, PI, PI) == Gc);
