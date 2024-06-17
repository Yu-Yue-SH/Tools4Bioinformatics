#!/bin/bash

# activate conda env and move to working dictionary
source /home/yuyue/miniconda3/bin/activate cellbender
cd /mnt/e/Cancer/RCC/GSE207493/code || exit

# run cellbender
data_path='./outputs/raw_h5/'
for data in "$data_path"*.h5
do
  [ -e "$data" ] || continue
  echo "$data"
  name=$(basename "$data" .h5)
  cellbender remove-background \
    --cuda \
    --input "$data" \
    --output ./outputs/cellbender/"$name"/"$name".h5
done
