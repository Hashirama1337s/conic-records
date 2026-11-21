# vdim_lead.py: count standard monomials of a leading ideal printed by `msolve -g 1`
# (= dim of the quotient = number of solutions WITH multiplicity). usage: vdim_lead.py file.lead
import sys, re
txt = open(sys.argv[1]).read()
vars_ = [v.strip() for v in re.search(r'#variable order:\s*(.*)', txt).group(1).split(',')]
body = txt[txt.index('['):txt.rindex(']') + 1].strip('[]:\n ')
lead = []
if body.strip() == "1":
    print("leading ideal = (1): no solutions, vdim (with multiplicity) = 0"); sys.exit()
for term in body.replace('\n', '').split(','):
    term = term.strip()
    if not term:
        continue
    e = [0] * len(vars_)
    for f in term.split('*'):
        v, _, k = f.partition('^')
        e[vars_.index(v)] += int(k) if k else 1
    lead.append(tuple(e))
n = len(vars_)
def standard(m):
    return not any(all(m[i] >= l[i] for i in range(n)) for l in lead)
# every variable must have a pure power among the leading monomials, otherwise the quotient is infinite
pure = [any(l[i] > 0 and sum(l) == l[i] for l in lead) for i in range(n)]
if not all(pure):
    print("NOT zero-dimensional (no pure power for", [vars_[i] for i in range(n) if not pure[i]], ")"); sys.exit()
seen = {tuple([0] * n)}; stack = [tuple([0] * n)]
while stack:
    m = stack.pop()
    for i in range(n):
        m2 = m[:i] + (m[i] + 1,) + m[i + 1:]
        if m2 not in seen and standard(m2):
            seen.add(m2); stack.append(m2)
        if len(seen) > 10**6:
            print("too many"); sys.exit()
print("leading terms", len(lead), " vdim (with multiplicity) =", len(seen))
