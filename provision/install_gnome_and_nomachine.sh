#!/bin/bash

#-----------------------------------------------------------------------------
# File: install_gnome_and_nomachine.sh
# Author: Jihoon Kim 
# Description: Install GNOME, a desktop environment for Ubuntu, and
#                      NoMachine, a tool for remote desktop access
# Date: 1/26/2017
#-----------------------------------------------------------------------------
# update ubuntu packages
apt-get update

# stop and disable Postfix, the default mail transfer agent in Ubuntu
#  (This closes the unnecessarily opened port 25)
systemctl stop postfix

# install GNOME, a desktop environment for Ubuntu  
apt-get install -y ubuntu-gnome-desktop

# change the GDM authenticaion to that of SSHD
mv /etc/pam.d/gdm-launch-environment /etc/pam.d/gdm-launch-environment-default
cp /etc/pam.d/sshd /etc/pam.d/gdm-launch-environment

mv /etc/pam.d/gdm-autologin /etc/pam.d/gdm-autologin-default
cp /etc/pam.d/sshd /etc/pam.d/gdm-autologin

mv /etc/pam.d/gdm-password /etc/pam.d/gdm-password-default
cp /etc/pam.d/sshd /etc/pam.d/gdm-password

# install NoMachine server
wget http://download.nomachine.com/download/5.2/Linux/nomachine_5.2.11_1_amd64.deb
dpkg -i nomachine_5.2.11_1_amd64.deb

# change the NX authentication to that of SSHD
mv /etc/pam.d/nx  /etc/pam.d/nx-default
cp /etc/pam.d/sshd /etc/pam.d/nx 

# change the NX port number to 5901
sed -i 's/#NXPort 4000/NXPort 5901/g' /usr/NX/etc/server.cfg

# disable NX Server requesting authorization to the owner of the virtual 
#   desktop before connecting
sed -i 's/#VirtualDesktopAuthorization 1/VirtualDesktopAuthorization 0/g' /usr/NX/etc/server.cfg

# disable NX Server requesting authorization to the owner of the physical 
#    desktop before connecting.
sed -i 's/#PhysicalDesktopAuthorization 1/PhysicalDesktopAuthorization 0/g' /usr/NX/etc/server.cfg

# add 'localhost' to the end of line starting with 127.0.0.1 in /etc/hosts
sed -i '/^127.0.0.1/ s/$/ localhost/'  /etc/hosts

# start GNOME Display Manager (GDM) 
systemctl start gdm3 

# restart NX server
service nxserver start 

# reboot the server
reboot
