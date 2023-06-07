#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=4G
#$ -l h_rt=24:0:0

species=$1
mikado_transcripts="$species"_mikado_transcripts_NoncRNA.fa

echo "Working on "$species

module load anaconda3
source activate pasa

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5

/data/home/btx654/.conda/envs/pasa/opt/pasa-2.4.1/bin/seqclean $mikado_transcripts
