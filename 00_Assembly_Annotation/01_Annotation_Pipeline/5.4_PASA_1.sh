#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 24
#$ -l h_vmem=25G
#$ -l h_rt=240:0:0
#$ -l highmem

species=$1
species_softmasked="$species"_softmasked.fa
mikado_transcripts="$species"_mikado_transcripts_NoncRNA.fa
mikado_transcripts_clean="$species"_mikado_transcripts_NoncRNA.fa.clean

echo "Working on "$species

module load anaconda3
source activate pasa
module load samtools

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5

/data/home/btx654/.conda/envs/pasa/opt/pasa-2.4.1/Launch_PASA_pipeline.pl -c alignAssembly.config -C -R -g $species_softmasked -t $mikado_transcripts_clean -T -u $mikado_transcripts --ALIGNERS blat --CPU 24
