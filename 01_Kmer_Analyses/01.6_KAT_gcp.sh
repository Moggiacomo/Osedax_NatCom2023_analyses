#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 20
#$ -l h_vmem=10G
#$ -l h_rt=24:0:0
#$ -l highmem

species=$1
R1="$species"_R1.fq
R2="$species"_R2.fq

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/kmer_Dec2020/
mkdir -p kat
cd kat

module load anaconda3
conda activate KAT

kat gcp -m 21 -p pdf -v -t 20 ../$R1 ../$R2
