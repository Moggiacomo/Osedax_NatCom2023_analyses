#!/bin/bash
#$ -wd /data/scratch/btx654/RNAseq/Oasisia
#$ -o /data/scratch/btx654/RNAseq/Oasisa
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=6G
#$ -l h_rt=24:0:0
#$ -t 1-6

sample_name=${SGE_TASK_ID}
sample_R1="$sample_name"_1.fastq.gz
sample_R2="$sample_name"_2.fastq.gz
R1_paired="$sample_name"_1_paired.fastq.gz
R1_unpaired="$sample_name"_1_unpaired.fastq.gz
R2_paired="$sample_name"_2_paired.fastq.gz
R2_unpaired="$sample_name"_2_unpaired.fastq.gz

trim_log=trim_"$sample_name"
log="$sample_name".log

module load anaconda3
conda activate trimmomatic_env

mkdir -p trimmomatic
cd trimmomatic

trimmomatic PE -threads 4 -phred33 -trimlog $trim_log ../$sample_R1 ../$sample_R2 $R1_paired $R1_unpaired $R2_paired $R2_unpaired ILLUMINACLIP:/data/home/btx654/.conda/envs/trimmomatic_env/share/trimmomatic-0.39-2/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:28 TRAILING:28 SLIDINGWINDOW:4:15 MAXINFO:40:0.5 MINLEN:36 > $log 2>&1
