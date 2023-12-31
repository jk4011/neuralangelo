#!/bin/bash
# set -e        # exit when error
set -o xtrace # print command


for step in 020000 040000 060000 080000 100000 120000 140000 160000 180000 200000 220000 240000 260000 280000 300000 320000 340000 360000 380000 400000 420000 440000 460000 480000
do
    echo $step
    rm logs/example_group/*/*${step}*.pt
    # rm -rf ./models/step_$step
done