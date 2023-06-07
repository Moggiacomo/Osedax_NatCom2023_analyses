#!/bin/bash
#$ -cwd
#$ -j y
#$ -o cutadapt
#$ -pe smp 1
#$ -l h_vmem=12G
#$ -l h_rt=24:0:0

module load python/3.6.3
#remove adapters from raw illumina data
~/.local/bin/cutadapt \
 -a CTGTCTCTTATACACATCT \
 -A CTGTCTCTTATACACATCT \
 -m 30 \
 -q 15,10 \
 -o Oasisia_illumina_R1.fastq.gz \
 -p Oasisia_illumina_R2.fastq.gz \
 01-OasisiaData/OT_S71_L002_R1_001.fastq.gz \
 01-OasisiaData/OT_S71_L002_R2_001.fastq.gz
 
#quality check of the adapter trimmed illumina reads
module load  fastqc/0.11.5

fastqc Oasisia_illumina_R1.fastq.gz
fastqc Oasisia_illumina_R2.fastq.gz
