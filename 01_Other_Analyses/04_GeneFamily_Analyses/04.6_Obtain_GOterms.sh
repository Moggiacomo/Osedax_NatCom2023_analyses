cd /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/GO_terms/riftia
# I will use BlastX GO terms
cut -f2,13 ../../riftia_annotation_Jan2021_TrinoPantherKO.xls | tail -n +2 > riftia_GO_raw.txt # 38179 genes in riftia_GO_raw.txt
grep 'GO' riftia_GO_raw.txt > riftia_GO_only_raw.txt # 20737 riftia_GO_only_raw.txt
