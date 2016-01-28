setwd("~/projects/r/alpha")

library(foreign)
library(dplyr)
library(xlsx)

## Cargar la información necesaria

pob_sec_f <- read.dbf("./data/poblacion/secciones_E25.dbf", as.is = T)
eco_sec_f <- read.dbf("./data/caracteristicasEconomicas/secciones_E25ce.dbf", as.is = T)
edu_sec_f <- read.dbf("./data/caracteristicasEducativas/secciones_E25.dbf", as.is = T)
dis_sec_f <- read.dbf("./data/discapacidad/secciones_E25.dbf", as.is = T)
mig_sec_f <- read.dbf("./data/migracion/secciones_E25.dbf", as.is = T)
sal_sec_f <- read.dbf("./data/serviciosDeSalud/secciones_E25.dbf", as.is = T)
viv_sec_f <- read.dbf("./data/viviendas/secciones_E25v.dbf", as.is = T)
ele_sec_f <- read.xlsx("./data/elecciones2015/diputados_plain.xlsx", sheetName = "data", colClasses = "integer")

descriptores <- read.dbf("./descriptores/DESCRIPTORES_CENSO2010.dbf", as.is = T)

## Pasar a formato dplyr

pob_sec <- tbl_df(pob_sec_f)
eco_sec <- tbl_df(eco_sec_f)
edu_sec <- tbl_df(edu_sec_f)
dis_sec <- tbl_df(dis_sec_f)
mig_sec <- tbl_df(mig_sec_f)
sal_sec <- tbl_df(sal_sec_f)
viv_sec <- tbl_df(viv_sec_f)
ele_sec <- tbl_df(ele_sec_f)

rm(pob_sec_f, eco_sec_f, edu_sec_f, dis_sec_f, mig_sec_f, sal_sec_f, viv_sec_f, ele_sec_f)

## Joining shit together

joined <- left_join(pob_sec, eco_sec)
joined <- left_join(joined, edu_sec)
joined <- left_join(joined, dis_sec)
joined <- left_join(joined, mig_sec)
joined <- left_join(joined, sal_sec)
joined <- left_join(joined, viv_sec)
joined <- left_join(joined, ele_sec)

#rm(joined)

write.dbf(as.data.frame(joined), "./output.dbf") ## Archivo con todos los campos (para la base de datos)

descriptores

names <- colnames(joined)
names

grouped <- group_by(joined, DISTRITO)
nvo <- summarise(grouped, sum(POBTOT) , sum(PRI, na.rm = T), sum(PAN, na.rm = T), sum(TOTAL_VOTOS, na.rm = T))
names(nvo) <- c("DISTRITO", "POBTOT", "PRI", "PAN", "TOTAL_VOTOS")


