#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=8G
#$ -l h_rt=2:0:0

species=$1
gene_trans_map="$species".gene_trans_map
sqlite_db="$species".sqlite

echo "Working on "$species

module load anaconda3
conda activate /data/SBCS-MartinDuranLab/03-Giacomo/src/anaconda3/trinotate_env

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step8/

Build_Trinotate_Boilerplate_SQLite_db.pl $species

Trinotate $sqlite_db init --gene_trans_map $gene_trans_map --transcript_fasta input_trinotate_mRNA.fa --transdecoder_pep input_trinotate_proteins.fa
#LOAD annotations, below are examples from Trinotate manual, change accordingly to your species ouput from blast+:
Trinotate $sqlite_db LOAD_swissprot_blastp blastp.outfmt6
Trinotate $sqlite_db LOAD_swissprot_blastx blastx.outfmt6
Trinotate $sqlite_db LOAD_signalp signalp.out
Trinotate $sqlite_db LOAD_pfam PFAM.out

Trinotate $sqlite_db report --incl_pep --incl_trans > annotation_report.xls
