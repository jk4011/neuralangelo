#!/bin/bash

# GPUS=(0 3 4 5 6 7)
GPUS=(0 3 4 5 6 7)
NGPUS=${#GPUS[@]}

EXPERIMENT=dtu
GROUP=example_group
CONFIG=projects/neuralangelo/configs/${EXPERIMENT}.yaml

IDX_LIST=("24" "37" "40" "55" "63" "65" "69" "83" "97" "105" "106" "110" "114" "118" "122")
IDX_LEN=${#IDX_LIST[@]}

for (( i=0; i<$IDX_LEN; i+=${NGPUS} )); do
    for (( j=0; j<${NGPUS}; j++ )); do
        if (( i+j < IDX_LEN )); then
            echo 1111
            IDX=${IDX_LIST[i+j]}
            NAME="dtu$IDX"
            sed -i "s/dtu_scan[0-9]\+/dtu_scan$IDX/g" projects/neuralangelo/configs/dtu.yaml
            PORT=$((26000 + $j))
            CUDA_VISIBLE_DEVICES=${GPUS[j]} torchrun --master_port=${PORT} train.py \
                --logdir=logs/${GROUP}/${NAME} \
                --config=${CONFIG} \
                --show_pbar \
                --wandb &
                # 2>&1 > logs/${GROUP}/commmand_log 
        fi
        sleep 10
    done
    wait
done
