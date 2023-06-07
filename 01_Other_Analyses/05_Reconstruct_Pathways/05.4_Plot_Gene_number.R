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
A <- read.delim("~/Desktop/DNA_repair/DNA_repair_NOisoforms/A", row.names=1)
B <- read.delim("~/Desktop/DNA_repair/DNA_repair_NOisoforms/B", row.names=1)
C <- read.delim("~/Desktop/DNA_repair/DNA_repair_NOisoforms/C", row.names=1)
D <- read.delim("~/Desktop/DNA_repair/DNA_repair_NOisoforms/D", row.names=1)
E <- read.delim("~/Desktop/DNA_repair/DNA_repair_NOisoforms/E", row.names=1)
F <- read.delim("~/Desktop/DNA_repair/DNA_repair_NOisoforms/F", row.names=1)

# Option 1. 0 to 1 relative abundance/expression (54 is the highest value in my dataset)
rescale_custom <- function(x) (x/14)
A_normalised <- t(apply(A, 1, rescale_custom))
rescale_custom <- function(x) (x/54)
B_normalised <- t(apply(B, 1, rescale_custom))
rescale_custom <- function(x) (x/11)
C_normalised <- t(apply(C, 1, rescale_custom))
rescale_custom <- function(x) (x/18)
D_normalised <- t(apply(D, 1, rescale_custom))
rescale_custom <- function(x) (x/18)
E_normalised <- t(apply(E, 1, rescale_custom))
rescale_custom <- function(x) (x/27)
F_normalised <- t(apply(F, 1, rescale_custom))


# To make 0 a different colour
# First create whatever gradient (e.g. RdBu)
heatmap_color <- colorRampPalette(brewer.pal(n = 7, name = "Reds"))(1000)
heatmap_color[1] <- rgb(1,1,1)
#column_labels = c("your","labels"),
#row_labels = c("your","labels"))

paletteLength <- 1000
# to go from 0 to max.value (e.g. 1):
myBreaks <- c(seq(1/paletteLength, 1, length.out=floor(paletteLength)))

pheatmap(A_normalised,
         cluster_rows = FALSE, 
         cluster_cols = FALSE, 
         border_color = NA,
         color = heatmap_color, 
         height = 25, 
         width = 20,
         breaks = myBreaks)

pheatmap(B_normalised,
         cluster_rows = FALSE, 
         cluster_cols = FALSE, 
         border_color = NA,
         color = heatmap_color, 
         height = 25, 
         width = 20,
         breaks = myBreaks)
         
pheatmap(C_normalised,
         cluster_rows = FALSE, 
         cluster_cols = FALSE, 
         border_color = NA,
         color = heatmap_color, 
         height = 25, 
         width = 20,
         breaks = myBreaks)
         
pheatmap(D_normalised,
         cluster_rows = FALSE, 
         cluster_cols = FALSE, 
         border_color = NA,
         color = heatmap_color, 
         height = 25, 
         width = 20,
         breaks = myBreaks)

pheatmap(E_normalised,
         cluster_rows = FALSE, 
         cluster_cols = FALSE, 
         border_color = NA,
         color = heatmap_color, 
         height = 25, 
         width = 20,
         breaks = myBreaks)
         
pheatmap(F_normalised,
         cluster_rows = FALSE, 
         cluster_cols = FALSE, 
         border_color = NA,
         color = heatmap_color, 
         height = 25, 
         width = 20,
         breaks = myBreaks)
