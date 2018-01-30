# load data and binarize the genotype to 0-1 coding
fms <- read.delim("http://stat-gen.org/book.e1/data/FMS_data.txt", header=T, sep="\t")
newvariable1 = ifelse(fms$esr1_rs2234693 == "CC", 0, ifelse(fms$esr1_rs2234693 == "TC", 1, 2))
table(newvariable)
table(fms$esr1_rs2234693)

# top significant SNPs by ANOVA p-values
summary( aov(fms$DRM.CH ~ fms$esr1_rs2234693) )[[1]][1,5]
summary( aov(fms$DRM.CH ~ fms$il15_rs2296135) )[[1]][1,5]
summary( aov(fms$DRM.CH ~ fms$igf1_t1245c) )[[1]][1,5]
summary( aov(fms$DRM.CH ~ fms$il15ra_2228059) )[[1]][1,5]

# generate table for the class use

esr1_rs2234693 = ifelse(fms$esr1_rs2234693 == "CC", 0, ifelse(fms$esr1_rs2234693 == "TC", 1, 2))
il15_rs2296135 = ifelse(fms$il15_rs2296135 == "AA", 0, ifelse(fms$il15_rs2296135 == "CA", 1, 2))
igf1_t1245c = ifelse(fms$igf1_t1245c == "CC", 0, ifelse(fms$igf1_t1245c == "TC", 1, 2))
il15ra_2228059 = ifelse(fms$il15ra_2228059 == "AA", 0, ifelse(fms$il15ra_2228059 == "AC", 1, 2))
acdc_rs1501299 = ifelse(fms$acdc_rs1501299 == "AA", 0, ifelse(fms$acdc_rs1501299 == "CA", 1, 2))
rankl_4531631 = ifelse(fms$rankl_4531631 == "AA", 0, ifelse(fms$rankl_4531631 == "GA", 1, 2))
visfatin_2041681 = ifelse(fms$visfatin_2041681 == "CC", 0, ifelse(fms$visfatin_2041681 == "TC", 1, 2))
tcfl72_7903146 = ifelse(fms$tcfl72_7903146 == "CC", 0, ifelse(fms$tcfl72_7903146 == "TC", 1, 2))
opg_2073618 = ifelse(fms$opg_2073618 == "CC", 0, ifelse(fms$opg_2073618 == "GC", 1, 2))
#ppara_135539 = ifelse(fms$ppara_135539 == "GG", 0, ifelse(fms$ppara_135539 == "GT", 1, 2))

bch =  ifelse( fms$NDRM.CH > 30, 1, 0);
dt = data.frame(esr1_rs2234693=esr1_rs2234693, il15_rs2296135=il15_rs2296135,  il15ra_2228059=il15ra_2228059, acdc_rs1501299=acdc_rs1501299, rankl_4531631=rankl_4531631, tcfl72_7903146=tcfl72_7903146,  Mean_BP=fms$Mean_BP, CHOL = fms$CHOL,  DRM.CH = bch )

#get complete lines
d=dt[complete.cases(dt),]
write.csv(d, file="dt_283.csv", row.names= FALSE)

# generate class for homework

dt2 = data.frame( il15_rs2296135=il15_rs2296135,  il15ra_2228059=il15ra_2228059, acdc_rs1501299=acdc_rs1501299, rankl_4531631=rankl_4531631, tcfl72_7903146=tcfl72_7903146,  Mean_BP=fms$Mean_BP,  DRM.CH = bch )
d=dt2[complete.cases(dt2),]
write.csv(d, file="dt_283_homework.csv", row.names= FALSE)

