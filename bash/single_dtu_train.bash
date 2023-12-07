#!/bin/bash

START_IDX=$1
GPUS=(${@:2})
NGPUS=${#GPUS[@]}

EXPERIMENT=dtu
GROUP=example_group
CONFIG=projects/neuralangelo/configs/${EXPERIMENT}.yaml

IDX_LIST=("24" "37" "40" "55" "63" "65" "69" "83" "97" "105" "106" "110" "114" "118" "122")
IDX_LEN=${#IDX_LIST[@]}

for (( j=0; j<${NGPUS}; j++ )); do
    if (( i+j < IDX_LEN )); then
        SMALL_IDX=$((START_IDX+i+j))
        IDX=${IDX_LIST[SMALL_IDX]}
        NAME="dtu$IDX($SMALL_IDX)"

        # if IDX is larger than len IDX_LEN, break
        if [ $SMALL_IDX -ge $IDX_LEN ]; then
            echo "Index out of range, breaking the loop"
            break
        fi

        echo 1111
        echo $NAME
        sed -i "s/dtu_scan[0-9]\+/dtu_scan$IDX/g" projects/neuralangelo/configs/dtu.yaml
        PORT=$((26000 + $j))
        CUDA_VISIBLE_DEVICES=${GPUS[j]} torchrun --master_port=${PORT} train.py \
            --logdir=logs/${GROUP}/${NAME} \
            --config=${CONFIG} \
            --show_pbar \
            --wandb &
            # 2>&1 > logs/${GROUP}/commmand_log 
        sleep 10
    fi
done
