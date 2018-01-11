
### Reference
# https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#set-up-the-repository

### Update the apt package index:
sudo apt-get update

### Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

### Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

### Set up the stable repository.
###
### Note: 
###   The lsb_release -cs sub-command below returns the name of your 
###   Ubuntu distribution, such as xenial. Sometimes, in a distribution like 
###   Linux Mint, you might have to change $(lsb_release -cs) to your parent 
###   Ubuntu distribution. For example, if you are using Linux Mint Rafaela, 
###   you could use trusty.
# sudo add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

### Update the apt package index.
sudo apt-get update

### Install the latest version of Docker CE
sudo apt-get install docker-ce

### Add your user to the docker group.
sudo usermod -aG docker $USER