"""Stratify expression levels of genes based on a quantile."""


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
    if all(x in adata.var_names for x in genes):
        expression = adata[adata.obs[col_name] == cell_type, genes].to_df(
            layer=layer)
        cells = expression.index

        for gene in genes:
            # add new column to adata.obs, fill with cell_type
            adata.obs[gene + '_level'] = adata.obs[col_name].to_list()

            # subset non-zero expression
            non_zero = expression.loc[expression[gene] != 0.0, gene]
            quantile = non_zero.quantile([threshold, 1 - threshold])

            # row indices for low, medium, and high expression
            zero = cells[expression[gene] == 0.0]
            low = cells[(expression[gene] > 0.0) &
                        (expression[gene] < quantile[threshold])]
            medium = cells[(expression[gene] >= quantile[threshold]) &
                           (expression[gene] < quantile[1 - threshold])]
            high = cells[expression[gene] >= quantile[1 - threshold]]

            # stratify expression levels
            adata.obs.loc[zero, gene + '_level'] = 'Not detected'
            adata.obs.loc[low, gene + '_level'] = 'Low'
            adata.obs.loc[medium, gene + '_level'] = 'Medium'
            adata.obs.loc[high, gene + '_level'] = 'High'

        return adata

    else:
        print('ERROR: Not all genes are in the dataset')
        return 1
