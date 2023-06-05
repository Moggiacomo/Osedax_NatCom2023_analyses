#!/bin/bash
#$ -cwd 
#$ -j y
#$ -o genomePolishing/PB
#$ -pe smp 8
#$ -l h_vmem=10G
#$ -l h_rt=240:0:0

#seqtk variables
raw_pb_reads_fq=data/osedax/00-pacbio/osedax_pb_raw.fastq.gz
raw_pb_reads_fa=genomePolishing/PB/pacbio_reads/osedax_pb_raw.fa
#faidx variables
reference_genome_step1=genomePolishing/PB/reference_genome/Osedax.contigs.fasta
#pbmm2 step1 variables
pb_subreads_bam=pb/r64044_20191025_002245/2_B01/m64044_191025_155828.subreads.bam
alignment_step1=genomePolishing/PB/step1/osedax_pbmm2_step1.bam
#samtools step1 variables
alignment_step1_sorted=genomePolishing/PB/step1/osedax_sorted_step1.bam
#arrow step1 variables
step1_variants=genomePolishing/PB/step1/osedax_step1_variants.gff
step1_consensus_fa=genomePolishing/PB/step1/osedax_step1_consensus.fasta
step1_consensus_fq=genomePolishing/PB/step1/osedax_step1_consensus.fastq

#pbmm2 step2 variables
alignment_step2=genomePolishing/PB/step2/osedax_pbmm2_step2.bam
#samtools step2 variables
alignment_step2_sorted=genomePolishing/PB/step2/osedax_sorted_step2.bam
#arrow step2 variables
step2_variants=genomePolishing/PB/step2/osedax_step2_variants.gff
step2_consensus_fa=genomePolishing/PB/step2/osedax_step2_consensus.fasta
step2_consensus_fq=genomePolishing/PB/step2/osedax_step2_consensus.fastq


module load seqtk
module load samtools/1.9
module load anaconda2
source activate genomePolishing


echo 'SEQTK _________________________________________________________________________'
if [ -e "$raw_pb_reads_fa" ]
then
  echo "$raw_pb_reads_fa found."
else
  seqtk seq -a $raw_pb_reads_fq > $raw_pb_reads_fa
fi

echo 'FAIDX STEP1____________________________________________________________________'
if [ -e genomePolishing/PB/reference_genome/*.fai ]
then
  echo "genomePolishing/PB/reference_genome/*.fai found."
else
  samtools faidx $reference_genome_step1
fi

echo 'PBMM2 STEP1____________________________________________________________________'
if [ -e "$alignment_step1" ]
then
  echo "$alignment_step1 found."
else
  pbmm2 align $reference_genome_step1 $pb_subreads_bam $alignment_step1
fi

echo 'SAMTOOLS STEP1_________________________________________________________________'
if [ -e "$alignment_step1_sorted" ]
then
  echo "$alignment_step1_sorted found."
else
  samtools sort $alignment_step1 -o $alignment_step1_sorted
  samtools index $alignment_step1_sorted
fi

echo 'PBINDEX STEP1__________________________________________________________________'
if [ -e genomePolishing/PB/step1/*.pbi ]
then
  echo "genomePolishing/PB/step1/*.pbi found."
else
  pbindex $alignment_step1_sorted
fi

echo 'ARROW STEP1____________________________________________________________________'
if [ -e "$step1_consensus_fa" ]
then
  echo "$step1_consensus_fa found."
else
  arrow $alignment_step1_sorted -r $reference_genome_step1 -o $step1_variants -o $step1_consensus_fa -o $step1_consensus_fq -j 8
fi

echo 'FAIDX STEP2____________________________________________________________________'
if [ -e genomePolishing/PB/step1/*.fai ]
then
  echo "/data/scratch/btx604/osedax/genomePolishing/PB/step1/*.fai found."
else
  samtools faidx $step1_consensus_fa
fi

echo 'PBMM2 STEP2____________________________________________________________________'
if [ -e "$alignment_step2" ]
then
  echo "$alignment_step2 found."
else
  pbmm2 align $step1_consensus_fa $pb_subreads_bam $alignment_step2
fi

echo 'SAMTOOLS STEP2_________________________________________________________________'
if [ -e "$alignment_step2_sorted" ]
then
  echo "$alignment_step2_sorted found."
else
  samtools sort $alignment_step2 -o $alignment_step2_sorted
  samtools index $alignment_step2_sorted
fi

echo 'PBINDEX STEP2__________________________________________________________________'
if [ -e /data/scratch/btx604/osedax/genomePolishing/PB/step2/*.pbi ]
then
  echo "/data/scratch/btx604/osedax/genomePolishing/PB/step2/*.pbi found."
else
  pbindex $alignment_step2_sorted
fi

echo 'ARROW STEP2____________________________________________________________________'
if [ -e "$step2_consensus_fa" ]
then
  echo "$step2_consensus_fa found."
else
  arrow $alignment_step2_sorted -r $step1_consensus_fa -o $step2_variants -o $step2_consensus_fa -o $step2_consensus_fq -j 8
fi
