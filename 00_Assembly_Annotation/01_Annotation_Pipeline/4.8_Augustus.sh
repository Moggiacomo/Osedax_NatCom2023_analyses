#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=72:0:0

species=$1
species_augustus="$species"_Nov2020
species_softmasked="$species"_Nov2020_softmasked.fa
species_softmasked_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/new_annotation_Nov2020/step1/softmasking/$species_softmasked
extrinsic_file=extrinsic.Ferdi.E.W.P.cfg
extrinsic_path=/data/home/btx654/.conda/envs/augustus/config/extrinsic/$extrinsic_file
hints_file="$species"_merged_hints.gff
output="$species_augustus".aug.out

module load anaconda3
source activate augustus

cd /data/scratch/btx654/btx604-scratch/$species/new_annotation_Nov2020/annotation_step4/augustus/
# Copy genome into working directory
cp $species_softmasked_path ./
cp $extrinsic_path ./
# Run augustus
augustus --uniqueGeneId=true --gff3=on --species=$species_augustus --hintsfile=$hints_file --extrinsicCfgFile=$extrinsic_file --allow_hinted_splicesites=atac --alternatives-from-evidence=false $species_softmasked > $output
