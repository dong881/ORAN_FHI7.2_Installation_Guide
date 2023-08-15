#!/bin/bash

# cd ~
wget http://fast.dpdk.org/rel/dpdk-20.05.tar.xz
tar xvf dpdk-20.05.tar.xz
cd dpdk-20.05
meson build
cd build
sudo ninja
sudo ninja install
yes | sudo dnf install numactl
yes | sudo dnf install numactl-devel
cd ..
make install T=x86_64-native-linuxapp-gcc