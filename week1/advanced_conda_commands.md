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
