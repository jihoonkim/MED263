# !/bin/bash
#-----------------------------------------------------------------------------
# MED 263 
#
#	docker build -t j5kim/med263-heinz .
#	docker run -ti -v $(pwd):/work j5kim/med263-heinz:latest /bin/bash
#	docker commit -a "Jihoon Kim" $(docker ps -a -q | head -n 1) j5kim/med263-heinz
#	docker login --username=j5kim 
#	docker push j5kim/med263-heinz
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
	libxml2-dev \
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


# install dependent R packages
cd /opt
cat > install_Rpackages.R << EOL
options(repos = c(CRAN = "http://cran.cnr.berkeley.edu/"))
install.packages("RCurl")
install.packages("XML")
source("https://bioconductor.org/biocLite.R")
biocLite("DESeq2")
biocLite("edgeR")
EOL

Rscript install_Rpackages.R


# install HOMER
cd /opt
mkdir homer
cd /opt/homer
wget http://homer.ucsd.edu/homer/configureHomer.pl
perl /opt/homer/configureHomer.pl -install
echo "export PATH=$PATH:/opt/homer/bin" >> /etc/profile

