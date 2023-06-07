#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 8
#$ -l h_vmem=1G
#$ -l h_rt=36:0:0

species=$1

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step8/

module load anaconda3
conda activate /data/SBCS-MartinDuranLab/03-Giacomo/src/anaconda3/trinotate_env

blastp -query input_trinotate_proteins.fa -db /data/SBCS-MartinDuranLab/03-Giacomo/db/trinotate/uniprot_sprot.pep -num_threads 8 -max_target_seqs 1 -outfmt 6 -evalue 1e-3 > blastp.outfmt6
