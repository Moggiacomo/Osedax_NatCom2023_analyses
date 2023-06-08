#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 8
#$ -l h_vmem=10G
#$ -l h_rt=120:0:0
#$ -l highmem

#53 different Panther IDs found in Oasisia belonging to the missing Busco in osedax
grep -f panther_ids_list /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/New_annotation_Dec2020/step9/oasisia_annotation_Jan2021_TrinoPantherKO.xls | cut -f 19 | sort | uniq | wc -l 
cut -f 18,19 /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/New_annotation_Dec2020/step9/oasisia_annotation_Jan2021_TrinoPantherKO.xls | grep -f panther_ids_list | sort -u -k2,2 | cut -f 1 > oasisia_geneIDs_missingBUSCO_osedax.txt

module load seqtk
seqtk subseq /data/SBCS-MartinDuranLab/03-Giacomo/NR_proteomes/Oalv.fa oasisia_geneIDs_missingBUSCO_osedax_OK.txt > oasisia_proteins_missingBUSCO_osedax.fa

module load blast+

blastp -db ../../BLAST/osedax_prot -query oasisia_proteins_missingBUSCO_osedax.fa -out Oalv_VS_Ofra_missingBUSCO_blastp_out -max_target_seqs 5 -evalue 1e-10 -num_threads 8 -outfmt 6
blastp -db ../../BLAST/osedax_prot -query oasisia_proteins_missingBUSCO_osedax.fa -out Oalv_VS_Ofra_missingBUSCO_blastp_out.html -max_target_seqs 5 -evalue 1e-10 -num_threads 8 -html
