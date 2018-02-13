# !/bin/bash
#-----------------------------------------------------------------------------
# MED 263 
#   Author : Vikas Bansal 
#
#	docker build -t j5kim/med263-bansal .
#	docker run -ti -v $(pwd):/work j5kim/med263-bansal:latest /bin/bash
#	docker commit -a "Jihoon Kim" $(docker ps -a -q | head -n 1) j5kim/med263-bansal
#	docker login --username=j5kim 
#	docker push j5kim/med263-bansal
#-----------------------------------------------------------------------------

# install dependent Ubuntu packages
apt-get update && apt-get install -y  \
autoconf \
build-essential \
bzip2 \
curl \
default-jre \
git \
g++ \
libcurl4-openssl-dev \
liblzma-dev \
libncurses5-dev \
libncursesw5-dev \
libssl-dev \
libboost-all-dev \
libbz2-dev \
make \
man \
pkg-config \
python \
python-pip \
python-dev \
software-properties-common \
screen \
vim \
wget \
zip \
zlibc \
zlib1g \
zlib1g-dev 


# install htslib  
cd /opt
git clone https://github.com/samtools/htslib
	cd htslib
	autoheader
	autoconf
	./configure
	make
	make install

# install samtools
cd /opt
git clone https://github.com/samtools/samtools.git
	cd samtools
	autoheader
	autoconf
	./configure
	make
	make install


# install bedtools
apt-get install -y bedtools

# install python scipy: https://www.scipy.org/install.html 
apt-get install -y python-numpy python-scipy 

# install hapcut
cd /opt
git clone https://github.com/vibansal/hapcut.git
	cd hapcut 
	make all
	echo -e export PATH=/opt/hapcut:$PATH  >> /etc/profile
