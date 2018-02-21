### set the base image to Ubuntu
FROM j5kim/r-base

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### change a working directory to /opt
WORKDIR /opt

# update the PATH environment variable
ENV PATH="/opt/homer/bin:${PATH}"

### download and run the provisioning script
RUN apt-get update -y                                                      && \
    apt-get install -y wget                                                && \
    wget https://raw.githubusercontent.com/jihoonkim/MED263/master/week7/provision.sh && \
    bash provision.sh 

### change a working directory to /work
WORKDIR /work