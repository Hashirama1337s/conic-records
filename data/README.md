# data/

Moki & Julio (AI-assisted) · version 1.0

## In plain words

These files are the surfaces' conics written out exactly, the tables of how every pair of conics meets (the Gram matrices), the lattices rebuilt from Degtyarev's pictures and tables, and the permutations that match our conics one by one with his. Every file is a byte-for-byte copy of the file the computation produced. Most are PARI/GP input files: `gp` reads them with `read("file")`. `code/stage.sh` copies each one next to the scripts that read it.

Conventions: a Gram matrix `Gc` (ours) or `Gd`/`GD` (Degtyarev's, rebuilt) is the intersection matrix of the conic classes, with $-2$ on the diagonal, 4 for the two conics of one plane, and 0, 1, 2 otherwise. A permutation file holds $`\pi`$ with `Gd[pi,pi] == Gc`.

## 656/ (the real record, configuration (5.14))

| file | what it is | made by |
|---|---|---|
| `exact_conics.txt` | the 30 orbit representatives, exactly: orbit, orbit size, pivot, the square-root generators $d_j$ over the cubic field, and the rational coordinates of every plane and conic coefficient | `code/656/recog2.gp` |
| `gram_cert.gp` | certified $`656 \times 656`$ intersection Gram and the vector of $h$ | `code/656/arbcert.py` (ball arithmetic) |
| `conics_cert.json` | the 656 conics of the certified Gram: cluster, conic index, orbit, symmetry element | `code/656/arbcert.py` |
| `conics656.json` | decoded configuration (5.14): doubled integer coordinates of the 656 conic vectors in $N(24A_1)$, $h$, and a lattice basis | `code/decoder/c656.py` |
| `ns656.gp` | the decoded lattice: Gram `G` in the modified (positive) form, basis `Bm`, $h$. Careful: `G` is not the intersection form; that is $-G + (Gh)(Gh)^T/2$ | `code/decoder/c656.py` |
| `dec_s1_gram.gp` | the referee's independent decoding of (5.14), as an intersection Gram | `code/decoder/decode514.py` |
| `fam_minus_gram.gp` | the intersection Gram of the 656 numerical conics on the real form (`NUMERICAL`, decided with wide margins) | development numerics |
| `perm_dec1_to_famminus.npy` | NumPy permutation matching `dec_s1_gram.gp` entrywise onto `fam_minus_gram.gp` | `code/656/iso.py` |
| `valsE400.gp` | high-precision (400-digit) values of the 30 representatives in the E-form, the input of the recognition step | development numerics |

## 664/

| file | what it is | made by |
|---|---|---|
| `reps_exact.txt` | the 17 orbit representatives, exactly, over $`\mathbb{Q}(i,\sqrt3,\sqrt5)`$ in the basis $1, a, b, ab, e, ae, be, abe$ ($a = i$, $`b = \sqrt3`$, $`e = \sqrt5`$) | `code/664/exact.gp` |
| `conics_exact.txt`, `planes_exact.txt` | all 664 conics and 332 planes, exactly | `code/664/exact.gp` |
| `gram_exact.gp` | exact $`664 \times 664`$ Gram | `code/664/gramx.gp` |
| `realstructs.json` | the two real structures $h_1$, $h_2$ with the matrices $A$ that give real coordinates | `code/664/group.py` |
| `realconics_h1.txt`, `realconics_h2.txt` | the real conics of each real structure, in real coordinates | `code/664/realpic.gp` |
| `hipol.gp` | 440-digit values of the 17 representatives (recognition input) | development numerics |
| `conics5.13.json`, `ns660.gp` | decoded configuration (5.13) (660 conics, the same abstract K3 surface) | decoder |
| `lat664.gp`, `conics664.gp` | Degtyarev's Barth-Bauer 664 row rebuilt from his recipe, and its 664 conic vectors with orbits | rebuilt from arXiv 2108.11181 |

## 704/

| file | what it is | made by |
|---|---|---|
| `exact704.gp` | `P8x` (the octic defining $N_8$) and `EX` (the 11 representatives, exactly) | `code/704/recog704.gp` |
| `gram704_cert.gp` | exact $`704 \times 704`$ Gram `Gc` | `code/704/gram704.gp` |
| `degt704.gp` | Degtyarev's 704 row rebuilt: Gram `GD` of the lattice $S_h[u_1,u_2,u_3]$ | `code/704/hit704.gp` |
| `gd704.gp` | the conic Gram `Gd` of that rebuilt lattice | `code/704/degtgram.gp` |
| `iso704_perm.gp` | the permutation $`\pi`$ with `Gd[pi,pi] == Gc` | `code/704/iso.py` |
| `vals.gp` | high-precision values of the representatives (recognition input) | development numerics |

## 736/

| file | what it is | made by |
|---|---|---|
| `exact736.gp` | the defining polynomial of $`\mathbb{Q}(\zeta_{24})`$ and the 8 representatives, exactly | `code/736/recog736.gp` |
| `gram736_cert.gp` | exact $`736 \times 736`$ Gram (after the symmetric fill) | `code/736/gramfix736.gp` |
| `gram736_raw.gp` | the Gram before the fill (256 entries undecided from one side) | `code/736/gram736.gp` |
| `conics5.10.json`, `ns736.gp` | decoded configuration (5.10) | `code/decoder/c736.py` |
| `gd736.gp` | the decoded conic Gram in intersection form | `code/736/degtgram736b.gp` |
| `iso736_perm.gp` | the permutation onto our Gram | `code/736/iso.py` (the 704 copy) |
| `vals.gp` | high-precision values (recognition input) | development numerics |

## 660/ and 640/

| file | what it is |
|---|---|
| `exact660.gp`, `exact640.gp` | the field and the orbit representatives (13 for 660, 8 for 640), exactly |
| `gram660_cert.gp`, `gram640_cert.gp` | exact Gram matrices ($`660 \times 660`$, $`640 \times 640`$) |
| `gd660.gp`, `gd640.gp` | conic Grams of the decoded (5.13) and of the rebuilt Table 6 640 row |
| `iso660_perm.gp`, `iso640_perm.gp` | the permutations onto our Grams |

## family/

| file | what it is |
|---|---|
| `nsgen.gp` | the generic lattice $`\mathrm{NS}_{\mathrm{gen}}`$ (rank 18) of Goursat's family, read by `code/mirror/m1.gp` |
| `tgen.gp` | its transcendental lattice $`T_{\mathrm{gen}}`$ (rank 4), read by `code/mirror/iso.gp` |

Written with AI assistance.
