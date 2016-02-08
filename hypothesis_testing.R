vs <- c("PAN", "OTRO", "PT", "PRD", "NUEVA_ALIA")
vars <- names(dataset)[which(names(dataset)!="GANADOR")]
p <- length(vs)
v <- length(vars)
foreach(partido in vs){
        foreach(var in vars){
                ks2Test(PRI[[var],partido[[var])
        }
}