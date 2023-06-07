#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 2
#$ -l h_vmem=10G
#$ -l h_rt=48:0:0

species=$1
species_softmasked="$species"_softmasked.fa
pasa_first_step_gff3="$species"_pasa_FirstStep.gff3
pasa_first_step_gtf="$species"_pasa_FirstStep.gtf


module load anaconda3
source activate augustus


cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5

gffread $pasa_first_step_gff3 -E -T -o $pasa_first_step_gtf

conda deactivate
source activate pasa
module load samtools/1.9

/data/home/btx654/.conda/envs/pasa/opt/pasa-2.4.1/scripts/Load_Current_Gene_Annotations.dbi -c alignAssembly.config -g $species_softmasked -P $pasa_first_step_gtf
