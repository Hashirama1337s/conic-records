default(parisizemax, 2000000000);
read("gram660_cert.gp"); read("gd660.gp"); read("iso660_perm.gp");
print("PI is a permutation of 1..660: ", vecsort(PI)==[1..660]);
print("Gd[PI,PI] == Gc (exact, PARI): ", vecextract(Gd, PI, PI) == Gc);
