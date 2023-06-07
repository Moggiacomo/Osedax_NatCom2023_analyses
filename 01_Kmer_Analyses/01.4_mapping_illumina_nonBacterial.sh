#!/bin/bash
#$ -wd /data/scratch/btx654
#$ -j y
#$ -o /data/scratch/btx654
#$ -pe smp 20
#$ -l h_vmem=34G
#$ -l h_rt=72:0:0
#$ -l highmem

species=$1
#bwa index step1 variables
pacbio_corrected_nonBacteria="$species"_nonBacteria_pacbio_corrected_bbmap.fasta
bwa_prefix="$species"_nonBacteria_pacbio_corrected_bbmap.fasta
#bwa mem step1 variables
R1_cleaned="$species"_R1_cleaned.fastq.gz
R2_cleaned="$species"_R2_cleaned.fastq.gz
alignment_sam="$species"_alignment_HIGHmem.sam
#samtools view step1 variables
alignment_bam="$1"_alignment_HIGHmem.bam
#samtools sort index step1 variables
alignment_sorted="$species"_sorted_HIGHmem.bam
alignment_mapped="$species"_sorted_mapped_HIGHmem.bam
alignment_mapped_sorted="$species"_sorted_mapped_sorted_HIGHmem.bam
R1_mapped="$species"_R1_mapped_HIGHmem.fastq
R2_mapped="$species"_R2_mapped_HIGHmem.fastq

module load bwa
module load samtools/1.9

cd /data/scratch/btx654/btx604-scratch/$species/kraken2/pacbio_illumina

echo 'BWA INDEX STEP1________________________________________________________________'
if [ -e /data/scratch/btx654/btx604-scratch/$species/kraken2/pacbio_illumina/*.ann ]
then
  echo "/data/scratch/btx654/btx604-scratch/$species/kraken2/pacbio_illumina/*.ann found."
else
  bwa index -p $bwa_prefix -a bwtsw $pacbio_corrected_nonBacteria
fi

echo 'BWA MEM STEP1__________________________________________________________________'
bwa mem -t 20 -M $pacbio_corrected_nonBacteria $R1_cleaned $R2_cleaned > $alignment_sam

samtools view -@ 20 -S -b -h $alignment_sam -o $alignment_bam
samtools sort -@ 20 $alignment_bam -o $alignment_sorted
samtools index $alignment_sorted
samtools view -@ 20 -b -F 4 $alignment_sorted > $alignment_mapped
samtools sort -@ 20 -n $alignment_mapped -o $alignment_mapped_sorted
samtools fastq -1 illumina_R1_mapped_samtools.fq -2 illumina_R2_mapped_samtools.fq -n $alignment_mapped_sorted
