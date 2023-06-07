#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -l highmem
#$ -pe smp 12
#$ -l h_vmem=40G
#$ -l h_rt=36:0:0
#$ -l highmem

species=$1

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step8/

module load anaconda3
conda activate /data/SBCS-MartinDuranLab/03-Giacomo/src/anaconda3/trinotate_env

hmmscan --cpu 12 --domtblout PFAM.out /data/SBCS-MartinDuranLab/03-Giacomo/db/trinotate/Pfam-A.hmm input_trinotate_proteins.fa > pfam.log

#if the script crash try to divide input into chunks
