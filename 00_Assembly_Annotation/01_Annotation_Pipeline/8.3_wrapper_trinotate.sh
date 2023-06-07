#!/bin/bash
#$ -wd /data/home/btx654/scripts/annotation/New_annotation_Dec2020/step8/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=1G
#$ -l h_rt=1:0:0

species=$1

echo "Working on "$species

qsub 8.A_BLASTp_universal.sh $species
qsub 8.B_BLASTx_universal.sh $species
qsub 8.C_HMMER_universal.sh $species
qsub 8.D_Signalp_universal.sh $species
