# Week 2. Network Biology (Hannah Carter)

### How to run Jupyter Notebook with Docker

1. Install Docker

2. Start running docker by typing following command in Terminal (macOS/Linux) or Anaconda Prompt (Windows). Replace `/Users/johndoe/mylocalfolder` with your workding directory in your local/host computer (=laptop computer). This directory will contain your Jupyter Notebook .ipynb file.
```bash
docker run -it --rm -p 8888:8888 -v /Users/johndoe/mylocalfolder:/home/jovyan/work --user root -e NB_UID=1000 -e GRANT_SUDO=yes jupyter/r-notebook
```

3. Find the displayed message like below in Terminal or Anaconda Prompt, and copy the URL into your browser. The URL should look like this with a differnt hash token value:
```
Copy/paste this URL into your browser when you connect for the first time,
to login with a token:
        http://localhost:8888/?token=cc97177109e0dd41f3bf252b9e4a59f60ccbb228b014dac2
```

4. In the browser, click **New** and select **Terminal** to open a new web-site with linux terminal.
Type following commands to install dependent Ubuntu package **libxml2_dev** for R package, **igraph**, installation.
```bash
sudo apt-get update
sudo apt-get install -y libxml2-dev
```

5. In the browser terminal, type **R** to start R. And type R commands below to install two R packages,**igraph** and **NetIndices**.
```r
targetrepo = "http://cran.stat.ucla.edu"
install.packages("igraph", repos = targetrepo)
install.packages("NetIndices", repos = targetrepo)
```

6. Go back to **http://localhost:8888/tree/work** tab in the browser and  click **work** directory and open *.ipynb* file by clicking it.

7. Run Cells


---


### How to run Jupyter Notebook without Docker

1. Install Anaconda

2. Install R

3. Start R in Terminal or Anaconda Prompt and install an R package, **IRKernal**
```bash
targetrepo = "http://cran.stat.ucla.edu"
install.packages('devtools', repos = targetrepo)
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()  # to register the kernel in the current R installation
```

4. Log out and Log in from the computer to make the environment changes effective

5. Start Jupyter
```bash
jupyter notebook
```