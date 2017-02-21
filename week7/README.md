
### Create a working directory for RNA-Seq 
```Shell
mkdir ~/rnaseq
RNASEQ_HOME=~/rnaseq
cd $RNASEQ_HOME
```
#### (Optional) If you run into limited storage issue, create this directory under /tmp
```Shell
mkdir /tmp/rnaseq
RNASEQ_HOME=/tmp/rnaseq
cd $RNASEQ_HOME
```

### Download the IPython notebook
```Shell
wget https://github.com/jihoonkim/MED263/raw/master/week7/RNASeq123.ipynb
```

### Download the Docker image
```Shell
docker pull ccbbatucsd/rnaseq123-docker
```

### Run the RNA-Seq docker and access the Jupyter within the VM
```Shell
mkdir ~/rnaseq
RNASEQ_HOME=~/rnaseq
docker run -it -p 8888:8888 -v $RNASEQ_HOME:/home/jovyan/work/notebooks ccbbatucsd/rnaseq123-docker
```
#### Copy and paste the URL provided in the terminal to the web browser
```Shell
http://localhost:8888/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```

### (Optional and discouraged due to browser caching attack/risk. Do this only if the localhost access above does not work.) Run the RNA-Seq docker and access the Jupyter from outside the VM
```Shell
mkdir ~/rnaseq
RNASEQ_HOME=~/rnaseq
docker run -it -p 443:8888 -v $RNASEQ_HOME:/home/jovyan/work/notebooks ccbbatucsd/rnaseq123-docker
```
#### Copy and paste the URL provided in the terminal to the web browser replacing '172.1.2.3' with your VM IP address
```Shell
http://172.1.2.3:8888/?token=7b919daae88a9a43e6ef1a909b10aaf010f9f366559552b8
```
