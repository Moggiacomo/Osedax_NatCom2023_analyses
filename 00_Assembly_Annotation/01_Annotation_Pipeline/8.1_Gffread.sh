#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0
#$ -l highmem

species=$1
final_annotation="$species"_annotation_*.gff3
final_annotation_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step6/$final_annotation
species_softmasked="$species"_softmasked.fa
species_softmasked_path=/data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step6/$species_softmasked
output_mRNA="$species"_mRNA.fa
output_CDS="$species"_CDS.fa
output_proteins="$species"_proteins.fa

echo "Working on "$species

module load anaconda3
source activate augustus

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/

mkdir -p step8
cd step8

cp $species_softmasked_path ./
cp $final_annotation_path ./

gffread -w $output_mRNA -g $species_softmasked $final_annotation
gffread -x $output_CDS -g $species_softmasked $final_annotation
gffread -y $output_proteins -g $species_softmasked $final_annotation
