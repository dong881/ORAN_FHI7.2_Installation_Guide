#!/bin/bash
echo -e "\n=== Red Hat Release: ==="
cat /etc/redhat-release

echo -e "\n=== Ubuntu version: ==="
lsb_release -a

echo -e "\n=== Kernel Information: ==="
uname -a

echo -e "\n=== CPU Information: ==="
cat /proc/cpuinfo | grep "model name" | awk -F': ' '{print $2}' | head -1

echo -e "\n=== PCI Devices: (X710) ==="
lspci | grep "Intel Corporation Ethernet Controller X710"

echo -e "\n"
