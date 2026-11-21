Read("grp48_v2.g");
for nm in [["Sym",Sym],["Sp",SpL],["Oh",Oh]] do
  g := Group(nm[2]);
  Print(nm[1], " order ", Size(g), " IdGroup ", IdGroup(g), " ", StructureDescription(g), "\n");
od;
gs := Group(Sym); Print("centre of Sym: ", Size(Centre(gs)), "  Sp normal in Sym: ", IsNormal(gs, Group(SpL)), "\n");
QUIT;
