#!/bin/bash

GPU=$1
GROUP=tutorial
NAME="lego"

echo 1111
PORT=26666
CUDA_VISIBLE_DEVICES=${GPU} torchrun --master_port=${PORT} train.py \
    --logdir=logs/${GROUP}/${NAME} \
    --config=projects/neuralangelo/configs/custom/lego.yaml \
    --show_pbar \
    --wandb
    # 2>&1 > logs/${GROUP}/commmand_log 
