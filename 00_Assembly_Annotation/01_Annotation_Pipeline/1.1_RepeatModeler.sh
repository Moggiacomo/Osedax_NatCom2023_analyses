#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 20
#$ -l h_vmem=20G
#$ -l h_rt=240:0:0
#$ -l highmem

#first of all let’s change the contigs names to something more tolerated by the softwares
cp oasisia_purged_Nov2020.fa /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1
sed -e 's/.arrow.arrow.pilon.pilon//' -i oasisia_purged_Nov2020.fa

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1

module load anaconda2
source activate Repeats_env

# Build a genomic database and run RepeatModeler to generate a Owenia-specific. The database is built using BLAST (ncbi flag).
BuildDatabase -name oasisia -engine ncbi oasisia_purged_Nov2020.fa
RepeatModeler -engine ncbi -pa 8 -database oasisia
