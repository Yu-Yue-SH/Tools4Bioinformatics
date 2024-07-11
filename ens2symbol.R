library(biomaRt)


#### function: ens2symbol ####
ens2symbol <- function(df, mart) {
  bm <- getBM(
    attributes = c('ensembl_gene_id', 'external_gene_name'),
    filters = 'ensembl_gene_id', values = rownames(df),
    mart = mart)  # different species have different mart

  df <- df[bm[['ensembl_gene_id']],]
  rownames(df) <- make.unique(bm[['external_gene_name']])

  return(df)
}


#### main ####
# load data: genes by samples, data.frame
data <- read.table('path_to_your_data')

# find your reference genome in https://www.ensembl.org/
# e.g.
# If you need the reference genome for chicken: Galgal4, first search 'Galgal4' in bing. Find the Ensembl website of
# chicken genome (http://mart.ensembl.org/Gallus_gallus/Info/Index). Choose the specific genome version (Galgal4) and
# recite the Ensembl version of this specific genome version (Ensembl 80).

# Next, find the host of this Ensembl version. Use listEnsemblArchives() to create a data.frame of all Ensembl versions.
# Find your version (Ensembl 80) and remember the host of this version (https://may2015.archive.ensembl.org).
arc_list <- listEnsemblArchives()

# Then, find the genome of your species (chicken). Use listDatasets() , input host (biomart do not need to change) and
# this will return a data.frame of all species in the specific Ensembl version. Find your species (ggallus_gene_ensembl)
# and check the genome version (Galgal4).
ds_list_chicken <- listDatasets(
  useMart(host = 'https://may2015.archive.ensembl.org',
          biomart= 'ENSEMBL_MART_ENSEMBL'))

# Finally, create mart for the reference genome. Use useMart() and input the host and dataset (biomart do not need to
# change).
mart_chicken <- useMart(
  host = 'https://may2015.archive.ensembl.org',
  biomart= 'ENSEMBL_MART_ENSEMBL',
  dataset = 'ggallus_gene_ensembl')

# Use the function ens2symbol(), input the data and mart and this will return a data.frame with row names changed into
# symbols. Idealy, all the Ensembl ids will be changed into symbols.
data_changed <- ens2symbol(data, mart_chicken)
