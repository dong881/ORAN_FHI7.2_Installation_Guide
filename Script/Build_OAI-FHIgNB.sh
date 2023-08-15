#!/bin/bash

# 初始目錄為安裝目錄 
cd ~

echo "Cloning openairinterface5g..."
git clone https://gitlab.eurecom.fr/oai/openairinterface5g.git

echo "Checking out use_msgq branch..."
cd openairinterface5g 
git checkout use_msgq

echo "Modifying build_helper..."
cd cmake_targets/tools
sed -i 's/rhel8.7/rhel8.8/g' build_helper
echo "Changed rhel8.7 to rhel8.8 in build_helper"

echo "Cloning phy repository..."
cd ../../..
git clone https://gerrit.o-ran-sc.org/r/o-du/phy.git

echo "Checking out specific branch..."
cd phy 
git checkout oran_release_bronze_v1.1

echo "Copying over openairinterface patches..."
cp ../openairinterface5g/cmake_targets/tools/oran_fhi_integration_patches/oran-fhi-* .

echo "Applying patches..."
git apply oran-fhi-1-compile-libxran-using-gcc-and-disable-avx512.patch
git apply oran-fhi-2-return-correct-slot_id.patch  
git apply oran-fhi-3-disable-pkt-validate-at-process_mbuf.patch
git apply oran-fhi-4-process_all_rx_ring.patch
git apply oran-fhi-5-remove-not-used-dependencies.patch

echo "Changing to fhi_lib directory..."
cd fhi_lib

echo "Exporting environment variables..."
export XRAN_LIB_DIR=~/phy/fhi_lib/lib/build
export XRAN_DIR=~/phy/fhi_lib
export RTE_SDK=~/dpdk-20.05
export RTE_TARGET=x86_64-native-linuxapp-gcc
export RTE_INCLUDE=${RTE_SDK}/${RTE_TARGET}/include

echo "Running build script..."
./build.sh