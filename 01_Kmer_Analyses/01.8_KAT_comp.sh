#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 20
#$ -l h_vmem=10G
#$ -l h_rt=24:0:0
#$ -l highmem

species=$1
purged="$species".fa

echo "Working on "$species

module load anaconda3
conda activate KAT

cd /data/scratch/btx654/btx604-scratch/$species/kmer_Dec2020/kat

kat comp -m 21 -p pdf -o 21mer_vs_assembly -v -t 20 '../*_R1.fq ../*_R2.fq' ../$purged
