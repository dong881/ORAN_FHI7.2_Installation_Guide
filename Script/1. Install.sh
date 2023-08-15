#!/bin/bash

cd~

echo "--> set the server to maximum performance mode."
sudo tuned-adm profile realtime
echo "success"

echo "Updating system..."
sudo yum -y update

echo "Installing yum packages..." 
sudo yum install python3-pip gcc gcc-c++ kernel-devel make

echo "Installing Python packages..."
sudo pip3 install meson==0.58.2

echo "Downloading and installing ninja-build..."
wget https://vault.centos.org/centos/8/PowerTools/x86_64/os/Packages/ninja-build-1.8.2-1.el8.x86_64.rpm
sudo yum -y localinstall ninja-build-1.8.2-1.el8.x86_64.rpm

echo "success install"