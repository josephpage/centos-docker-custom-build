#!/bin/bash

cd /root;
if [ -f /volume/my.ks ]; then
  echo "Custom Kickstart is detected."
  KS=/volume/my.ks;
else
  echo "No custom Kickstart."
  KS=/root/default.ks
fi

echo "Image compilation..."
ami-creator $KS $1
echo "Importing image into Docker..."
./img2docker.sh $1.img $1
