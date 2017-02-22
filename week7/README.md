### In your laptop computer, SSH log in to your iDASH-Cloud VM
```diff
-In your laptop computer
```
```Shell
ssh johndoe@172.1.2.3 -p xxxx
```

### In your iDASH-Cloud VM, create a working directory for RNA-Seq 
```diff
+In your iDASH-Cloud VM
```
```Shell
mkdir /home/johndoe/rnaseq
RNASEQ_HOME=/home/johndoe/rnaseq
cd $RNASEQ_HOME
```

### In your iDASH-Cloud VM, (Optional) if you run into limited storage issue, create this directory under /tmp
```Shell
mkdir /tmp/rnaseq
RNASEQ_HOME=/tmp/rnaseq
cd $RNASEQ_HOME
```

### In your iDASH-Cloud VM, download the IPython notebook 
```Shell
wget https://github.com/jihoonkim/MED263/raw/master/week7/RNASeq123.ipynb
```

### In your iDASH-Cloud VM, download the Docker image
```Shell
docker pull ccbbatucsd/rnaseq123-docker
```

### In your iDASH-Cloud VM, run the RNA-Seq docker and access the Jupyter within the VM
```Shell
RNASEQ_HOME=/home/johndoe/rnaseq
sudo chown -R 1000:100 $RNASEQ_HOME
docker run -it -p 8888:8888 -v $RNASEQ_HOME:/home/jovyan/work/notebooks ccbbatucsd/rnaseq123-docker
```

### In your iDASH-Cloud VM,, copy and paste the URL provided in the iDASH-Cloud VM to the web browser and replace the token string with your own token string shown on the terminal (similar to one below but with a different token name)(similar to one below but with a different token name)
```Shell
http://localhost:8888/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```

### In your iDASH-Cloud VM, run the RNA-Seq docker and access the Jupyter from outside the VM (Optional and discouraged due to browser caching attack/risk. Do this only if the localhost access above does not work.)
```Shell
RNASEQ_HOME=/home/johndoe/rnaseq
sudo chown -R 1000:100 $RNASEQ_HOME
docker run -it -p 443:8888 -v $RNASEQ_HOME:/home/jovyan/work/notebooks ccbbatucsd/rnaseq123-docker
```

### In your laptop computer, copy and paste the URL provided in the iDASH-Cloud VM to the web browser replacing '172.1.2.3' with your own VM's IP address and the token string with your own token string shown on the terminal (similar to one below but with a different token name)
```diff
-In your laptop computer
```
```Shell
http://172.1.2.3:443/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```

