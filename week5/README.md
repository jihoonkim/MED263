# Week 5. RNA-seq analysis (Kathleen Fisch)

### Download Jupyter Notebook
Download the [Jupyter Notebook for RNA-seq](https://github.com/jihoonkim/MED263/raw/master/week5/RNASeq123.ipynb) to your laptop computer from the [MED263 course web-page](https://github.com/jihoonkim/MED263/tree/master/week5). Note that usual right-click-save-link-as would'nt work for a file download in GitHub. Do the followings. Click file, select **raw**, and right-click-save-link-as.



### Run with Docker

1. Start running docker by typing following command in Terminal (macOS/Linux) or Docker Quickstart Terminal (Windows). Replace /Users/johndoe/mylocalfolder with your own working directory in your local/host computer (=laptop computer).
```bash
docker run -it -p 8888:8888 -v /Users/johndoe/mylocalfolder:/home/jovyan/work/notebooks ccbbatucsd/rnaseq123-docker
```

2. Open a web browser and copy paste the url displayed from your docker. The URL should be similar to one below but with a different token (=hash value).
```bash
http://localhost:8888/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```



### Run with Anaconda


1. Start R (or RStudio) and run following commands to install dependent R packages **BEFORE** running Jupyter Notebook.
```r
install.packages("R.utils")
install.packages("gplots")
install.packages("IRdisplay")
source("http://bioconductor.org/biocLite.R")
biocLite("limma")
biocLite("edgeR")
biocLite("Glimma")
biocLite("Mus.musculus")
biocLite("Homo.sapiens")
```

2. Start running Jupyter Notebook by typing following command in Terminal (macOS/Linux) or Anaconda Prompt (Windows)
```bash
jupyter notebook
```

3. Browse and select **RNASeq123.ipynb** file to open

4. Open a web browser and copy paste the url displayed from your docker. The URL should be similar to one below but with a different token (=hash value).
```bash
http://localhost:8888/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```

