setwd("/Users/luis/Code/Pablo/alphaproject")
library(foreign)
d <- read.dbf("descriptores/descrip_consolidados_final.dbf", as.is = T)
dc <- read.dbf("descriptores/DESCRIPTORES_CENSO2010.dbf", as.is = T)
colnames(dc) <- c("CAMPO", "VALOR")
d <- rbind(d,dc)
tr <- function(n){ d[d$CAMPO == n,]$VALOR }

#sapply(names(mydata3),function(x){tr(x)})