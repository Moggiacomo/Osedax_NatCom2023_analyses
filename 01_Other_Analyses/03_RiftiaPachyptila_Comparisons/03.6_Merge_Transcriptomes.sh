#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 20
#$ -l h_vmem=20G
#$ -l h_rt=240:0:0
#$ -l highmem

cat SRR8949056_trinity.Trinity.fasta SRR8949057_trinity.Trinity.fasta SRR8949058_trinity.Trinity.fasta SRR8949059_trinity.Trinity.fasta SRR8949060_trinity.Trinity.fasta SRR8949061_trinity.Trinity.fasta SRR8949062_trinity.Trinity.fasta SRR8949063_trinity.Trinity.fasta SRR8949064_trinity.Trinity.fasta SRR8949065_trinity.Trinity.fasta SRR8949066_trinity.Trinity.fasta SRR8949067_trinity.Trinity.fasta SRR8949068_trinity.Trinity.fasta SRR8949069_trinity.Trinity.fasta SRR8949070_trinity.Trinity.fasta SRR8949071_trinity.Trinity.fasta SRR8949072_trinity.Trinity.fasta SRR8949073_trinity.Trinity.fasta SRR8949074_trinity.Trinity.fasta SRR8949075_trinity.Trinity.fasta SRR8949076_trinity.Trinity.fasta SRR8949077_trinity.Trinity.fasta > combined_trinity.Trinity.fasta

/data/SBCS-MartinDuranLab/02-Chema/src/cdhit/cd-hit-est -i combined_trinity.Trinity.fasta -o cdhit_90similarity -M 380000 -T 20
