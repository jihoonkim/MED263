# How to install R kernel in Jupyter

---

#### In terminal, start R in the terminal to use the environment variable and path.
```Shell
R
```

#### In R, Install binary packages in R
```R
install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid','digest'))
devtools::install_github('IRkernel/IRkernel')
```

#### In R, Make the kernel available to Jupyter
```R
IRkernel::installspec()
```

#### In terminal, start the jupyter notebook
```Shell
jupyter notebook
```

#### In a web browser, 
- go to http://localhost:8888
- select New
- select R