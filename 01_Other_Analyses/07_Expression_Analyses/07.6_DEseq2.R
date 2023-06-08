#!/usr/bin/env Rscript
library(tximport)
library(DESeq2)
library(rhdf5)

dir <- "/data/scratch/btx654/RNAseq/oasisia/kallisto"
setwd(dir)

#"oasisia_samples.txt" looks like this:
#| names         | tissue     | replicate | folder            |
#| ------------- | ---------- | --------- | ----------------- |
#| crown_R1      | crown      | 1         | oasisia_1_mapping |
#| opistosoma_R1 | opistosoma | 1         | oasisia_2_mapping |
#| trophosome_R1 | trophosome | 1         | oasisia_3_mapping |
#| crown_R2      | crown      | 2         | oasisia_4_mapping |
#| opistosoma_R2 | opistosoma | 2         | oasisia_5_mapping |
#| trophosome_R2 | trophosome | 2         | oasisia_6_mapping |



oasisia_samples <- read.table(file.path(dir, "oasisia_samples.txt"), header = TRUE)
files_oasisia <- file.path(dir, oasisia_samples$folder, "abundance.h5")
all(file.exists(files_oasisia))
#names(files_oasisia) <- samples_27$names
tximport_kallisto <- tximport(files_oasisia, type = "kallisto", txOut = TRUE)
head(tximport_kallisto$counts)


sampleTable <- data.frame(tissue = factor(c("crown","opistosoma","trophosome","crown","opistosoma","trophosome")),replicate = factor(c("1","1","1","2","2","2")))

dds_oasisia <- DESeqDataSetFromTximport(tximport_kallisto, sampleTable, design = ~ tissue+replicate)
rownames(sampleTable) <- colnames(tximport_kallisto$counts)
dds_oasisia_DEseq2 <- DESeq(dds_oasisia)
table_counts_normalized <- counts(dds_oasisia_DEseq2, normalized=TRUE)
write.table(table_counts_normalized,"oasisia_DEseq2_normalized_counts.kallisto.tsv",sep="\t")
