#!/bin/bash

# Clone and install linuxptp

cd ~
git clone http://git.code.sf.net/p/linuxptp/code linuxptp
cd ./linuxptp/
git checkout v2.0
sudo make install

# Run ptp4l and phc2sys 
mkdir RUN_LOG

# Update default.cfg
if [ ! -f "./default-1.cfg" ]; then
  echo "Updating default.cfg"
  
  sed -i 's/^domainNumber.*/domainNumber 24/' configs/default.cfg
  sed -i 's/^dataset_comparison.*/dataset_comparison G.8275.x/' configs/default.cfg 

  sudo ./ptp4l -i ens1f1 -m -H -2 -s -f configs/default.cfg > ./RUN_LOG/ptp4l.log 2>&1 &
  sudo ./phc2sys -w -m -s ens1f1 -R 8 -f configs/default.cfg > ./RUN_LOG/phc2sys.log 2>&1 &

else
  echo "default-1.cfg exists, no changes made to default.cfg"
  sudo ./ptp4l -i ens1f1 -m -H -2 -s -f configs/default-1.cfg > ./RUN_LOG/ptp4l.log 2>&1 &
  sudo ./phc2sys -w -m -s ens1f1 -R 8 -f configs/default-1.cfg > ./RUN_LOG/phc2sys.log 2>&1 &
fi