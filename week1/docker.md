# Tutorial: Docker and linux
[TOC]


### Operating System
An **operating system (OS)** is system software that manages computer hardware and software resources and provides common services for computer programs.
![](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Operating_system_placement.svg/500px-Operating_system_placement.svg.png)

**Quiz 1**
What is the market share of linux in the Desktop platform?
Find it in the @[StatCounter](http://gs.statcounter.com/os-market-share/desktop/worldwide/#monthly-201612-201712-bar)

**Quiz 2**
What kind of OS (and web browser) are you using?
Find it out at [WhatIsMyBrowser](https://www.whatismybrowser.com)


### Bioinformatics and Linux
* Bioinformatics relies heavily on Linux-based computers (hardware) and software.
* Although many bioinformatics software tools are compiled on Mac OS and Windows,
it is more conveneint to install and use the software on a Linux system.


### Docker?
Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called containers) to run on the host operating system i.e. Linux.


### Key benefit of Docker
* The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development. 
* Unlike virtual machines, containers do not have the high overhead and hence enable more efficient usage of the underlying system and resources.


### Image vs. Container
* An **image** is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

* A **container** is a runtime instance of an image—what the image becomes in memory when actually executed. It runs completely isolated from the host environment by default, only accessing host files and ports if configured to do so.


### Container vs. Virtual Machine (VM)
![VMdiagram](https://www.docker.com/sites/default/files/Container%402x.png)
* Virtual machines run guest operating systems—note the OS layer in each box.
* This is resource intensive, and the resulting disk image and application state is an entanglement of OS settings, system-installed dependencies, OS security patches, and other easy-to-lose, hard-to-replicate ephemera.

![CONTAINERdiagram](https://www.docker.com/sites/default/files/VM%402x.png)
* Containers can share a single kernel, and the only information that needs to be in a container image is the executable and its package dependencies, which never need to be installed on the host system.
* These processes run like native processes, and you can manage them individually by running commands like docker ps—just like you would run ps on Linux to see active processes.
* Finally, because they contain all their dependencies, there is no configuration entanglement; a containerized app “runs anywhere.”


### Install Docker
Docker Community Edition (CE) for your operating system
https://store.docker.com/search?offering=community&q=&type=edition


### Windows users only: enable virtualization in BIOS
1. Reboot the computer
2. Enter BIOS menu by pressing **F1** for Toshiba, **F2** for Acer/ASUS/DELL/Lenovo/Samsung and **F10** for Compaq/HP
3. Move around with arrow keys
5. Enable the virtualization extension
![](https://i.stack.imgur.com/tNksn.jpg)
5. Save and Exit


### Hello World Test
1. Click **Docker Quickstart** icon to start Docker
2. Open a terminal and type
3. Open a terminal and type the following command
```bash
docker run hello-world
```
4. Docker installation is success if you see the outputs like the one below
```
Hello from Docker!
This message shows that your installation appears to be working correctly
To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
```



### iAdmix Test
Given the called variant file, we want to estimate the ancestry of this individual.
```bash
docker run -ti j5kim/iadmix:latest /bin/bash /testrun/testrun.sh
```
Test run is success if the last line of final ouput:
```
/testrun/HG001_chr22.vcf.INTEGRATION.input.ancestry, has the following allele frequencies
MKK:0.1887 CEU:0.8113 FINAL_NZ_PROPS
```

[Bansal et al. BMC Bioinfo 2015
Fast individual ancestry inference from DNA sequence data leveraging allele frequencies for multiple populations. PMID: 25592880](https://www.ncbi.nlm.nih.gov/pubmed/25592880)

### Ubuntu docker
Start running a ubuntu docker
```bash
docker run -ti ubuntu
```


### Basic linux commands
1. Update the Ubuntu packages
```bash
apt-get update
```

2. Display the current directory
```bash
pwd
```

3. Change to a different directory and check if the current directory has been changed
```bash
cd /home
pwd
```

4. Try downloading the external file
```bash
wget https://github.com/jihoonkim/dockerhub-iadmix/blob/master/HG001_chr22.vcf.gz
```

5. Install missing package **wget** first and try again downloading the file
```bash
apt-get install wget
wget https://github.com/jihoonkim/dockerhub-iadmix/raw/master/HG001_chr22.vcf.gz
```

6. Display the file size, owner, file creation time and other file-related info
```bash
ls -hl
```

7. Try extracting the compressed file in .gz format while keeping the original file
```bash
gunzip -k HG001_chr22.vcf.gz
```

8. Install missing package **zip** first and try again extracting the file
```bash
apt-get install zip
gunzip -k HG001_chr22.vcf.gz
ls -hl
```

9. Get the number of lines in .vcf file (It should be 46162)
```bash
wc -l HG001_chr22.vcf
```

10. Print the last 10 lines of the .vcf file
```bash
tail -n 10 HG001_chr22.vcf
```

11. Search the line containing the SNP with RSID rs2401506.
```bash
grep rs2401506 HG001_chr22.vcf
```

12. Create your own directory
```bash
mkdir variants
ls -hl
```

13. Copy a file
```bash
cp HG001_chr22.vcf testcopy.vcf
ls -hl
```

14. Move a file to another directory
```bash
mv testcopy.vcf variants
ls -hl
ls -hl variants
```

15. Install VIM editor and start using it
```bash
apt-get install vim
vim myfile.txt
```
**Homework**: Read and follow the [Interactive VIM tutorial](http://www.openvim.com/tutorial.html).  We will cover the earlier part during the class, but be sure to finish the rest at home by next class.



### Variant prioritization with VCF-miner
1. Start running vcf-miner docker
```bash
docker run -d -p 8888:8080 stevenhart/vcf-miner
```

2. Open a browser to http://localhost:8888/vcf-miner/
```
Username: Admin
Password: temppass
```

3. Download an example vcf file, [NA12878.trio.vcf.gz](http://bioinformaticstools.centralus.cloudapp.azure.com/research/vcf-miner-sample-vcfs)
from Mayo Clinic, and import it into the VCF-miner

4. Analyze and apply filters (SAVANT_IMPACT HIGH and ACMG_gene_names) to find
two genes; DSP and RYR1.


### More docker commands
Show running containers
```bash
docker ps
```

Stop running containers
```bash
docker stop
```

Show all containers
```bash
docker ps -a
```
Show all docker images
```bash
docker images
```




### Reference
https://docs.docker.com/get-started/
https://docker-curriculum.com/
