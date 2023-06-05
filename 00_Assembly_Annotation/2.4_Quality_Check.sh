#!/bin/bash
#$ -cwd 
#$ -o logs/
#$ -pe smp 4
#$ -l h_vmem=2G
#$ -l h_rt=10:0:0
#$ -j y

cd genomePolishing

module load busco/3.0
module load augustus

export AUGUSTUS_CONFIG_PATH=src/Augustus/config

BUSCO.py \
-i genomePolishing/illumina/oasisia_pilon_step2.fasta \
-m genome \
-o oasisia_polished_busco \
-c 4 \
-l datasets/metazoa_odb9


module load anaconda2
source activate quast

quast \
 oasisia/canu/Oasisia.contigs.fasta \
 oasisia/genomePolishing/PB/oasisia_step1_consensus.fasta \
 oasisia/genomePolishing/PB/oasisia_step2_consensus.fasta \
 oasisia/genomePolishing/illumina/oasisia_pilon_step1.fasta \
 oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta \
 -o oasisia/quast/genomePolishing/ \
 --eukaryote
