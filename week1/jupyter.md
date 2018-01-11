# Tutorial: Jupyter Notebook
[TOC]


### References
* CONDA : https://conda.io/docs/user-guide

### Conda
* Conda is an open source package management system and environment management system that runs on Windows, macOS and Linux.
* Conda quickly installs, runs and updates packages and their dependencies.
* Conda easily creates, saves, loads and switches between environments on your local computer.
* It was created for Python programs, but it can package and distribute software for any language.

### Conda environment
* A conda environment is a directory that contains a specific collection of conda packages that you have installed.
* For example, you may have one environment with NumPy 1.7 and its dependencies, and another environment with NumPy 1.6 for legacy testing.
* If you change one environment, your other environments are not affected. 
* You can easily activate or deactivate environments, which is how you switch between them.

### Conda packages
* A conda package is a compressed tarball file that contains system-level libraries, Python or other modules, executable programs and other components.
* Conda keeps track of the dependencies between packages and platforms.
* Conda packages are downloaded from remote channels, which are URLs to directories containing conda packages.

### Why Conda?
Sandboxting technology
* Language independent
* Platform independent
* No VMs or containers
* Enables:
  * reproducibility
  * collaboration
  * scaling

Note: all of the above is true for development, but docker is still needed for deployment


### Layers of Process Isolation
|         | Layer             |
|---------|-------------------|
| top     | application       |
|         | python virtualenv |
|         | **conda env**     |
|         | chroot            |
|         | container         |
|         | virtual machine   |
|         | hypervisor        |
| bottom  | bare methal       |

### Anaconda
**Anaconda** is a package manager, an environment manager, a Python distribution, and a collection of over 1,000+ open source packages.


### Jupyter
**Jupyter Notebook** is an interactive computational environment, in which you can combine code execution, rich text, mathematics, plots and rich media.


### Install ANACONDA and R packages
ANACONDA
1. Open a browser and go to [ANACONDA Download](https://www.anaconda.com/download)
2. Click your own Operating System (Windows/macOS/Linux) to download the installation file

In an R console, install required R packages and make it available to Jupyter:
```r
install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()
```


### Managing conda
Use the **Terminal** or an **Anaconda Prompt** for the commands below.

1. Verify that conda is installed:
```bash
conda --version
```

2. Update conda to the current version:
```bash
conda update conda
```


### Start running Jupyter
```bash
jupyter notebook
```

### Use Docker for Jupyter
```bash
docker run -it --rm -p 8888:8888 jupyter/r-notebook
```

