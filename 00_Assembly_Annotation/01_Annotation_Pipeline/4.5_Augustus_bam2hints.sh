#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=1G
#$ -l h_rt=6:0:0

species=$1
sample_name=$2
prefix="$species"_"$sample_name"
bam_name="$prefix"_portcullis.filtered.bam
bam_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/new_annotation_Nov2020/step2/portcullis/$bam_name
output_gff="$prefix".intronhints.gff

echo "Working on "$species" using "$sample_name

module load anaconda3
source activate augustus

cd /data/scratch/btx654/btx604-scratch/$species/new_annotation_Nov2020/annotation_step4/augustus

cp $bam_path ./
# Get intron hints
bam2hints --intronsonly --minintronlen=15 --in="$bam_name" --out="$output_gff"
rm $bam_name
