# sym736.g (cert736): the projective monomial group of X736 (Dwork form) and its symplectic part, GAP IdGroup.
i := E(4);
P1 := PermutationMat((1,2,3,4), 4);; P2 := PermutationMat((1,2), 4);; D := DiagonalMat([i, -i, 1, 1]);;
L := Group(P1, P2, D);;
Print("linear group order: ", Size(L), "\n");
Zl := Filtered(Elements(Centre(L)), g -> IsDiagonalMat(g) and Length(Set(DiagonalOfMat(g))) = 1);;
Zs := Subgroup(L, Zl);; Print("scalars in it: ", Size(Zs), "\n");
hom := NaturalHomomorphismByNormalSubgroup(L, Zs);; Q := Image(hom);;
Print("projective group order: ", Size(Q), "  IdGroup ", IdGroup(Q), "  ", StructureDescription(Q), "\n");
A := Image(hom, Subgroup(L, Filtered(Elements(L), IsDiagonalMat)));;
Print("diagonal part: order ", Size(A), "  abelian invariants ", AbelianInvariants(A), "\n");
Spg := Image(hom, Subgroup(L, Filtered(Elements(L), g -> DeterminantMat(g) = 1)));;
Print("det +1 part: order ", Size(Spg), "  IdGroup ", IdGroup(Spg), "  ", StructureDescription(Spg), "\n");
Print("det +1 part element orders (order, count): ", Collected(List(Elements(Spg), Order)), "\n");
QUIT;
