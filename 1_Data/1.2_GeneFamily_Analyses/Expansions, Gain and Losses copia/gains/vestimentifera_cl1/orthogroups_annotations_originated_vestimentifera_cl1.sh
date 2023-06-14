#!/bin/bash
#$ -wd /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/gains/vestimentifera_cl1
#$ -o /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/gains/vestimentifera_cl1
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=100G
#$ -l h_rt=140:00:0
#$ -l highmem

cut -f 1,4 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep -w Vestimentifera_cl1 | cut -f 1 > gene_families_originated_vestimentifera_cl1.txt #families originated in oasisia
fgrep -f gene_families_originated_vestimentifera_cl1.txt ../../Orthogroups.csv > gene_families_originated_vestimentifera_cl1.csv

cut -f 1,19 gene_families_originated_vestimentifera_cl1.csv > orthogroups_gene_IDs_originated_vestimentifera_cl1_oasisia.txt
sed 's/Oalv|//g' orthogroups_gene_IDs_originated_vestimentifera_cl1_oasisia.txt > orthogroups_gene_IDs_originated_vestimentifera_cl1_oasisia_OK.txt
cut -f 1,24 gene_families_originated_vestimentifera_cl1.csv > orthogroups_gene_IDs_originated_vestimentifera_cl1_riftia.txt
sed 's/Rpac|//g' orthogroups_gene_IDs_originated_vestimentifera_cl1_riftia.txt > orthogroups_gene_IDs_originated_vestimentifera_cl1_riftia_OK.txt
cut -f 1,23 gene_families_originated_vestimentifera_cl1.csv > orthogroups_gene_IDs_originated_vestimentifera_cl1_paraescarpia.txt
sed 's/Pech|//g' orthogroups_gene_IDs_originated_vestimentifera_cl1_paraescarpia.txt > orthogroups_gene_IDs_originated_vestimentifera_cl1_paraescarpia_OK.txt


while read line; do
   genes=$(cut -f 2 <<< "$line")
   echo $genes
   orthogroup_ID=$(cut -f 1 <<< "$line")
   echo $orthogroup_ID
     if [[ "$genes" == OALV* ]]
     then
      IFS=', '     # space is set as delimiter
      read -ra ADDR <<< "$genes"   # str is read into an array as tokens separated by IFS
      for gene in "${ADDR[@]}"; do
       annotations=$(cut -f 13,14,15,18,20,24 ../../oasisia_annotation_Jan2021_TrinoPantherKO.xls | fgrep $gene)
        echo $orthogroup_ID$'\t'"oasisia"$'\t'$annotations >> orthogroups_annotations_originated_vestimentifera_cl1_oasisia.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_originated_vestimentifera_cl1_oasisia.csv
     fi
done < orthogroups_gene_IDs_originated_vestimentifera_cl1_oasisia_OK.txt

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
        echo $orthogroup_ID$'\t'"riftia"$'\t'$annotations >> orthogroups_annotations_originated_vestimentifera_cl1_riftia.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_originated_vestimentifera_cl1_riftia.csv
     fi
done < orthogroups_gene_IDs_originated_vestimentifera_cl1_riftia_OK.txt

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
        echo $orthogroup_ID$'\t'"paraescarpia"$'\t'$annotations >> orthogroups_annotations_originated_vestimentifera_cl1_paraescarpia.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_originated_vestimentifera_cl1_paraescarpia.csv
     fi
done < orthogroups_gene_IDs_originated_vestimentifera_cl1_paraescarpia_OK.txt

echo "Orthogroup"$'\t'"Species"$'\t'"GO_term1"$'\t'"GO_term2"$'\t'"GO_term3"$'\t'"gene_ID"$'\t'"Panther_annotation"$'\t'"KEGG_number" > orthogroups_annotations_originated_vestimentifera_cl1_Oalv_Rpac_Pech.csv
cat orthogroups_annotations_originated_vestimentifera_cl1_oasisia.csv orthogroups_annotations_originated_vestimentifera_cl1_riftia.csv orthogroups_annotations_originated_vestimentifera_cl1_paraescarpia.csv >> 
orthogroups_annotations_originated_vestimentifera_cl1_Oalv_Rpac_Pech.csv
sort orthogroups_annotations_originated_vestimentifera_cl1_Oalv_Rpac_Pech.csv > orthogroups_annotations_originated_vestimentifera_cl1_Oalv_Rpac_Pech_OK.csv

echo "Orthogroup"$'\t'"Panther_annotation" > orthogroups_mostAbundantAnnotation_originated_vestimentifera_cl1.csv
while read line; do
   orthogroup_ID=$(cut -f 1 <<< "$line")
   annotation=$(fgrep $orthogroup_ID orthogroups_annotations_originated_vestimentifera_cl1_Oalv_Rpac_Pech_OK.csv | cut -f 7 | sed '/^$/d' | sort |  uniq -c | sort -r | awk '{$1=""; print $0}' | head -1)
        echo $orthogroup_ID$'\t'$annotation >> orthogroups_mostAbundantAnnotation_originated_vestimentifera_cl1.csv
done < gene_families_originated_vestimentifera_cl1.csv
