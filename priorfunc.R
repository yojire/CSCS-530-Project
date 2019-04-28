# A prior distribution is a data.table with "f" as the name of one of the cols

pint = function(dt){mean(dt$f)}

pnormalize = function(dt){dt[,f:=f/pint(dt)];dt}

pbayes = function(dt, dt2, by){
    merge(dt, dt2, by=by) %>%
    .[, .(f=f.x*f.y), by=by] %>%
    pnormalize()
}