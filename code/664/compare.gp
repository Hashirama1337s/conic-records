\\ compare.gp (CERT664): the ball Gram (python-flint) against the exact Gram (PARI resultants/gcds).
default(parisizemax, 2000000000);
read("gram_exact.gp"); read("gram_ball.gp");
N = #Gc; agree = 0; und = 0; dis = 0; undv = List();
{for (i = 1, N, for (j = 1, N,
  if (Gb[i, j] == -9, und++; listput(undv, Gc[i, j]), if (Gb[i, j] == Gc[i, j], agree++, dis++))));}
print("entries: ", N^2, "  ball-decided and equal to exact: ", agree, "  disagreements: ", dis, "  ball-undecided: ", und);
print("exact values at the ball-undecided entries: ", Set(Vec(undv)), "  (all 1 expected: triple points C cap C' cap C'')");
print("COMPARE_DONE");
