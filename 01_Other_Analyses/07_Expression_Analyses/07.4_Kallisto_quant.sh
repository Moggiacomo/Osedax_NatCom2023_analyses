#!/bin/bash
#$ -pe smp 2
#$ -l highmem
#$ -l h_vmem=30G
#$ -l h_rt=100:0:0
#$ -wd /data/scratch/btx654/RNAseq/oasisia/kallisto
#$ -o /data/scratch/btx654/RNAseq/oasisia/kallisto
#$ -j y
#$ -t 1-6

module load anaconda3
conda activate kallisto_env

kallisto quant -i oasisia_mRNA.idx -o oasisia_"${SGE_TASK_ID}"_mapping ../trimmomatic/"${SGE_TASK_ID}"_1_paired.fastq.gz ../trimmomatic/"${SGE_TASK_ID}"_2_paired.fastq.gz
