# Tools4Bioinformatics

This repository contains some useful tools for bioinformatics analysis, such as file/dictionary management, data preprocess and gene label conversion.

## untar_ungz.py

decompress the tar file and the gz file

```python
def untar(tar_file, output_dic):
def ungz(gz_file, output_file):
```

## mex_to_h5.R

change 10X mex format files into h5 format files

## cellbender.sh

remove background using cellbender, using conda environment:

```shell
conda create -n cellbender python=3.7
conda activate cellbender
pip install cellbender
```

## stratify_expression_levels.py

```python
def stratify_expression_levels(
        adata, genes, threshold=0.4, layer='data',
        col_name='broad_type', cell_type='Cancer cell'):
    """
    Stratify expression levels of genes based on a quantile.

    Parameters:
    ------------
    adata: AnnData object
        an anndata object that contains expression data
    genes: list
        a list of genes to stratify
    threshold: float. default=0.4
        quantile threshold to stratify expression levels
    layer: str, default='data'
        layer in adata that contains normalized data
    col_name: str, default='broad_type'
        column name in adata.obs that contains cell types
    cell_type: str, default='Cancer cell'\
        cell names of the cells need to be stratified

    Returns:
    ------------
    AnnData object

    """
```
