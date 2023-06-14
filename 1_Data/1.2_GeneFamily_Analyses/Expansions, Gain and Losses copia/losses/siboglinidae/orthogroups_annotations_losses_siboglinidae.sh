#!/bin/bash
#$ -wd /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/losses/siboglinidae
#$ -o /data/scratch/btx654/gene_family_evolution/ferdi_script/Jul2021/losses/siboglinidae
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=100G
#$ -l h_rt=140:00:0
#$ -l highmem

cut -f 1,6 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep -w Siboglinidae | cut -f 1 > gene_families_losses_siboglinidae.txt #families losses in oasisia
fgrep -f gene_families_losses_siboglinidae.txt ../../Orthogroups.csv > gene_families_losses_siboglinidae.csv

cut -f 1,21 gene_families_losses_siboglinidae.csv > orthogroups_gene_IDs_losses_siboglinidae_owenia.txt
sed 's/Ofus|//g' orthogroups_gene_IDs_losses_siboglinidae_owenia.txt > orthogroups_gene_IDs_losses_siboglinidae_owenia_OK.txt
cut -f 1,5 gene_families_losses_siboglinidae.csv > orthogroups_gene_IDs_losses_siboglinidae_capitella.txt
sed 's/Ctel|//g' orthogroups_gene_IDs_losses_siboglinidae_capitella.txt > orthogroups_gene_IDs_losses_siboglinidae_capitella_OK.txt

while read line; do
   genes=$(cut -f 2 <<< "$line")
   echo $genes
   orthogroup_ID=$(cut -f 1 <<< "$line")
   echo $orthogroup_ID
     if [[ "$genes" == OFUS* ]]
     then
      IFS=', '     # space is set as delimiter
      read -ra ADDR <<< "$genes"   # str is read into an array as tokens separated by IFS
      for gene in "${ADDR[@]}"; do
        cut -f 1,2,3,11,12,13 ../../Owenia_annotation_v250920.1_TrinoPantherKO.xls | fgrep $gene > temp_file.txt
        #K0_number=$(cut -f 1 temp_file.txt)
        #gene_ID=$(cut -f 2 temp_file.txt)
        #Panther_annotation=$(cut -f 3 temp_file.txt)
        #GO_1=$(cut -f 4 temp_file.txt)
        #GO_1=$(cut -f 5 temp_file.txt)
        #GO_1=$(cut -f 6 temp_file.txt)
        echo $orthogroup_ID$'\t'"owenia"$'\t'$(cut -f 4 temp_file.txt)$'\t'$(cut -f 5 temp_file.txt)$'\t'$(cut -f 6 temp_file.txt)$'\t'$(cut -f 2 temp_file.txt)$'\t'$(cut -f 3 temp_file.txt)$'\t'$(cut -f 1 temp_file.txt) >> orthogroups_annotations_losses_siboglinidae_owenia.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_losses_siboglinidae_owenia.csv
     fi
done < orthogroups_gene_IDs_losses_siboglinidae_owenia_OK.txt

while read line; do
   genes=$(cut -f 2 <<< "$line")
   echo $genes
   orthogroup_ID=$(cut -f 1 <<< "$line")
   echo $orthogroup_ID
     if [[ "$genes" == CapteT* ]]
     then
      IFS=', '     # space is set as delimiter
      read -ra ADDR <<< "$genes"   # str is read into an array as tokens separated by IFS
      for gene in "${ADDR[@]}"; do
       cut -f 1,3,7,21,22 ../../Capitella_annotation_Feb2021_TrinoPantherKO.xls | fgrep $gene > temp_file.txt
        #K0_number=$(cut -f 7 temp_file.txt)
        #gene_ID=$(cut -f 1 temp_file.txt)
        #Panther_annotation=$(cut -f 3 temp_file.txt)
        #GO_1=$(cut -f 21 temp_file.txt)
        #GO_1=$(cut -f 22 temp_file.txt)
        #GO_1=$(cut -f 6 temp_file.txt) NONE
        echo $orthogroup_ID$'\t'"capitella"$'\t'$(cut -f 21 temp_file.txt)$'\t'$(cut -f 22 temp_file.txt)$'\t'""'\t'$(cut -f 1 temp_file.txt)$'\t'$(cut -f 3 temp_file.txt)$'\t'$(cut -f 7 temp_file.txt) >> orthogroups_annotations_losses_siboglinidae_capitella.csv
        done
     else
     echo $orthogroup_ID$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'""$'\t'"" >> orthogroups_annotations_losses_siboglinidae_capitella.csv
     fi
done < orthogroups_gene_IDs_losses_siboglinidae_capitella_OK.txt


echo "Orthogroup"$'\t'"Species"$'\t'"GO_term1"$'\t'"GO_term2"$'\t'"GO_term3"$'\t'"gene_ID"$'\t'"Panther_annotation"$'\t'"KEGG_number" > orthogroups_annotations_losses_siboglinidae_Ofus_Ctel.csv
cat orthogroups_annotations_losses_siboglinidae_owenia.csv orthogroups_annotations_losses_siboglinidae_capitella.csv >> orthogroups_annotations_losses_siboglinidae_Ofus_Ctel.csv
sort orthogroups_annotations_losses_siboglinidae_Ofus_Ctel.csv > orthogroups_annotations_losses_siboglinidae_Ofus_Ctel_OK.csv

echo "Orthogroup"$'\t'"Panther_annotation" > orthogroups_mostAbundantAnnotation_losses_siboglinidae.csv
while read line; do
   orthogroup_ID=$(cut -f 1 <<< "$line")
   annotation=$(fgrep $orthogroup_ID orthogroups_annotations_losses_siboglinidae_Ofus_Ctel_OK.csv | cut -f 7 | sed '/^$/d' | sort |  uniq -c | sort -r | awk '{$1=""; print $0}' | head -1)
        echo $orthogroup_ID$'\t'$annotation >> orthogroups_mostAbundantAnnotation_losses_siboglinidae.csv
done < gene_families_losses_siboglinidae.csv
