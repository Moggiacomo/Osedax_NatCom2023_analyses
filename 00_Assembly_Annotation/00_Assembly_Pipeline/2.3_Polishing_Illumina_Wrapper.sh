#!/bin/bash
#$ -cwd 
#$ -j y
#$ -o
#$ -pe smp 24
#$ -l h_vmem=30G
#$ -l h_rt=240:0:0
#$ -l highmem

#bwa index step1 variables
#$1 refers to the species name
reference_genome_step1_prefix="$1"_step2_consensus.fasta
reference_genome_step1=$1/genomePolishing/illumina/step1/$reference_genome_step1_prefix
#bwa mem step1 variables
R1=$1/genomePolishing/illumina/raw_reads/R1.fastq.gz
R2=$1/genomePolishing/illumina/raw_reads/R2.fastq.gz
alignment_step1_sam=$1/genomePolishing/illumina/step1/"$1"_alignment_step1.sam
#samtools view step1 variables
alignment_step1_bam=$1/genomePolishing/illumina/step1/"$1"_alignment_step1.bam
#samtools sort index step1 variables
alignment_step1_sorted=$1/genomePolishing/illumina/step1/"$1"_sorted_step1.bam
#pilon step1 variables
step1_pilon_prefix="$1"_pilon_step1
step1_pilon_fa=$1/genomePolishing/illumina/step1/"$1"_pilon_step1.fasta

#bwa index step2 variables
reference_genome_step2_prefix="$1"_pilon_step1.fasta
reference_genome_step2=$1/genomePolishing/illumina/step2/$reference_genome_step2_prefix
#bwa mem step2 variables
alignment_step2_sam=$1/genomePolishing/illumina/step2/"$1"_alignment_step2.sam
#samtools view step2 variables
alignment_step2_bam=$1/genomePolishing/illumina/step2/"$1"_alignment_step2.bam
#samtools sort index step2 variables
alignment_step2_sorted=$1/genomePolishing/illumina/step2/"$1"_sorted_step2.bam
#pilon step2 variables
step2_pilon_prefix="$1"_pilon_step2
step2_pilon_fa=$1/genomePolishing/illumina/step2/"$1"_pilon_step2.fasta

cd $1/genomePolishing/illumina/step1

module load bwa
module load samtools/1.9
module load anaconda2
source activate genomePolishing
source activate pilon

echo 'working on '$1

echo 'BWA INDEX STEP1________________________________________________________________'
if [ -e $1/genomePolishing/illumina/step1/*.ann ]
then
  echo "$1/genomePolishing/illumina/step1/*.ann found."
else
  bwa index -p $reference_genome_step1_prefix -a bwtsw $reference_genome_step1
fi

echo 'BWA MEM STEP1__________________________________________________________________'
if [ -e "$alignment_step1_sam" ]
then
  echo "$alignment_step1_sam found."
else
  bwa mem -t 24 -M $reference_genome_step1 $R1 $R2 > $alignment_step1_sam
fi

echo 'SAMTOOLS VIEW STEP1____________________________________________________________'
if [ -e "$alignment_step1_bam" ]
then
  echo "$alignment_step1_bam found."
else
  samtools view -S -b -h $alignment_step1_sam -o $alignment_step1_bam
fi

echo 'SAMTOOLS SORT INDEX STEP1______________________________________________________'
if [ -e "$alignment_step1_sorted" ]
then
  echo "$alignment_step1_sorted found."
else
  samtools sort $alignment_step1_bam -o $alignment_step1_sorted
  samtools index $alignment_step1_sorted
fi

echo 'PILON STEP1____________________________________________________________________'
if [ -e "$step1_pilon_fa" ]
then
  echo "$step1_pilon_fa found."
else
  java -Xmx700G -jar .conda/envs/pilon/share/pilon-1.23-2/pilon-1.23.jar --genome $reference_genome_step1 --frags $alignment_step1_sorted --diploid --outdir $1/genomePolishing/illumina/step1 --output $step1_pilon_prefix --threads 4
fi

cp $step1_pilon_fa $1/genomePolishing/illumina/step2/
cd $1/genomePolishing/illumina/step2

echo 'BWA INDEX STEP2________________________________________________________________'
if [ -e $1/genomePolishing/illumina/step2/*.ann ]
then
  echo "$1/genomePolishing/illumina/step2/*.ann found."
else
  bwa index -p $reference_genome_step2_prefix -a bwtsw $reference_genome_step2
fi

echo 'BWA MEM STEP2__________________________________________________________________'
if [ -e "$alignment_step2_sam" ]
then
  echo "$alignment_step2_sam found."
else
  bwa mem -t 24 -M $reference_genome_step2 $R1 $R2 > $alignment_step2_sam
fi

echo 'SAMTOOLS VIEW STEP2____________________________________________________________'
if [ -e "$alignment_step2_bam" ]
then
  echo "$alignment_step2_bam found."
else
  samtools view -S -b -h $alignment_step2_sam -o $alignment_step2_bam
fi

echo 'SAMTOOLS SORT INDEX STEP2______________________________________________________'
if [ -e "$alignment_step2_sorted" ]
then
  echo "$alignment_step2_sorted found."
else
  samtools sort $alignment_step2_bam -o $alignment_step2_sorted
  samtools index $alignment_step2_sorted
fi

echo 'PILON STEP2____________________________________________________________________'
if [ -e "$step2_pilon_fa" ]
then
  echo "$step2_pilon_fa found."
else
  java -Xmx700G -jar .conda/envs/pilon/share/pilon-1.23-2/pilon-1.23.jar --genome $reference_genome_step2 --frags $alignment_step2_sorted --diploid --outdir $1/genomePolishing/illumina/step2 --output $step2_pilon_prefix --threads 4
fi
