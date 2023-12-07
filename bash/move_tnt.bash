#!/bin/bash
set -o xtrace # print command

mkdir /data2/wlsgur4011/data/
cp /data/wlsgur4011/DataCollection/tanks_and_temples/tanks_and_temples.zip /data2/wlsgur4011/data/

cd /data2/wlsgur4011/data/
unzip tanks_and_temples.zip
mv data tanks_and_temples
cd /data2/wlsgur4011/neuralangelo/

mkdir datasets
cd datasets
ln -s /data2/wlsgur4011/data/tanks_and_temples/ tanks_and_temples
cd ../..
