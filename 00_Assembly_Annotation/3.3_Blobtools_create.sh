#!/bin/bash
#$ -wd /data/scratch/btx604/oasisia/blobtools/nt_v5
#$ -o /data/scratch/btx604/oasisia/blobtools/nt_v5
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0

module load anaconda2
source activate blobtools

cd /data/scratch/btx604/oasisia/blobtools/nt_v5

blobtools create \
 -i /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta \
 -b /data/scratch/btx604/oasisia/genomePolishing/illumina/blobtools/oasisia_sorted_step1.bam \
 -t /data/scratch/btx604/oasisia/blobtools/nt_v5/blast.out \
 -t /data/scratch/btx604/oasisia/blobtools/diamond.out \
 -o /data/scratch/btx604/oasisia/blobtools/nt_v5/oasisia_blobplot
