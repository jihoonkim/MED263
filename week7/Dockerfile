### set the base image to Ubuntu
FROM j5kim/r-base

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### change a working directory to /opt
WORKDIR /opt

### download and run the provisioning script
RUN apt-get update -y                                                      && \
    apt-get install -y wget                                                && \
    wget https://raw.githubusercontent.com/jihoonkim/MED263/master/week7/provision.sh && \
    bash provision.sh 

### environment variable 
RUN /bin/bash -c 'source /etc/profile'

# update the PATH environment variable
#ENV PATH="/opt/homer/bin:${PATH}"

### change a working directory to /work
WORKDIR /work