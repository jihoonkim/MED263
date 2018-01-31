# Week 5. RNA-seq analysis (Kathleen Fisch)

### Download Jupyter Notebook

1. Download the [Jupyter Notebook for RNA-seq](https://github.com/jihoonkim/MED263/raw/master/week5/RNASeq123.ipynb) to your laptop computer from the [MED263 course web-page](https://github.com/jihoonkim/MED263/tree/master/week5). Note that usual right-click-save-link-as would'nt work for a file download in GitHub. Do the followings. Click file, select **raw**, and right-click-save-link-as.
In Mac OS or linux terminal, you can use wget to download files.
```bash
cd /Users/johndoe/mylocalfolder
wget https://github.com/jihoonkim/MED263/raw/master/week5/RNASeq123.ipynb
wget https://github.com/jihoonkim/MED263/raw/master/week5/RNASeq123-MED263HW.ipynb
```

2. Copy the downloade file above, **RNASeq123.ipynb**, to a local directory. And give it a name, for example, /Users/johndoe/mylocalfolder. This will be used in later steps.



### Run with Docker

1. Change to the local directory with .ipynb file above and start running docker by typing following command in Terminal (macOS/Linux) or Docker Quickstart Terminal (Windows). Replace /Users/johndoe/mylocalfolder with your own working directory in your local/host computer (=laptop computer).
```bash
cd /Users/johndoe/mylocalfolder
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

2. Change to the local directory with .ipynb file above and start running Jupyter Notebook by typing following command in Terminal (macOS/Linux) or Anaconda Prompt (Windows)
```bash
cd /Users/johndoe/mylocalfolder
jupyter notebook
```

3. Browse and select **RNASeq123.ipynb** file to open

4. Open a web browser and copy paste the url displayed from your docker. The URL should be similar to one below but with a different token (=hash value).
```bash
http://localhost:8888/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```

