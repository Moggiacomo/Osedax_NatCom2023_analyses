#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 8
#$ -l h_vmem=18G
#$ -l h_rt=72:0:0
#$ -l highmem

species_unmasked=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1/oasisia_purged_Nov2020.fa

module load anaconda3
source activate Repeats_env3

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1
mkdir repeatmasker
cp $species_unmasked ./repeatmasker/
cd RM*
cp consensi.fa.classified ../repeatmasker/
cd ../repeatmasker

# Run RepeatMasker employing the filtered consensus repeats
RepeatMasker -e ncbi -pa 8 -xsmall -gff -a -lib consensi.fa.classified oasisia_purged_Nov2020.fa
