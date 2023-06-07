#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=6:0:0

species=$1
R1=illumina_R1_nonBacteria_kraken2.fq
R2=illumina_R2_nonBacteria_kraken2.fq
R1_cleaned="$species"_R1.fq
R2_cleaned="$species"_R2.fq

cd /data/scratch/btx654/btx604-scratch/$species/kmer_Dec2020/

module load anaconda3
conda activate fastp

fastp -i $R1 -I $R2 -o $R1_cleaned -O $R2_cleaned -w 4
