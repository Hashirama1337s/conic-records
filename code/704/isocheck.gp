default(parisizemax, 2000000000);
read("gram704_cert.gp"); read("gd704.gp"); read("iso704_perm.gp");
print("PI is a permutation of 1..704: ", vecsort(PI)==[1..704]);
print("Gd[PI,PI] == Gc (exact, PARI): ", vecextract(Gd, PI, PI) == Gc);
