rm(list = ls())


library(Seurat)
library(DropletUtils)


# load data path
data_dir <- list.dirs(
  './data/GSE207493_scRNA-seq/scRNA-seq/',
  recursive = FALSE
)


# read data and save as h5 file
for (i in data_dir) {
  print(i)
  data <- Read10X(data.dir = i)
  write10xCounts(
  path = paste0('./outputs/raw_h5/', basename(i), '.h5'),
  x = data,
  type = 'HDF5',
  version = '3'
  )
}
