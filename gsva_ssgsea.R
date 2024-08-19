library(GSVA)

# inputs: mat: gene expression matrix with genes in rows and samples in columns
#         gs: gene sets
# output: gsva_es or ssgsea_es: enrichment scores with samples in columns

# function: run_gsva
run_gsva <- function(mat, gs) {
  gsva_par <- gsvaParam(mat, gs) # gsva
  gsva_es <- gsva(gsva_par)

  return(gsva_es)
}

# function: run_ssgsea
run_ssgsea <- function(mat, gs) {
  ssgsva_par <- ssgseaParam(mat, gs) # ssgsea
  ssgsea_es <- gsva(ssgsva_par)

  return(ssgsea_es)
}
