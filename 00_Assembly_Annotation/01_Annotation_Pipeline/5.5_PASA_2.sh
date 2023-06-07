#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 2
#$ -l h_vmem=10G
#$ -l h_rt=48:0:0

species=$1
species_softmasked="$species"_softmasked.fa
augustus_output="$species".aug.out
augustus_gtf="$species".aug.gtf

echo "Working on "$species

module load anaconda3
source activate augustus

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5

gffread $augustus_output -E -T -o $augustus_gtf

conda deactivate
source activate pasa
module load samtools/1.9

/data/home/btx654/.conda/envs/pasa/opt/pasa-2.4.1/scripts/Load_Current_Gene_Annotations.dbi -c alignAssembly.config -g $species_softmasked -P $augustus_gtf
