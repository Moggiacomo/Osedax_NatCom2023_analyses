#!/bin/bash
#$ -pe smp 2
#$ -l highmem
#$ -l h_vmem=5G
#$ -l h_rt=10:0:0
#$ -wd /data/scratch/btx654/RNAseq
#$ -o /data/scratch/btx654/RNAseq
#$ -j y

species=$1
output="$species"_mRNA.idx
input="$species"_mRNA.fa

module load anaconda3
conda activate kallisto_env

cd /data/scratch/btx654/RNAseq/$species/kallisto

kallisto index -i $output $input
