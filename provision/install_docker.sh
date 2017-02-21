#!/bin/bash

#-----------------------------------------------------------------------------
# File: install_docker.sh
# Author: Jihoon Kim 
# Description: Install Docker, an open platform to build, ship, and 
#              distributed applications.
#              Run this script as sudo. 
#              $ sudo install_docker.sh
# Reference: https://docs.docker.com/engine/installation/linux/ubuntu
# Date: 2/21/2017
#-----------------------------------------------------------------------------

# Install packages to allow apt to use a repository over HTTPS
apt-get install -y --no-install-recommends \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://apt.dockerproject.org/gpg | sudo apt-key add -

# Set up the stable repository
add-apt-repository \
       "deb https://apt.dockerproject.org/repo/ \
       ubuntu-$(lsb_release -cs) \
       main"

# Update the apt package index
apt-get update

# Install the latest version of Docker
apt-get -y install docker-engine       

# Add the user to the docker group
LOGNAME=`logname`
usermod -aG docker ${LOGNAME}

# Restart the Docker daemon
service docker restart 

# log out to enable newly added 'docker' group effective
exit
