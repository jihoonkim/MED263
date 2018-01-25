### set the base image to Ubuntu
FROM ubuntu:16.04

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### change a working directory to /opt
WORKDIR /opt

### download and run the provisioning script
RUN apt-get update -y                                                      && \
    apt-get install -y wget                                                && \
    wget https://github.com/jihoonkim/MED263/raw/master/week3/provision.sh && \
    wget https://github.com/jihoonkim/MED263/raw/master/week3/class.sh && \
    bash provision.sh      

### change a working directory to /work
WORKDIR /work