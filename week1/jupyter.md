# Tutorial: Jupyter Notebook
[TOC]


### References
* CONDA : https://conda.io/docs/user-guide


### Install ANACONDA
1. Open a browser and go to [ANACONDA Download](https://www.anaconda.com/download)
2. Click your own Operating System (Windows/macOS/Linux) to download the installation file
3. S





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


### Management
* conda
* environment
* package


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
Linux and macOS: `source activate jedi`
Windows: `activate jedi`

3. Create a new environment and then install a different version of Python along with 2 packages named Astroid and Babel:
```bash
conda create --name sith python=3.5 astroid babel
```

4. Display the environments that you have installed so far:
```bash
conda info --envs
```

5. Switch to another environment
Linux, macOS:
```bash
source deactivate
```
Windows:
```bash
deactivate
```

6. Change your path from the current environment back to the root:
Linux, macOS:
```bash
source deactivate
```
Windows:
```bash
deactivate
```

7. Make a copy of the jedi environment by creating a clone of it called “padawan”:
```bash
conda create --name padawan --clone jedi
```

8. Delete the flowers environment
```bash
conda remove --name flowers --all
```

### Managing Python
1. Create a new environment named “snakes” and install the latest version of Python 3:
```bash
conda create --name snakes python=3
```

2. Activate a new environment
Linux, macOS:
```bash
source deactivate
```
Windows:
```bash
deactivate
```

3. Verify that the snakes environment has been added:
```bash
conda info --envs
```

4. Verify that the snakes environment uses Python version 3:
```bash
python --version
```

5. Switch back to the default, version 2.7:
Linux, macOS:
```bash
source activate snowflakes
```
Windows:
```bash
activate snowflakes
```

6. Verify that the snowflakes environment uses the same Python version
that was used when you installed conda:
```bash
python --version
```

7. Deactivate the snowflakes environment and then revert your PATH to its previous state:
Linux, macOS:
```bash
source deactivate
```
Windows:
```bash
deactivate
```

### Anaconda
**Anaconda** is a package manager, an environment manager, a Python distribution, and a collection of over 1,000+ open source packages.

Follow the [Andaconda Installation](https://docs.anaconda.com/anaconda/install/) for your own platform (Windows/macOS/Linux).

https://conda.io/docs/user-guide/getting-started.html


### Jupyter
**Jupyter Notebook** is an interactive computational environment, in which you can combine code execution, rich text, mathematics, plots and rich media.
