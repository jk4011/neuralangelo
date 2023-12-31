#!/bin/bash

GPUS=0,3,4,5,6,7
NGPUS=6  # use >1 for multi-GPU training!

EXPERIMENT=dtu
GROUP=example_group
CONFIG=projects/neuralangelo/configs/${EXPERIMENT}.yaml

for IDX in "24" "37" "40" "55" "63" "65" "69" "83" "97" "105" "106" "110" "114" "118" "122"; do
    echo 1111
    NAME="dtu$IDX"
    sed -i "s/dtu_scan[0-9]\+/dtu_scan$IDX/g" projects/neuralangelo/configs/dtu.yaml
    CUDA_VISIBLE_DEVICES=${GPUS} torchrun --nproc_per_node=${NGPUS} train.py \
        --logdir=logs/${GROUP}/${NAME} \
        --config=${CONFIG} \
        --show_pbar \
            --wandb
    sleep 10
done