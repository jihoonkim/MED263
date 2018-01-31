### load libraries
library(downloader)
library(RCurl)
library(snpStats)

### genoteyp data
bedFile<- download("https://www.mtholyoke.edu/courses/afoulkes/Data/statsTeachR/GWAS_data.bed",
                   destfile = "GWAS_data.bed")
bimFile<- download("https://www.mtholyoke.edu/courses/afoulkes/Data/statsTeachR/GWAS_data.bim", destfile = "GWAS_data.bim")
famFile<- download("https://www.mtholyoke.edu/courses/afoulkes/Data/statsTeachR/GWAS_data.fam",
                   destfile = "GWAS_data.fam")
data <- read.plink("GWAS_data.bed","GWAS_data.bim","GWAS_data.fam",na.strings=("-9"))



### clinical data
clinicalURL <- getURL("https://www.mtholyoke.edu/courses/afoulkes/Data/statsTeachR/GWAS_clinical.csv")
clinical <- read.csv(text = clinicalURL, colClasses = c("character", rep("factor",
                                                                         2), rep("numeric", 2)))
rownames(clinical) <- clinical$FamID
print(head(clinical))


da = read.table(file="FMS_data.txt",  header=T, sep="\t")

