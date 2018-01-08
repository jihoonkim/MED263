# Docker Tutorial

#### Operating System
An **operating system (OS)** is system software that manages computer hardware and software resources and provides common services for computer programs.
![](https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Operating_system_placement.svg/500px-Operating_system_placement.svg.png)

**Quiz**
What is the market share of linux in the Desktop platform (in December, 2017)?
Find it out in [StatCounter](http://gs.statcounter.com/os-market-share).

#### Bioinformatics and Linux
* Bioinformatics relies heavily on Linux-based computers (hardware) and software.
* Although many bioinformatics software tools are compiled on Mac OS and Windows,
it is more conveneint to install and use the software on a Linux system.


#### Docker?
Docker is a tool that allows developers, sys-admins etc. to easily deploy their applications in a sandbox (called containers) to run on the host operating system i.e. Linux.


#### Key benefit of Docker
* The key benefit of Docker is that it allows users to package an application with all of its dependencies into a standardized unit for software development. 
* Unlike virtual machines, containers do not have the high overhead and hence enable more efficient usage of the underlying system and resources.


#### Image vs. Container
* An **image** is a lightweight, stand-alone, executable package that includes everything needed to run a piece of software, including the code, a runtime, libraries, environment variables, and config files.

* A **container** is a runtime instance of an image—what the image becomes in memory when actually executed. It runs completely isolated from the host environment by default, only accessing host files and ports if configured to do so.


#### Container vs. Virtual Machine (VM)
![VMdiagram](https://www.docker.com/sites/default/files/Container%402x.png)
* Virtual machines run guest operating systems—note the OS layer in each box.
* This is resource intensive, and the resulting disk image and application state is an entanglement of OS settings, system-installed dependencies, OS security patches, and other easy-to-lose, hard-to-replicate ephemera.

![CONTAINERdiagram](https://www.docker.com/sites/default/files/VM%402x.png)
* Containers can share a single kernel, and the only information that needs to be in a container image is the executable and its package dependencies, which never need to be installed on the host system.
* These processes run like native processes, and you can manage them individually by running commands like docker ps—just like you would run ps on Linux to see active processes.
* Finally, because they contain all their dependencies, there is no configuration entanglement; a containerized app “runs anywhere.”


#### Install Docker
Docker Community Edition (CE) for your operating system
https://store.docker.com/search?offering=community&q=&type=edition


#### Windows users only: enable virtualization in BIOS
1. Reboot the computer
2. Enter BIOS menu by pressing **F1** for Toshiba, **F2** for Acer/ASUS/DELL/Lenovo/Samsung and **F10** for Compaq/HP
3. Move around with arrow keys
5. Enable the virtualization extension
![](https://i.stack.imgur.com/tNksn.jpg)
5. Save and Exit


#### Hello World Test
1. Click **Docker Quickstart** icon to start Docker
2. Open a terminal and type
3. Open a terminal and type the following command
```bash
$ docker run hello-world
```
4. Docker installation is success if you see the outputs like the one below
```bash
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




#### Reference
https://docs.docker.com/get-started/
https://docker-curriculum.com/