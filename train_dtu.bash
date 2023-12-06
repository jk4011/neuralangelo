EXPERIMENT=dtu
GROUP=example_group
CONFIG=projects/neuralangelo/configs/${EXPERIMENT}.yaml
GPUS=1  # use >1 for multi-GPU training!

for IDX in "40" "55" "63" "65" "69" "83" "97" "105" "106" "110" "114" "118" "122"; do
    NAME="dtu$IDX"
    sed -i "s/dtu_scan[0-9]\+/dtu_scan$IDX/g" projects/neuralangelo/configs/dtu.yaml
    torchrun --nproc_per_node=${GPUS} train.py \
        --logdir=logs/${GROUP}/${NAME} \
        --config=${CONFIG} \
        --show_pbar \
            --wandb
done