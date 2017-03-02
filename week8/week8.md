
# MED 263: Network Biology

---

# In your VM

### Start R and run the following scripts
```Shell
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()
```

### Make a workspace directory 
```Shell
mkdir -p ~/network
```

### Change to a directory
```Shell
cd ~/network
```

### Download the IPython NoteBook file for network biology
```Shell
wget https://raw.githubusercontent.com/jihoonkim/MED263/master/week8/week8_HannahCarter.ipynb
```


### Start Jupyter Notebook
```Shell
jupyter notebook --no-browser 
```

---

# In your laptop


### Establish a SSH tunnel to your remote VM from your local laptop computer.
```Shell
ssh -f -N -L 8888:localhost:8888 j5kim@172.21.53.19 -p 9221
```

### Open a web-brower with the address below. Copy and paste the token showing up in the VM
```Shell
http://localhost:8888
```
