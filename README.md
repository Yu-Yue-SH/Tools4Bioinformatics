# Tools4Bioinformatics

This repository contains some useful tools for bioinformatics analysis, such as file/dictionary management, data preprocess and gene label conversion.

## untar_ungz.py

decompress the tar file and the gz file

1. untar(tar_file, output_dic):

   untar the tar_file to the output_dic

2. ungz(gz_file, output_file):

   ungz the gz_file to the output_file

## mex_to_h5.R

change 10X mex format files into h5 format files

## cellbender.sh

remove background using cellbender, using conda environment:

```shell
conda create -n cellbender python=3.7
conda activate cellbender
pip install cellbender
```

