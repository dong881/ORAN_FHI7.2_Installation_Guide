#! /bin/bash

echo "--> set the server to maximum performance mode."
sudo tuned-adm profile realtime
echo "success"

echo "--> Updating RedHat System"
sudo yum -y update

