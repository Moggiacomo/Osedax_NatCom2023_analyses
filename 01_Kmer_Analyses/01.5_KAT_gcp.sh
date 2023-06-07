#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 20
#$ -l h_vmem=10G
#$ -l h_rt=24:0:0
#$ -l highmem

species=$1
R1_nonBacteria=illumina_R1_mapped_samtools.fq
R2_nonBacteria=illumina_R2_mapped_samtools.fq

cd /data/scratch/btx654/btx604-scratch/$species/kraken2/pacbio_illumina
mkdir -p kat
cd kat

module load anaconda3
conda activate KAT

kat gcp -m 31 -p pdf -v -t 20 ../$R1_nonBacteria ../$R2_nonBacteria
