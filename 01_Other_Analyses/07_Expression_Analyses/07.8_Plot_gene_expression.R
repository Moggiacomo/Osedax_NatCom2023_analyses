library(tidyverse)
library(dplyr)
library(ggplot2)
library(data.table)
library(gplots)
library(pheatmap)
library(dendextend)
library(factoextra)
library(ComplexHeatmap)
library(RColorBrewer)
library(NbClust)
library(scales)

#Import data in matrix format
B <- read.delim("/Users/giacomo/Desktop/GlycineCleavageSystem/FINAL_GlycineCleavageSystem_osedax_kallisto_tpm_ALLscaled.tsv", row.names=1)

# To make 0 a different colour
# First create whatever gradient (e.g. RdBu)
heatmap_color <- colorRampPalette(brewer.pal(n = 7, name = "Reds"))(1000)
heatmap_color[1] <- rgb(1,1,1)
#column_labels = c("your","labels"),
#row_labels = c("your","labels"))

paletteLength <- 1000
         
pheatmap(B,
         cluster_rows = FALSE, 
         cluster_cols = FALSE, 
         border_color = NA,
         color = heatmap_color, 
         height = 5, 
         width = 25)
