"""mklean.py: write Conic656Disc.lean (+ a must-fail control) from S20.txt, K2.txt, h.txt (dump.gp output)."""
import sys
from pathlib import Path

here = Path(__file__).parent
out = Path(sys.argv[1])
S = here.joinpath("S20.txt").read_text().strip()
v1, v2 = [l.strip() for l in here.joinpath("K2.txt").read_text().splitlines() if l.strip()]
h = here.joinpath("h.txt").read_text().strip()

head = """/-!
# 656-conic quartic: the index-2 overlattice step (lab 0.28.0 proof of concept)

S is the 20x20 Gram matrix of the lattice spanned by the 656 conic classes of the quartic X- (RAID-656), from
exactub/lattice.gp (certified Gram exactub/gram_cert.gp; dump in lean656/dump.gp -> S20.txt, K2.txt, h.txt).
PARI reports dim ker(S mod 2) = 2 with basis v1, v2 (exactub/lattice.out lines 9-12). An index-2 even overlattice of S
would be S + Z x with x = v/2, v a nonzero class of ker(S mod 2); it is even integral only if x^2 = vSv/4 lies in 2Z,
i.e. only if 8 divides vSv. Checked here, by kernel evaluation, for v1, v2 and v1+v2:
  * S is symmetric, h^2 = 4;
  * S v = 0 mod 2 componentwise (so v/2 pairs integrally with S);
  * vSv = -12, -6042, -6090, none divisible by 8 (x^2 = -3, -3021/2, -3045/2: none in 2Z).
Not checked here: that ker(S mod 2) has no other classes (PARI matker), or anything about how S was produced.
-/

def dot (a b : List Int) : Int := (List.zipWith (· * ·) a b).sum
def mulVec (S : List (List Int)) (v : List Int) : List Int := S.map (fun r => dot r v)
def qf (S : List (List Int)) (v : List Int) : Int := dot v (mulVec S v)
def addV (a b : List Int) : List Int := List.zipWith (· + ·) a b

"""
body = f"""def S : List (List Int) :=
  {S}

def v1 : List Int := {v1}
def v2 : List Int := {v2}
def v12 : List Int := addV v1 v2
def h : List Int := {h}

theorem S_shape : S.length = 20 ∧ S.all (fun r => r.length == 20) = true := by decide
theorem S_symm : ∀ i < 20, ∀ j < 20, (S.getD i []).getD j 0 = (S.getD j []).getD i 0 := by decide
theorem h_sq : qf S h = 4 := by decide
theorem v1_dual : (mulVec S v1).all (fun x => x % 2 == 0) = true := by decide
theorem v2_dual : (mulVec S v2).all (fun x => x % 2 == 0) = true := by decide
theorem v12_dual : (mulVec S v12).all (fun x => x % 2 == 0) = true := by decide
theorem v1_q : qf S v1 = -12 := by decide
theorem v2_q : qf S v2 = -6042 := by decide
theorem v12_q : qf S v12 = -6090 := by decide
theorem no_even_overlattice : ¬ (8 : Int) ∣ qf S v1 ∧ ¬ (8 : Int) ∣ qf S v2 ∧ ¬ (8 : Int) ∣ qf S v12 := by
  rw [v1_q, v2_q, v12_q]; decide
"""
out.write_text(head + body, encoding="utf-8")
ctrl = out.with_name(out.stem + "Control.lean")
ctrl.write_text(head.replace("proof of concept)", "proof of concept) - CONTROL: must FAIL") + body.split("theorem S_shape")[0]
                + "theorem wrong_even : (8 : Int) ∣ qf S v1 := by decide\n", encoding="utf-8")
print("wrote", out, ctrl)
