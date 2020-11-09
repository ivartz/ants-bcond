#!/bin/bash
​
# ants-node-*
# Openstack customization script
# Norwegian Research and Education Cloud (NREC)
# https://docs.nrec.no/intro.html#about
# Author: Ivar Thokle Hovden
​
# Each instance created with the script should have their 
# own public ip address

# Use ubuntu 18.04 LTS, since it is the only Ubuntu distro to data (2020-11-09) to have ants available
​
# Set time zone
#export TZ="Europe/Oslo"
echo "sudo dpkg-reconfigure tzdata" > /home/ubuntu/postinstall-manual.sh

# Install software
apt update -y && apt upgrade -y
apt install -y git rsync ants

git clone https://github.com/ivartz/ants-bcond
#cd ants-bcond
