# become a root 
sudo su -

# update and upgrade Ubuntu packages
apt-get upgrade -y
apt-get update -y 

# install dependent packages
apt-get install -y libcurl4-openssl-dev libssl-dev

# remove some packages
apt autoremove 

# download and install Anaconda
wget https://repo.continuum.io/archive/Anaconda2-4.3.0-Linux-x86_64.sh
bash Anaconda2-4.3.0-Linux-x86_64.sh -b -p /opt/anaconda2 

# add Anaconda path
echo -e 'export PATH=/opt/anaconda2/bin:$PATH'  >> /etc/profile
source /etc/profile

# create a script for a batch installation of R packages
cat > install_Jupyter_Rpackages.R << EOL
myRepo = "http://cran.cnr.berkeley.edu/"
myWishList = c("crayon", "curl", "devtools", "digest", "evaluate", "git2r", "httr", "IRdisplay", "IRkernel", "jsonlite", "memoise", "openssl", "pbdZMQ", "repr", "uuid", "whisker", "withr")
targetLibDir = "/usr/lib/R/library"
options(repos = c(CRAN = myRepo))
install.packages(myWishList, lib=targetLibDir)
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()
EOL

# run the above script for a batch installation of R packages
Rscript install_Jupyter_Rpackages.R