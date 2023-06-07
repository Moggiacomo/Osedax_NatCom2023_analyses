
#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 24
#$ -l h_vmem=10G
#$ -l h_rt=24:0:0
#$ -l highmem

#bwa index step1 variables
reference_genome_step1_prefix="$1"_step2_consensus.fasta
reference_genome_step1=$1/genomePolishing/illumina/blobtools/$reference_genome_step1_prefix
#bwa mem step1 variables
R1=$1/genomePolishing/illumina/raw_reads/R1.fastq.gz
R2=$1/genomePolishing/illumina/raw_reads/R2.fastq.gz
alignment_step1_sam=$1/genomePolishing/illumina/blobtools/"$1"_alignment_step1.sam
#samtools view step1 variables
alignment_step1_bam=$1/genomePolishing/illumina/blobtools/"$1"_alignment_step1.bam
#samtools sort index step1 variables
alignment_step1_sorted=$1/genomePolishing/illumina/blobtools/"$1"_sorted_step1.bam

module load bwa
module load samtools/1.9

cd $1/genomePolishing/illumina/blobtools

echo 'BWA INDEX STEP1________________________________________________________________'
if [ -e $1/genomePolishing/illumina/blobtools/*.ann ]
then
  echo "$1/genomePolishing/illumina/blobtools/*.ann found."
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
