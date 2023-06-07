#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=3G
#$ -l h_rt=0:30:0

unmasked=oasisia_purged_Nov2020.fa
unmasked_original=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1/$unmasked

masked=oasisia_Nov2020_RepeatCraft.rmerge.gff
masked_original=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1/repeatcraft/$masked

output=oasisia_Nov2020_softmasked.fa

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1
mkdir softmasking
cd softmasking

# Load the application module
module load bedtools/2.26.0

# Copy required files into working directory
cp $unmasked_original ./
cp $masked_original ./

bedtools maskfasta -soft -fi $unmasked -bed $masked -fo $output
