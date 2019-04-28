soc_prod = function(i,j){sys[id %in% c(i,j), soc] %>% prod()}

distance = function(i,j){
    locs = sys[id %in% c(i,j), ifelse(pref==1,n-rank,rank-n)]
    (locs[1]-locs[2]) %>% abs()
}

timestep = function(nw){
    newlink = 0; delink = 0
    for(i in 1:(n-1)){
        for(j in (i+1):n){
            socp = soc_prod(i,j)
            d = distance(i,j)
            pconn = pbreak*(socp^a)*exp(-k*d)
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