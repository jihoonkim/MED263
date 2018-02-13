### set the base image to Ubuntu
FROM ubuntu:16.04

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### change a working directory to /opt
WORKDIR /opt

### download and run the provisioning script
RUN apt-get update -y                                                      && \
    apt-get install -y wget                                                && \
    wget https://raw.githubusercontent.com/jihoonkim/MED263/master/week6/provision.sh && \
    bash provision.sh 

# update the PATH environment variable
ENV PATH="/opt/hapcut:${PATH}"

### change a working directory to /work
WORKDIR /work