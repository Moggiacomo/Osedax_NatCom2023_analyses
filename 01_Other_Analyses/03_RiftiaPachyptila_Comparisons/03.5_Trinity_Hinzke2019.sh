#!/bin/bash
#$ -wd /data/scratch/btx654/riftia_hinzke_2019
#$ -j y
#$ -o /data/scratch/btx654/riftia_hinzke_2019
#$ -pe smp 20
#$ -l h_vmem=20G
#$ -l h_rt=240:0:0
#$ -l highmem

input=$1
R1="$input"_1.fastq
R2="$input"_2.fastq
output="$input"_trinity

module load anaconda3
source activate Trinity_env

Trinity \
 --seqType fq \
 --left $R1 \
 --right $R2 \
 --SS_lib_type RF \
 --max_memory 400G \
 --CPU 20 \
 --output $output \
 --full_cleanup \
 --trimmomatic  
 
 
if [ -f "$output".Trinity.fasta ]
then
    if [ -s "$output".Trinity.fasta ]
    then
        echo $output".Trinity.fasta exists and not empty"
    else
        echo $output".Trinity.fasta exists but empty"
    fi
else
    echo $output".Trinity.fasta not exists"
fi
