# MED 263 Linux command cheatsheet

---

#### Create a 'workspace' directory and change its owner to 'johndoe'
```Shell
sudo mkdir /tmp/workspace
ls -hl /tmp/workspace
sudo chown johndoe:johndoe /tmp/workspace
ls -hl /tmp/workspace
cd /tmp/workspace
```

#### Delete a target directory '/home/johndoe/week2run' recursively.
```Shell
rm -rf /home/johndoe/week2run
```

#### Download a file with URL (e.g. bowtie pre-built index for hg19)
```Shell
wget ftp://ftp.ccb.jhu.edu/pub/data/bowtie_indexes/hg19.ebwt.zip
```

#### Find the top 20 large files size larger than 100 MB (and delete them if not needed)
```Shell
sudo find / -type f -size +100M -print |  xargs du -s | sort -k 1 -nr  | head -n 20
```

#### Get the secret token of Jupyter Notebook from the latest Docker container
```Shell
docker exec -it `docker ps -l -q` jupyter notebook list
```

#### Install Java and Juicebox, a Java application
```Shell
sudo apt-get install openjdk-8-jre
wget https://s3.amazonaws.com/hicfiles.tc4ga.com/public/Juicebox.jar
```

#### Move a directory '/home/johndoe/week2run' to under '/tmp/workspace'
```Shell
mv /home/johndoe/week2run /tmp/workspace
```

#### Report the disk space usage
```Shell
df -h
```

---

#### Start running a docker container as a daemon process 
```Shell
docker run -d -p 443:8888 -v /home/johndoe/rnaseq:/home/jovyan/work/notebooks ccbbatucsd/rnaseq123-docker
docker exec -it `docker ps -l -q` jupyter notebook list
```
