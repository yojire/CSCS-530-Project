syscreate = function(n, alphas, pref, p=0.5){
    alphas = sort(alphas, decreasing=T)
    data.table(p=p, rank=1:n, id=sample(1:n), alpha=alphas, pref=pref)
}

obsgen = function(dt){
    newx = as.integer(rbernoulli(1, unique(dt$p)))
    dt[,x:=newx]; dt[,y:=cond_gen(x,alpha)]
}

addcol = function(dt, vec, name){dt[, c(name):=vec[id]];dt}

correct = function(dt, subset){dt[, report:=ifelse(rank%in%subset, y, report)];dt}

newpos = function(subset, n){
    m = length(subset)
    if(m==0) return(subset)
    if(max(subset)!=n) return(subset+1)
    return(c(newpos(head(subset,m-1),n-1),n))
}

newrank = function(subset, n){
    if(length(subset)==0) return(1:n)
    rest = (1:n)[-subset]
    out = 1:n
    np = newpos(subset, n)
    out[subset] = np
    out[-subset] = (1:n)[-np]
    return(out)
}

penalize = function(dt, subset){
    nr = newrank(subset, nrow(dt))
    dt[,rank:=rank[nr]]
    dt[,alpha:=alpha[nr]]
    return(dt[order(rank)])
}