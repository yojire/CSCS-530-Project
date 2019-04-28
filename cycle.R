temp = nw%>%timestep()
nw = temp[[1]]
obsgen(sys)
repos = sapply(termlist, report)
addcol(sys, repos, "report")
output = analysis(supervisor)
sys = penalize(sys, guilty)
termlist = update_term()

memo[[i]] = list(
    nw = nw,
    newlink = temp[[2]],
    delink = temp[[3]],
    sys = sys,
    repos = repos,
    decision = output,
    guilty = guilty,
    guiltyid = guiltyid,
    supervisor = supervisor,
    termlist = termlist
)