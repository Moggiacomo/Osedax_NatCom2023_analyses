
install.packages("BiocManager")
BiocManager::install("topGO")
install.packages("ggpubr")

library(topGO)
library(ggplot2)
library(ggpubr)
library(cowplot)

# Import gene universe: whole (GO-annotated) genome
geneID2GO <- readMappings(file = "/Users/giacomo/Desktop/R/GO_enrichment/riftia_GO_universe.txt") ### 21108 transcripts have GO annotation
geneUniverse <- names(geneID2GO)

# Import and transform genes of interest: 8 clusters from step2a
cluster1 <- read.table("/Users/giacomo/Desktop/R/GO_enrichment/gene_IDs_expanded_riftia.txt",header=FALSE)
cluster1 <- as.character(cluster1$V1) 
cluster1genelist <- factor(as.integer(geneUniverse %in% cluster1))
names(cluster1genelist) <- geneUniverse

# fisher testing of GO term enrichment for Molecular Function (MF)
#cluster 1 - red genes
cluster1_GOdata_MF <- new("topGOdata", description="Cluster1", 
                          ontology="MF", allGenes=cluster1genelist,  
                          annot = annFUN.gene2GO, gene2GO = geneID2GO)
cluster1_resultFisher_MF <- runTest(cluster1_GOdata_MF, 
                                    algorithm="classic", statistic="fisher")
cluster1_MF <- GenTable(cluster1_GOdata_MF, classicFisher = cluster1_resultFisher_MF, 
                        orderBy = "resultFisher", ranksOf = "classicFisher", topNodes = 15)

cluster1_MF[cluster1_MF == "< 1e-30"] <- "1e-30"

goEnrichment <- cluster1_MF
goEnrichment$classicFisher <- as.numeric(goEnrichment$classicFisher)
goEnrichment <- goEnrichment[,c("GO.ID","Term","classicFisher")]
goEnrichment$Term <- gsub(" [a-z]*\\.\\.\\.$", "", goEnrichment$Term)
goEnrichment$Term <- gsub("\\.\\.\\.$", "", goEnrichment$Term)
goEnrichment$Term <- paste(goEnrichment$GO.ID, goEnrichment$Term, sep=", ")
goEnrichment$Term <- factor(goEnrichment$Term, levels=rev(goEnrichment$Term))


cluster_1_plot <- ggplot(goEnrichment, aes(x=Term, y=-log10(classicFisher))) +
  stat_summary(geom = "bar", fun = mean, position = "dodge") +
  xlab("Biological process") +
  ylab("-log10(p-value)") +
  ggtitle("GF expansions in Riftia") +
  scale_y_continuous(limits=c(0,30),breaks=round(seq(0,30, by = 2), 1)) +
  theme_classic() +
  theme(
    legend.position='none',
    legend.background=element_rect(),
    plot.title=element_text(angle=0, size=12, face="bold", vjust=1),
    axis.text.x=element_text(angle=0, size=10, hjust=1.10),
    axis.text.y=element_text(angle=0, size=10, vjust=0.5),
    axis.title=element_text(size=12),
    legend.key=element_blank(),     #removes the border
    legend.key.size=unit(1, "cm"),      #Sets overall area/size of the legend
    legend.text=element_text(size=12),  #Text size
    title=element_text(size=12)) +
  guides(colour=guide_legend(override.aes=list(size=2.5))) +
  coord_flip()

cluster_1_plot
