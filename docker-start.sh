#!/bin/bash

cd /root;
if [ -f /volume/my.ks ]; then
  KS=/volume/my.ks;
else
  KS=/root/default.ks
fi

ami-creator $KS $1
./img2docker.sh $1.img $1
