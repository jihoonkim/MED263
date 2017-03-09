
# MED 263: Microbiome

---

## Part 1: Install Gneiss 

### install conda
```Shell
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
chmod a+x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
```

### create a gneiss environment
```Shell
conda create -n gneiss_env python=3.5 gneiss -c biocore -c qiime2
```

---

## Part 2: Run CFstudy microbiome project (in your remote VM)


### activate the gneiss environment
```Shell
source activate gneiss_env
```

### make a workspace directory
```Shell
mkdir ~/microbiome
cd ~/microbiome
```

### download files
```Shell
wget https://raw.githubusercontent.com/biocore/gneiss/master/ipynb/cfstudy/cfstudy.ipynb
wget https://raw.githubusercontent.com/biocore/gneiss/master/ipynb/cfstudy/cfstudy_metadata.txt
wget https://github.com/biocore/gneiss/blob/master/ipynb/cfstudy/otu_table.biom?raw=true -O otu_table.biom
```

###  start the Jupyter notebook
```Shell
jupyter notebook cfstudy.ipynb
```

---

## Part 3: Start Jupyter notebook in a remote VM from your laptop computer

### Establish a SSH tunnel to your remote VM from your local laptop computer.
```Shell
ssh -f -N -L 8888:localhost:8888 j5kim@172.21.53.19 -p 9221
```

### Open a web-brower with the address below. Copy and paste the token showing up in the VM
```Shell
http://localhost:8888
```

### Check which port number is already occupied and, to release it, kill the process ID, e.g. '1234'
```Shell
kill $(ps -ax | grep ssh | grep localhost |  awk '{ print $2 }')
```

----

### References

- [Anaconda/Conda](https://www.continuum.io/)
- [Gneiss tool](https://biocore.github.io/gneiss/)
- Morton et al. mSystems 2017. [PMID: 28144630](https://www.ncbi.nlm.nih.gov/pubmed/28144630)
- [Qiime](http://qiime.org/)


