#!/bin/bash
#$ -cwd 
#$ -pe smp 4
#$ -l h_vmem=2G
#$ -l h_rt=10:0:0
#$ -j y

module load anaconda2
source activate quast

quast \
 Oasisia.contigs.fasta \
 -o quast_canu \
 --eukaryote \
