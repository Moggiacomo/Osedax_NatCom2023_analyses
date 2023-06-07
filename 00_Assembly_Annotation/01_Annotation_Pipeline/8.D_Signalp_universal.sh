#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=8G
#$ -l h_rt=36:0:0

species=$1

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step8/

module load perl

/data/SBCS-MartinDuranLab/03-Giacomo/src/signalp-4.1/signalp -f short -n signalp.out input_trinotate_proteins.fa
