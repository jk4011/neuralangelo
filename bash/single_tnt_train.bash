#!/bin/bash

START_IDX=$1
GPUS=(${@:2})
NGPUS=${#GPUS[@]}

EXPERIMENT=tnt
GROUP=tnt
CONFIG=projects/neuralangelo/configs/${EXPERIMENT}.yaml

DATA_LIST=(Barn Ignatius Truck Caterpillar Courthouse Meetingroom)
DATA_LEN=${#DATA_LIST[@]}

for (( j=0; j<${NGPUS}; j++ )); do
    if (( i+j < DATA_LEN )); then
        IDX=$((START_IDX+i+j))
        DATA=${DATA_LIST[IDX]}
        NAME="${IDX}.${DATA}"

        # if IDX is larger than len DATA_LEN, break
        if [ $IDX -ge $DATA_LEN ]; then
            echo "Index out of range, breaking the loop"
            break
        fi

        echo 1111
        echo $NAME
        N_IMAGES=`ls datasets/tanks_and_temples/${DATA}/images | wc -l`
        sed -i "s/root\:\ datasets\/tanks_and_temples\/\w*/root\:\ datasets\/tanks_and_temples\/${DATA}/g"  projects/neuralangelo/configs/tnt.yaml
        sed -i "s/num_images\:\ [0-9]*/num_images: ${N_IMAGES}/g" projects/neuralangelo/configs/tnt.yaml
        PORT=$((27777 + $j))
        CUDA_VISIBLE_DEVICES=${GPUS[j]} torchrun --master_port=${PORT} train.py \
            --logdir=logs/${GROUP}/${NAME} \
            --config=${CONFIG} \
            --show_pbar \
            --wandb &
            # 2>&1 > logs/${GROUP}/commmand_log 
        sleep 10
    fi
done
