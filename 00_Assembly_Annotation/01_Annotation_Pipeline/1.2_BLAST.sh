#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 8
#$ -l h_vmem=10G
#$ -l h_rt=120:0:0
#$ -l highmem

owenia=/data/SBCS-MartinDuranLab/03-Giacomo/db/owenia/Owenia_filtered_proteins.fa
consensi=consensi.fa.classified

echo "Working on "$1

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1

mkdir step_1.2
cd RM*
cp $consensi ../step_1.2/
cd ../step_1.2

#make a diamond BLAST database of this proteome and BLAST the consensi.fa.classified dataset against it, to find potential bona fide genes. To make sure we only get the real genes, the e-value is very stringent.
module load anaconda2
source activate diamond
diamond makedb --in $owenia -d OweniaProtNoTEs

diamond blastp -d OweniaProtNoTEs -q $consensi -o consensi.fa.vs.OweniaProtNoTEs.1e10.blastp -f 6 qseqid bitscore evalue stitle -k 25 -e 1e-10 -p 8

#Since there will not be many hits, I recommend removing the potential bona fide genesout of the consensi.fa.classified by hand, as one makes sure that each of those hits are actual genes and not a TEs.
