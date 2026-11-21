# Ahmed-Ruehle 2304.00027 sec 3.1.3 (as quoted in gate/TARGETS-NEXT.md): psi^-4 = rho(tau) = 256 eta(t)^24 eta(2t)^24 / (eta(t)^24 + 64 eta(2t)^24)^2
import mpmath as mp
mp.mp.dps = 30
def eta(t):
    q = mp.exp(2j*mp.pi*t)
    return mp.exp(2j*mp.pi*t/24) * mp.qp(q)
for name, t in [("(1+sqrt3 i)/2", (1+mp.sqrt(3)*1j)/2), ("(1+3i)/2", (1+3j)/2), ("i", 1j), ("sqrt(-2)", mp.sqrt(2)*1j)]:
    a, b = eta(t)**24, eta(2*t)**24
    r = 256*a*b/(a+64*b)**2
    print(name, " rho =", mp.nstr(r, 15), "  1/rho =", mp.nstr(1/r, 15))
