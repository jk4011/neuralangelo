#!/bin/bash
set -o xtrace # print command

mkdir /data2/wlsgur4011/data/
cp /data/wlsgur4011/DataCollection/*.zip /data2/wlsgur4011/data/
cd /data2/wlsgur4011/data/
unzip \*.zip
cd /data2/wlsgur4011/neuralangelo/
mkdir datasets && cd datasets
ln -s /data2/wlsgur4011/data/dtu_neus dtu
cd ../..
