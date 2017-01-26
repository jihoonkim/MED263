#!/bin/bash

#-----------------------------------------------------------------------------
# File: install_gnome_and_nomachine.sh
# Author: Jihoon Kim 
# Description: Install GNOME desktop environment for ubuntu and
#                      NOMACHINE for remote desktop access to ubuntu VM
# Date: 1/25/2017
#-----------------------------------------------------------------------------
# update ubuntu
apt-get update

# close the opened port 25 for mail server 
#systemctl stop postfix
#systemctl disable postfix

# install gnome  
apt-get install -y ubuntu-gnome-desktop

# change the GDM authenticaion to that of SSHD
mv /etc/pam.d/gdm-launch-environment /etc/pam.d/gdm-launch-environment-default
cp /etc/pam.d/sshd /etc/pam.d/gdm-launch-environment

mv /etc/pam.d/gdm-autologin /etc/pam.d/gdm-autologin-default
cp /etc/pam.d/sshd /etc/pam.d/gdm-autologin

mv /etc/pam.d/gdm-password /etc/pam.d/gdm-password-default
cp /etc/pam.d/sshd /etc/pam.d/gdm-password


# start GNOME Display Manager (GDM) 
systemctl start gdm3 

# install nomachine server
wget http://download.nomachine.com/download/5.1/Linux/nomachine_5.1.62_1_amd64.deb
dpkg -i nomachine_5.1.62_1_amd64.deb

# change the NX authentication to that of SSHD
mv /etc/pam.d/nx  /etc/pam.d/nx-default
cp /etc/pam.d/sshd /etc/pam.d/nx 

# change the NX port number to 5901
sed -i 's/#NXPort 4000/NXPort 5901/g' /usr/NX/etc/server.cfg

# add 'localhost' to the end of line starting with 127.0.0.1 in /etc/hosts
sed -i '/^127.0.0.1/ s/$/ localhost/'  /etc/hosts

# restart NX server
service nxserver start 

# reboot
#reboot