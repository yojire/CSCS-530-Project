term = function(id,prior=stdprior,sus_hat=0.05){
    out = list(id=id,prior=prior, sus_hat=sus_hat)
    class(out) = c("terminal",class(out))
    return(out)
}# terminal agent

selfinfo = function(ls){sys[id==ls$id]}

avinfo = function(ls){
    i = ls$id
    accessible = c(i,neighbors(nw,i)%>%as.integer())
    sys[id %in% accessible]
}# available info

condisty = function(prob, dt){
    dt %>% .[,cond_den(y,alpha,x=1)] %>% prod() * prob + 
    dt %>% .[,cond_den(y,alpha,x=0)] %>% prod() * (1-prob)
}

report = function(ls){
    q = bias(ls)
    info = avinfo(ls)[,.(alpha,y)]
    ratios = info[,cond_den(y,alpha,x=1)/cond_den(y,alpha,x=0)]
    ratio = prod(ratios)*q/(1-q); newq = ratio/(ratio+1)
    status = selfinfo(ls)
    tails = sapply(stdgrid, preftail, status$alpha, newq, status$pref)
    safe = stdgrid[tails>ls$sus_hat]
    ifelse(status$pref==1, max(max(safe),status$y), min(min(safe),status$y))
}

newprior = function(ls){
    pgrid = ls$prior$p
    info = avinfo(ls)[,.(alpha,y)]
    temp = data.table(f=sapply(pgrid, condisty, info),p=pgrid)
    ls$prior[, f:= pbayes(ls$prior, temp, by='p')$f]
}

newsus = function(ls){
    i = ls$id; s = ls$sus_hat
    accessible = neighbors(nw, i)%>%as.integer()
    av_unpunished = accessible[!accessible %in% guiltyid]
    if(length(av_unpunished)==0) return(s * jitter(1, amount=0.2))
    susests = sapply(av_unpunished, function(i){termlist[[i]]$sus_hat}) %>% as.numeric()
    susests = c(s, susests)
    if(i %in% guiltyid) susests = susests[susests>=s]
    min(susests) * jitter(1, amount=0.2)
}

update_term = function(){
    lapply(termlist, newprior)
    suslist = sapply(termlist, newsus)
    for(i in 1:length(termlist)){
        termlist[[i]]$sus_hat <<- suslist[i]
    }
    return(termlist)
}