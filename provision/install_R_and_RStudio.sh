#!/bin/bash

#-----------------------------------------------------------------------------
# File: install_R_and_RStudio.sh
# Author: Jihoon Kim 
# Description: Install the most recent version of R, a language and 
#              environment for statistical computing and graphics
# Date: 1/25/2017
#-----------------------------------------------------------------------------


#-----------------------------------------------------------------------------
# Install the most recent version of R
#-----------------------------------------------------------------------------
# add a following line to sources.list
#export CRAN_URL=http://cran.r-project.org
export CRAN_URL=http://cran.stat.ucla.edu
bash -c " echo -e '\n'deb ${CRAN_URL}/bin/linux/ubuntu  xenial/ >>  /etc/apt/sources.list "


# add key to sign CRAN pacakges
# The Ubuntu archives on CRAN are signed with the key of 
#  "Michael Rutter <marutter@gmail.com>" with key ID E084DAB9. 
#   reference  http://cran.r-project.org/bin/linux/ubuntu/
apt-key adv --keyserver keyserver.ubuntu.com  --recv-keys E084DAB9

# update
apt-get update -y

# add specfic PPA
apt-get install -y python-software-properties 
add-apt-repository -y ppa:marutter/rdev

# update
apt-get update -y

# upgrade
apt-get upgrade -y

# install R base version
apt-get install -y r-base

# install R packages 
apt-get install -y r-base-dev


#-----------------------------------------------------------------------------
# Install R Studio
#-----------------------------------------------------------------------------
apt-get install -y libapparmor1 gdebi-core
wget https://download1.rstudio.org/rstudio-xenial-1.1.383-amd64.deb
gdebi -n rstudio-xenial-1.1.383-amd64.deb


#-----------------------------------------------------------------------------
# Install R packages
#-----------------------------------------------------------------------------
# create an R script to install R packages
cat > install_Rpackages.R << EOL
options(repos = c(CRAN = "http://cran.cnr.berkeley.edu/"))
install.packages( "cgdsr" ) 
EOL

# run the R script 
Rscript install_Rpackages.R
