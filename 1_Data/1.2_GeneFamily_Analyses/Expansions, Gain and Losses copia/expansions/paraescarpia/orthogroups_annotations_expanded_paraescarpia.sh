
#!/bin/bash
#$ -wd /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/expansions/paraescarpia
#$ -o /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/expansions/paraescarpia
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=100G
#$ -l h_rt=72:00:0
#$ -l highmem

cut -f 1,7 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep Pech | cut -f 1 > gene_families_expanded_paraescarpia.txt #families expanded in riftia
fgrep -f gene_families_expanded_paraescarpia.txt ../../Orthogroups.csv > gene_families_expanded_paraescarpia.csv

cut -f 1,23 gene_families_expanded_paraescarpia.csv > orthogroups_gene_IDs_expanded_paraescarpia.txt
sed 's/Pech|//g' orthogroups_gene_IDs_expanded_paraescarpia.txt > orthogroups_gene_IDs_expanded_paraescarpia_OK.txt

echo "Orthogroup"$'\t'"Species"$'\t'"GO_term1"$'\t'"GO_term2"$'\t'"GO_term3"$'\t'"gene_ID"$'\t'"Panther_annotation"$'\t'"KEGG_number" > orthogroups_annotations_expanded_paraescarpia.csv
while read line; do
   genes=$(cut -f 2 <<< "$line")
   echo $genes
   orthogroup_ID=$(cut -f 1 <<< "$line")
   echo $orthogroup_ID
     if [[ "$genes" == nbis* ]]
     then
      IFS=', '     # space is set as delimiter
      read -ra ADDR <<< "$genes"   # str is read into an array as tokens separated by IFS
      for gene in "${ADDR[@]}"; do
       annotations=$(cut -f 13,14,15,18,20,24 ../../paraescarpia_annotation_Jun2021_TrinoPantherKO.xls | fgrep $gene)
        echo $orthogroup_ID$'\t'"paraescarpia"$'\t'$annotations >> orthogroups_annotations_expanded_paraescarpia.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_expanded_paraescarpia.csv
     fi
done < orthogroups_gene_IDs_expanded_paraescarpia_OK.txt

echo "Orthogroup"$'\t'"Panther_annotation" > orthogroups_mostAbundantAnnotation_expanded_paraescarpia.csv
while read line; do
   orthogroup_ID=$(cut -f 1 <<< "$line")
   annotation=$(fgrep $orthogroup_ID orthogroups_annotations_expanded_paraescarpia.csv | cut -f 7 | sort |  uniq -c | sort -r | awk '{$1=""; print $0}' | head -1)
        echo $orthogroup_ID$'\t'$annotation >> orthogroups_mostAbundantAnnotation_expanded_paraescarpia.csv
done < gene_families_expanded_paraescarpia.csv
