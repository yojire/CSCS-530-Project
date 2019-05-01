sys = syscreate(n, seq(2,3,length.out = n),
                sample(c(rep(1,npref),rep(0,n-npref))))
sys %>% addcol(sample(seq(0.5,2,length.out = n)), "soc")

nw = graph.formula() + vertices(1:n)
termlist = lapply(1:n, term)
supervisor = spvs()

memo = list()
memo[[1]] = list(npref=npref, sys=copy(sys),
               supervisor=copy(supervisor),
               termlist=copy(termlist))
for(i in 2:101){
    source('cycle.R')
}