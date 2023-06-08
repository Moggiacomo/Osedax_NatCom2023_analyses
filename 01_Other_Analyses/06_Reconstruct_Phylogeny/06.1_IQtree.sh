#!/bin/bash
#$ -pe smp 20
#$ -l highmem
#$ -l h_vmem=20G
#$ -l h_rt=240:0:0
#$ -cwd
#$ -j y

module load anaconda3
conda activate /data/SBCS-MartinDuranLab/03-Giacomo/src/anaconda3/IQtree_env

iqtree -s MMPs_sequences_trimal_ok.fas -m MFP -B 1000
