# Tutorial: Jupyter Notebook
[TOC]

### Jupyter
**Jupyter Notebook** is an interactive computational environment, in which you can combine code execution, rich text, mathematics, plots and rich media.


### Anaconda
**Anaconda** is a package manager, an environment manager, a Python distribution, and a collection of over 1,000+ open source packages.

Follow the [Andaconda Installation](https://docs.anaconda.com/anaconda/install/) for your own platform (Windows/macOS/Linux).

https://conda.io/docs/user-guide/getting-started.html



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



### Managing environments
Create a few environments and then move between them.

1. Create an environment with `conda create`:
```bash
conda create --name jedi biopython
```

2. Activate a new environment
```bash
source activate jedi
```

3. Create a new environment and then install a different version of Python along with 2 packages named Astroid and Babel:
```bash
conda create --name sith python=3.5 astroid babel
```

4. Display the environments that you have installed so far:
```bash
conda info --envs
```


5. Switch to another environment `source activate sith`:
```bash
source activate sith
```


