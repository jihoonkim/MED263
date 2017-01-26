#!/bin/bash

#-----------------------------------------------------------------------------
# File: install_gnome_and_nomachine.sh
# Author: Jihoon Kim 
# Description: Install GNOME desktop environment for ubuntu and
#                      NOMACHINE for remote desktop access to ubuntu VM
# Date: 1/25/2017
#-----------------------------------------------------------------------------
# update Ubuntu
apt-get update -y

# upgrade Ubuntu
apt-get upgrade -y

# close the opened port 25 for mail server 
systemctl stop postfix
systemctl disable postfix

# install nomachine server
wget http://download.nomachine.com/download/5.1/Linux/nomachine_5.1.62_1_amd64.deb
dpkg -i nomachine_5.1.62_1_amd64.deb

# install gnome  
apt-get install gnome-core ubuntu-gnome-desktop

# disable gnome screen saver 
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.desktop.session idle-delay 0

# change the NX authentication to that of sshd
mv /etc/pam.d/nx  /etc/pam.d/nx-default
cp /etc/pam.d/sshd /etc/pam.d/nx 

# change the NX port number to 5091
sed -i 's/NXPort 4000/NXPort 5091/g' /usr/NX/etc/server.cfg

# add 'localhost' to the end of line starting with 127.0.0.1 in /etc/hosts
sed -i '/^127.0.0.1/ s/$/ localhost'/ hosts

# restart NX server
service nxserver start 
