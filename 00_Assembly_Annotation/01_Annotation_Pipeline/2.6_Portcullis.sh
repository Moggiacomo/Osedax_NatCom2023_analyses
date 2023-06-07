#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=20G
#$ -l h_rt=30:0:0

species=$1
sample_name=$2
species_softmasked=oasisia_Nov2020_softmasked.fa
species_softmasked_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step1/softmasking/$species_softmasked
prefix="$species"_"$sample_name"
output_STAR="$prefix"_STAR_Aligned.sortedByCoord.out.bam
output_STAR_path=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/STAR/$output_STAR
output_portcullis="$prefix"_portcullis

echo "Working on "$species" using "$sample_name

module load anaconda3
source activate portcullis

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/
mkdir -p portcullis
cd portcullis
mkdir $sample_name
cd $sample_name
cp $output_STAR_path ./
cp $species_softmasked_path ./

# Run portcullis
portcullis full -t 4 -v --bam_filter --orientation FR --strandedness firststrand -o $output_portcullis $species_softmasked $output_STAR
