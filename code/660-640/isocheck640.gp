default(parisizemax, 2000000000);
read("gram640_cert.gp"); read("gd640.gp"); read("iso640_perm.gp");
print("PI is a permutation of 1..640: ", vecsort(PI)==[1..640]);
print("Gd[PI,PI] == Gc (exact, PARI): ", vecextract(Gd, PI, PI) == Gc);
