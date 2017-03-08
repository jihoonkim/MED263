
# MED 263: Microbiome

---

## How to install Gneiss 

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

### activate the gneiss environment
```Shell
source activate gneiss_env
```

---

## How to run CFstudy (in your remote VM)

### make a workspace directoryt
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

----

## How to access the running Jupyter notebook in a remote VM from your laptop computer

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
ps -ax | grep ssh | grep localhost
kill  1234
```


