#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 8
#$ -l h_vmem=10G
#$ -l h_rt=120:0:0
#$ -l highmem

module load blast+

gffread -y osedax_protein.fa -g /data/SBCS-MartinDuranLab/03-Giacomo/data/osedax/annotation/softmasking/osedax_softmasked.fa /data/SBCS-MartinDuranLab/03-Giacomo/data/osedax/annotation/New_annotation_Dec2020/step6/osedax_annotation_v101220.gff3

makeblastdb -in ../osedax_protein.fa -dbtype prot -out osedax_prot
blastp -db osedax_prot -query ../missing_busco.fa -out osedax_prot_blastp_out -max_target_seqs 5 -evalue 1e-10 -num_threads 8 -outfmt 6
blastp -db osedax_prot -query ../missing_busco.fa -out osedax_prot_blastp_out.html -max_target_seqs 5 -evalue 1e-10 -num_threads 8 -html
