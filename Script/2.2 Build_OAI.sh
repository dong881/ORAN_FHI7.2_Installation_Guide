#!/bin/bash

# 開發中...

# cd ~
cd ./openairinterface5g/cmake_targets/

echo "--> install lack lib from build rpm…"

# sudo yum install atlas-devel
yum install -y wget
wget https://vault.centos.org/centos/8/PowerTools/x86_64/os/Packages/guile-devel-2.0.14-7.el8.x86_64.rpm
yum -y groupinstall "Development Tools"
wget https://vault.centos.org/centos/8/PowerTools/x86_64/os/Packages/gc-devel-7.6.4-3.el8.x86_64.rpm 
yum -y localinstall gc-devel-7.6.4-3.el8.x86_64.rpm
yum -y localinstall guile-devel-2.0.14-7.el8.x86_64.rpm
wget https://vault.centos.org/centos/8/PowerTools/x86_64/os/Packages/libconfig-devel-1.5-9.el8.x86_64.rpm
yum -y localinstall libconfig-devel-1.5-9.el8.x86_64.rpm
wget https://vault.centos.org/centos/8/PowerTools/x86_64/os/Packages/lapack-devel-3.8.0-8.el8.x86_64.rpm
wget https://vault.centos.org/centos/8/BaseOS/x86_64/os/Packages/pkgconf-pkg-config-1.4.2-1.el8.x86_64.rpm  
yum -y localinstall pkgconf-pkg-config-1.4.2-1.el8.x86_64.rpm
wget https://vault.centos.org/centos/8/PowerTools/x86_64/os/Packages/blas-devel-3.8.0-8.el8.x86_64.rpm
yum -y localinstall blas-devel-3.8.0-8.el8.x86_64.rpm
yum -y localinstall lapack-devel-3.8.0-8.el8.x86_64.rpm 
yum -y install python27

echo "--> install success"

echo "--> Download the DPDK folder where -fPIC has already been added to CFLAGS in all makefiles and overwrite it."


