#!/bin/bash

#-----------------------------------------------------------------------------
# File: install_chipseq.sh
# Author: Chris Benner 
# Description: Install the software tools and data for CHiP-Seq 
# Date: 2/9/2017
#-----------------------------------------------------------------------------

# Assumes common 
# make sure wget, ghostscript, gcc and g++ are installed (often installed on many distributions)
apt-get install -y wget g++ ghostscript

# Create homer directory to install homer specific software
mkdir -p /opt/homer

# Change directory to the homer directory
cd /opt/homer

# Install weblogo (download, unzip)
wget -O weblogo.2.8.2.tar.gz  http://weblogo.berkeley.edu/release/weblogo.2.8.2.tar.gz
tar zxvf weblogo.2.8.2.tar.gz

# Add weblogo directory to the executable PATH, both current
export PATH=$PATH:$PWD/weblogo
#echo "export PATH=$PATH:$PWD/weblogo" >> ~/.bashrc
echo "export PATH=$PATH:$PWD/weblogo" >> /etc/profile

# Install HOMER with mouse/mm9 genome version
wget -O configureHomer.pl http://homer.ucsd.edu/homer/configureHomer.pl
perl configureHomer.pl -install homer mm9

# Add HOMER bin directory to executable PATH
export PATH=$PATH:$PWD/bin
#echo "export PATH=$PATH:$PWD/bin" >> ~/.bashrc
echo "export PATH=$PATH:$PWD/bin" >> /etc/profile 

# Change the ownership of homer directory
chown -R $SUDO_USER:$SUDO_USER /opt/homer

# create a "run" directory for analysis of example data
mkdir -p /home/$SUDO_USER/run_chipseq
cd /home/$SUDO_USER/run_chipseq

# download an example data (.zip format of size 573 MB) for analysis
wget -O samfiles.zip http://homer.ucsd.edu/cbenner/samfiles.zip
unzip samfiles.zip
rm samfiles.zip
chown -R $SUDO_USER:$SUDO_USER /home/$SUDO_USER/run_chipseq
