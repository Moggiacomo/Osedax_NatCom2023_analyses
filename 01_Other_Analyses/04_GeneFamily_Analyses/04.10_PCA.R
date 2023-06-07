
library(stats)
library(factoextra)
library(R.utils)

# Whole dataset: 47,685 orthogroups
orthogroups <- read.csv("/Users/giacomo/Desktop/PCA/Orthogroups.GeneCount.tsv", header=T, sep='\t')
orthogroups_selection <- data.frame()

# We subset the 21,189 orthogroups that are not species-specific
# or the 14,373 orthogroups that are found in at least 3 species
for (i in 1:nrow(orthogroups)){
  if (sum(isZero(orthogroups[i,-c(1,30)])) < 26){
    orthogroups_selection <- rbind(orthogroups_selection,orthogroups[i,])
  }
}

# We transpose the orthogroups to analyse the individuals rather than the
# orthogroups in the downstream analysis```

individuals <- t(orthogroups_selection[-c(1,30)])
individuals_clean <- individuals[,which(apply(individuals, 2, var)!=0)]

pca_results <- prcomp(individuals_clean, scale = TRUE)
fviz_eig(pca_results)
fviz_pca_ind(pca_results, repel = TRUE) +
  theme_classic()
