# Week 5. RNA-seq analysis (Kathleen Fisch)


### Introduction 
RNA-sequencing (RNA-seq) has become the primary technology used for gene expression profiling, with the genome-wide detection of differentially expressed genes between two or more conditions of interest one of the most commonly asked questions by researchers. The edgeR (Robinson, McCarthy, and Smyth 2010) and limma packages (Ritchie et al. 2015) available from the Bioconductor project (Huber et al. 2015) offer a well-developed suite of statistical methods for dealing with this question for RNA-seq data.


### Example study
The experiment analysed in this workflow is from Sheridan et al. (2015) (Sheridan et al. 2015) and consists of three cell populations (basal, luminal progenitor (LP) and mature luminal (ML)) sorted from the mammary glands of female virgin mice, each profiled in triplicate. RNA samples were sequenced across three batches on an Illumina HiSeq 2000 to obtain 100 base-pair single-end reads. The analysis outlined in this article assumes that reads obtained from an RNA-seq experiment have been aligned to an appropriate reference genome and summarised into counts associated with gene-specific regions. In this instance, reads were aligned to the mouse reference genome (mm10) using the R based pipeline available in the Rsubread package (specifically the align function (Liao, Smyth, and Shi 2013) followed by featureCounts (Liao, Smyth, and Shi 2014) for gene-level summarisation based on the in-built mm10 RefSeq-based annotation).


### Data
Count data for these samples can be downloaded from the Gene Expression Omnibus [GEO](http://www.ncbi.nlm.nih.gov/geo/) using GEO Series accession number GSE63310. Further information on experimental design and sample preparation is also available from GEO under this accession number.

### Installation
Note that the following packages have already been installed on the rnaseq123_docker image. If this notebook is being run outside that environment, uncomment the cells below (i.e., delete the # at the beginning of each line) and run them to install the necessary libraries.


### Docker run

1. Start running docker by typing following command in Terminal (macOS/Linux) or Docker Quickstart Terminal (Windows). Replace /Users/johndoe/mylocalfolder with your own working directory in your local/host computer (=laptop computer).

```bash
docker run -it -p 443:8888 -v /Users/johndoe/mylocalfolder:/home/jovyan/work/notebooks ccbbatucsd/rnaseq123-docker
```

2. Open a web browser and copy paste the url displayed from your docker. The URL should be similar to one below but with a different token (=hash value).
```bash
http://localhost:443/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```

