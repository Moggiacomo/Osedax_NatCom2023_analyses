#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -pe smp 5
#$ -l h_vmem=5G
#$ -j y
#$ -l h_rt=12:0:0

species=$1
sample_name=$2
trimmomatic_directory=trimmomatic_"$sample_name"
R1_paired="$sample_name"_1_paired.fastq.gz
R2_paired="$sample_name"_2_paired.fastq.gz
prefix="$species"_"$sample_name"_STAR_
output_STAR="$prefix"Aligned.sortedByCoord.out.bam
output_stringtie="$species"_"$sample_name"_transcripts.gtf

echo "Working on "$1" using "$2

module load anaconda3
source activate STAR

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/STAR
cp /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/trimmomatic/$trimmomatic_directory/$R1_paired ./
cp /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/trimmomatic/$trimmomatic_directory/$R2_paired ./

# Build STAR genome index and align the reads generating a BAM sorted by coordinate, and a stranded wiggle file to visualise the RNA-seq
STAR --runThreadN 5 --genomeDir /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/STAR/ --readFilesCommand zcat --readFilesIn $R1_paired $R2_paired --outSAMtype BAM SortedByCoordinate --outWigType wiggle --outWigStrand Stranded --outFileNamePrefix $prefix

# Assemble a GTF file from the BAM file
stringtie $output_STAR -p 5 -o $output_stringtie -v
