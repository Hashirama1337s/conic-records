# sym704gap.g (cert704): Sym(X704) from the lattice (Torelli/Nikulin rule) vs the geometric W(B4) action
Read("sym704.g"); Read("geo704.g");
Oh := Group(lat);
Print("|O_h(NS)| = ", Size(Oh), "\n");
Dg := Group(dis);
hom := GroupHomomorphismByImages(Oh, Dg, lat, dis);
Print("hom well defined: ", hom <> fail, "\n");
pm := Group(minus);
Sym := PreImage(hom, Intersection(Image(hom), pm));
SpG := Kernel(hom);
Print("minus in image of O_h: ", minus in Image(hom), "\n");
Print("|Sym| (act as +-1 on discr) = ", Size(Sym), "   IdGroup ", IdGroup(Sym), "  ", StructureDescription(Sym), "\n");
Print("|Sp|  (act as +1 on discr)  = ", Size(SpG), "   IdGroup ", IdGroup(SpG), "  ", StructureDescription(SpG), "\n");
Geo := Group(geo);
Print("|geometric W(B4) image| = ", Size(Geo), "   IdGroup ", IdGroup(Geo), "\n");
Print("Geo subgroup of O_h: ", IsSubgroup(Oh, Geo), "   Geo = Sym: ", Geo = Sym, "\n");
# symplectic part of Geo: elements of det +1 (all three generators have det -1)
sgn := GroupHomomorphismByImages(Geo, Group((1,2)), geo, List(geodet, d -> (1,2)^((1-d)/2)));
GeoSp := Kernel(sgn);
Print("|Geo symplectic (det +1)| = ", Size(GeoSp), "   GeoSp = SpG: ", GeoSp = SpG, "   IdGroup ", IdGroup(GeoSp), "\n");
Print("orbits of Sym on conics: ", SortedList(List(Orbits(Sym, [1..704]), Length)), "\n");
Print("orbits of SpG on conics: ", SortedList(List(Orbits(SpG, [1..704]), Length)), "\n");
Print("orbits of O_h on conics: ", SortedList(List(Orbits(Oh, [1..704]), Length)), "\n");
QUIT;
