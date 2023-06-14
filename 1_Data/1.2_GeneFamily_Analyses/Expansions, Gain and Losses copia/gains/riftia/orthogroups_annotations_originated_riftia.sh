#!/bin/bash
#$ -wd /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/gains/riftia
#$ -o /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/gains/riftia
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=100G
#$ -l h_rt=72:00:0
#$ -l highmem

cut -f 1,4 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep -w Rpac | cut -f 1 > gene_families_originated_riftia.txt #families originated in riftia
fgrep -f gene_families_originated_riftia.txt ../../Orthogroups.csv > gene_families_originated_riftia.csv

cut -f 1,24 gene_families_originated_riftia.csv > orthogroups_gene_IDs_originated_riftia.txt
sed 's/Rpac|//g' orthogroups_gene_IDs_originated_riftia.txt > orthogroups_gene_IDs_originated_riftia_OK.txt

echo "Orthogroup"$'\t'"Species"$'\t'"GO_term1"$'\t'"GO_term2"$'\t'"GO_term3"$'\t'"gene_ID"$'\t'"Panther_annotation"$'\t'"KEGG_number" > orthogroups_annotations_originated_riftia.csv
while read line; do
   genes=$(cut -f 2 <<< "$line")
   echo $genes
   orthogroup_ID=$(cut -f 1 <<< "$line")
   echo $orthogroup_ID
     if [[ "$genes" == RPAC* ]]
     then
      IFS=', '     # space is set as delimiter
      read -ra ADDR <<< "$genes"   # str is read into an array as tokens separated by IFS
      for gene in "${ADDR[@]}"; do
       annotations=$(cut -f 13,14,15,18,20,24 ../../riftia_annotation_Jan2021_TrinoPantherKO.xls | fgrep $gene)
        echo $orthogroup_ID$'\t'"riftia"$'\t'$annotations >> orthogroups_annotations_originated_riftia.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_originated_riftia.csv
     fi
done < orthogroups_gene_IDs_originated_riftia_OK.txt

echo "Orthogroup"$'\t'"Panther_annotation" > orthogroups_mostAbundantAnnotation_originated_riftia.csv
while read line; do
   orthogroup_ID=$(cut -f 1 <<< "$line")
   annotation=$(fgrep $orthogroup_ID orthogroups_annotations_originated_riftia.csv | cut -f 7 | sort |  uniq -c | sort -r | awk '{$1=""; print $0}' | head -1)
        echo $orthogroup_ID$'\t'$annotation >> orthogroups_mostAbundantAnnotation_originated_riftia.csv
done < gene_families_originated_riftia.csv
