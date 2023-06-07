#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 5
#$ -l h_vmem=10G
#$ -l h_rt=12:0:0

species=oasisia
species_softmasked=oasisia_Nov2020_softmasked.fa
species_softmasked_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step1/softmasking/$species_softmasked


module load anaconda3
source activate STAR


cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/
mkdir -p STAR
cd STAR

cp $species_softmasked_path ./

# Build STAR genome index and align the reads generating a BAM sorted by coordinate and a stranded wiggle file to visualise the RNA-seq
STAR --runMode genomeGenerate --genomeSAindexNbases 13 --runThreadN 5 --genomeDir/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/STAR --genomeFastaFiles $species_softmasked
