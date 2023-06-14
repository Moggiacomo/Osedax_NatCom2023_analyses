#!/bin/bash
#$ -wd /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/gains/lamellibrachia
#$ -o /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/gains/lamellibrachia
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=100G
#$ -l h_rt=72:00:0
#$ -l highmem

cut -f 1,4 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep -w Lluy | cut -f 1 > gene_families_originated_lamellibrachia.txt #families originated in riftia
fgrep -f gene_families_originated_lamellibrachia.txt ../../Orthogroups.csv > gene_families_originated_lamellibrachia.csv

cut -f 1,14 gene_families_originated_lamellibrachia.csv > orthogroups_gene_IDs_originated_lamellibrachia.txt
sed 's/Lluy|//g' orthogroups_gene_IDs_originated_lamellibrachia.txt > orthogroups_gene_IDs_originated_lamellibrachia_OK.txt

echo "Orthogroup"$'\t'"Species"$'\t'"GO_term1"$'\t'"GO_term2"$'\t'"GO_term3"$'\t'"gene_ID"$'\t'"Panther_annotation"$'\t'"KEGG_number" > orthogroups_annotations_originated_lamellibrachia.csv
while read line; do
   genes=$(cut -f 2 <<< "$line")
   echo $genes
   orthogroup_ID=$(cut -f 1 <<< "$line")
   echo $orthogroup_ID
     if [[ "$genes" == FUN* ]]
     then
      IFS=', '     # space is set as delimiter
      read -ra ADDR <<< "$genes"   # str is read into an array as tokens separated by IFS
      for gene in "${ADDR[@]}"; do
       annotations=$(cut -f 13,14,15,18,20,24 ../../lamellibrachia_annotation_Feb2021_TrinoPantherKO_OK.xls | fgrep $gene)
        echo $orthogroup_ID$'\t'"lamellibrachia"$'\t'$annotations >> orthogroups_annotations_originated_lamellibrachia.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_originated_lamellibrachia.csv
     fi
done < orthogroups_gene_IDs_originated_lamellibrachia_OK.txt

echo "Orthogroup"$'\t'"Panther_annotation" > orthogroups_mostAbundantAnnotation_originated_lamellibrachia.csv
while read line; do
   orthogroup_ID=$(cut -f 1 <<< "$line")
   annotation=$(fgrep $orthogroup_ID orthogroups_annotations_originated_lamellibrachia.csv | cut -f 7 | sort |  uniq -c | sort -r | awk '{$1=""; print $0}' | head -1)
        echo $orthogroup_ID$'\t'$annotation >> orthogroups_mostAbundantAnnotation_originated_lamellibrachia.csv
done < gene_families_originated_lamellibrachia.csv
