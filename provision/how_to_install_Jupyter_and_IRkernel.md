# How to install Jupyter and its R kernel

---

#### install dependent linux packages
```Shell
sudo apt-get install libcurl4-openssl-dev libssl-dev
```

#### install Anaconda
```Shell
wget https://repo.continuum.io/archive/Anaconda2-4.3.0-Linux-x86_64.sh
bash Anaconda2-4.3.0-Linux-x86_64.sh
```

#### In terminal, start R 
```Shell
R
```

#### In R, install R packages
```R
options(repos = c(CRAN = "http://cran.cnr.berkeley.edu/"))
install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid','digest'))
devtools::install_github('IRkernel/IRkernel')
```

#### In terminal, run source to make the path effective
```Shell
source ~/.bashrc
```

#### In R, make the kernel available to Jupyter
```R
IRkernel::installspec()
```


#### In terminal, start the jupyter notebook
```Shell
jupyter notebook
```

---

#### In your laptop, type this line in your terminal
```Shell
ssh -f -N -L 8888:localhost:8888 johndoe@172.3.4.5 -p 9221
```

#### In your laptop, open a web browser
- go to http://localhost:8888

