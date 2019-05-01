soc_prod = function(i,j){sys[id %in% c(i,j), soc] %>% prod()}

distance = function(i,j){
    locs = sys %>% .[, .(id, spec=ifelse(pref==1,n-rank,rank-n))] %>% .[,.(id,r=base::rank(spec))] %>% [id %in% c(i,j), r]
    (locs[1]-locs[2]) %>% abs()
}

timestep = function(nw){
    newlink = 0; delink = 0
    for(i in 1:(n-1)){
        for(j in (i+1):n){
            socp = soc_prod(i,j)
            d = distance(i,j)
            pbreak = pconn*exp(k*d)/(socp^a)
            if(are_adjacent(nw,i,j)){
                if(rbernoulli(1,pbreak)) {
                    nw = nw %>% delete.edges(paste(as.character(i),as.character(j),sep="|"))
                    delink = delink+1
                }
            }else{
                if(rbernoulli(1,pconn)){
                    nw = nw+edges(c(i,j))
                    newlink = newlink+1
                }
            }
        }
    }
    return(list(nw, newlink, delink))
}