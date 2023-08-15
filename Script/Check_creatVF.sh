#!/bin/bash

NIC=ens1f1

# echo "Check NIC: $NIC"
# ifconfig
# ethtool -i $NIC

echo "Create VF on $NIC"
sudo echo 0 > /sys/class/net/$NIC/device/sriov_numvfs 
sudo echo 2 > /sys/class/net/$NIC/device/sriov_numvfs

echo "Configure VF on $NIC"
ip link set $NIC vf 0 mac 00:11:22:33:44:66 vlan 3 spoofchk off
ip link set $NIC vf 1 mac 00:11:22:33:44:66 vlan 4 spoofchk off

echo "Reload VFIO module"  
modprobe vfio_pci

echo "Check configuration of $NIC"
ip link show $NIC

echo "Find PCI address"
DEVBIND_OUTPUT=$(python3 /usr/local/bin/dpdk-devbind.py --status)

VF0_PCI=$(echo "$DEVBIND_OUTPUT" | grep "${NIC}v0" | awk '{print $1}')
VF1_PCI=$(echo "$DEVBIND_OUTPUT" | grep "${NIC}v1" | awk '{print $1}')

echo "VF0 PCI: $VF0_PCI"
echo "VF1 PCI: $VF1_PCI"

echo "Bind devices"
python3 /usr/local/bin/dpdk-devbind.py --bind vfio-pci $VF0_PCI $VF1_PCI

echo "Verify binding"
python3 /usr/local/bin/dpdk-devbind.py --status