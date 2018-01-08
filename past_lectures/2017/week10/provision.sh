# !/bin/bash
#-----------------------------------------------------------------------------
# MED 263 Winter 2017
#   Week10 script
#   Author : Vikas Bansal 
#-----------------------------------------------------------------------------

# install dependent Ubuntu packages
apt-get install -y g++ libncurses5-dev libncursesw5-dev \
 make software-properties-common  wget zip zlib1g-dev 


# install samtools
cd /opt
wget https://github.com/samtools/samtools/releases/download/1.4/samtools-1.4.tar.bz2
tar jxvf samtools-1.4.tar.bz2
cd samtools-1.4
make
make install 
echo -e export PATH=/opt/samtools-1.4/bin:$PATH  >> /etc/profile


# install tabix 
cd /opt
git clone https://github.com/samtools/htslib
autohead
autoconf
./configure
make
make install


# install bedtools
apt-get install -y bedtools


# install python scipy: https://www.scipy.org/install.html 
apt-get install -y python-numpy python-scipy 


# install IGV (run the following as a student username)
# cd /home/j5kim
# wget http://data.broadinstitute.org/igv/projects/downloads/IGV_2.3.89.zip
# unzip IGV_2.3.89.zip
# java -jar IGV_2.3.89/igv.jar 