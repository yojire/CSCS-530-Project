flip = function(y,x){ifelse(x==1,y,1-y)}

cond_gen = function(x, alphas){runif(length(alphas))^(1/alphas) %>% flip(x)}

cond_ltail = function(y,alpha,x){ifelse(x==1,y^alpha,1-(1-y)^alpha)}
ltail = function(y,alpha,p){p*cond_ltail(y,alpha,1)+(1-p)*cond_ltail(y,alpha,0)}
preftail = function(y,alpha,p,pref){flip(ltail(y,alpha,p), 1-pref)}

cond_den = function(y,alpha,x){alpha*(flip(y,x)^(alpha-1))}