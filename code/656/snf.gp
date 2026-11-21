default(parisizemax, 2000000000)
read("runs/dec_s1_gram.gp");
print("rank ", matrank(GR));
d=matsnf(GR); d=select(x->x!=0,d); print("SNF nonzero ", vecsort(d), " count ", #d, " prod ", prod(i=1,#d,d[i]));
B=matimage(GR); \ not used
H=mathnf(M~); print("rank N-span (doubled coords) ", matrank(H));
vals=Set(vector(#GR,i,0)); cnt=Map(); for(i=1,#GR,for(j=1,#GR,v=GR[i,j]; if(mapisdefined(cnt,v,&c), mapput(cnt,v,c+1), mapput(cnt,v,1)))); print(Mat(cnt));
\ signature via a Z-basis: pick rows
L=qflll(GR,4); K=L[2]; \ image basis
