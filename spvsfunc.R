spvs = function(prior=copy(stdprior), suspicion=0.05){
    out = list(suspicion=suspicion, prior=prior)
    class(out) = c("supervisor", class(out))
    return(out)
}# supervisor

bias = function(ls){mean(ls$prior[,f*p])}

analysis = function(ls){
    test = base::sample(1:n, as.integer(n/2))%>%sort()
    trust = (1:n)[-test]
    q = first_est(bias(ls), sys[rank %in% trust])
    sus = suspects(ls$suspicion, sys[rank %in% test], q)
    guilty <<- sys[rank%in%sus][y!=report,rank]
    guiltyid <<- sys[rank%in%guilty, id]
    correct(sys, sus)
    decision = decide(bias(ls), sys)
    update(ls, sys)
    return(decision)
}

first_est = function(p, dt){
    ratios = dt[,cond_den(report,alpha,x=1)/cond_den(report,alpha,x=0)]
    ratio = prod(ratios)*p/(1-p)
    ratio/(ratio+1)
}

suspects = function(s, dt, q){
    dt %>% .[, .(rank, bool = preftail(report,alpha,q,pref)<s)] %>%
    .[bool==T, rank]
}

decide = function(p, dt){
    ratios = dt[,cond_den(report,alpha,x=1)/cond_den(report,alpha,x=0)]
    ratio = prod(ratios)*p/(1-p)
    ifelse(ratio>1, 1, 0)
}

condist = function(prob, dt){
    dt %>% .[,cond_den(report,alpha,x=1)] %>% prod() * prob + 
    dt %>% .[,cond_den(report,alpha,x=0)] %>% prod() * (1-prob)
}

update = function(ls, dt){
    pgrid = ls$prior$p
    temp = data.table(f=sapply(pgrid, condist, dt),p=pgrid)
    ls$prior[, f:= pbayes(ls$prior, temp, by='p')$f]
}