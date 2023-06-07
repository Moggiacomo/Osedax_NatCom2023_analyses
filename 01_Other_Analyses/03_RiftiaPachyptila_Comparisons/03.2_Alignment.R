library(pafr)
library(ggplot2)
## Loading required package: ggplot2
path_to_alignment <- system.file("extdata", "/Users/giacomo/Desktop/alignment_riftia_OUR_VS_oliveira2022/alignment_riftia_OUR_VS_oliveira_2022.paf", package = "pafr")
ali <- read_paf(path_to_alignment)
dotplot(ali)

ali <- read_paf("/Users/giacomo/Desktop/alignment_riftia_OUR_VS_oliveira2022/alignment_riftia_OUR_VS_oliveira_2022.paf")
prim_alignment <- filter_secondary_alignments(ali)
long_ali <- subset(prim_alignment, alen > 1e4 & mapq > 40)

over_N50_ali <- subset(long_ali, qlen > 1423584, tlen > 2870320)

# to select just the sequences equal or over N50 size in shell:
# awk -F "\t" '{ if(($2 >= 1423584) && ($7 >= 2870320)) { print } }' alignment_riftia_OUR_VS_oliveira_2022.paf > overN50_alignment_riftia_OUR_VS_oliveira_2022.paf


overN50_ali <- read_paf("/Users/giacomo/Desktop/alignment_riftia_OUR_VS_oliveira2022/overN50_alignment_riftia_OUR_VS_oliveira_2022.paf")
overN50_prim_alignment <- filter_secondary_alignments(overN50_ali)
overN50_long_ali <- subset(overN50_prim_alignment, alen > 1e4 & mapq > 40)
dotplot(overN50_long_ali)
