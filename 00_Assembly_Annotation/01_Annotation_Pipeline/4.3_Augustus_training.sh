#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=1G
#$ -l h_rt=48:0:0

species=$1
species_augustus="$species"_Nov2020
species_softmasked="$species"_Nov2020_softmasked.fa
species_softmasked_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step1/softmasking/$species_softmasked

module load anaconda3
source activate augustus

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/annotation_step4/augustus/augustus_training
# Copy genome into working directory
cp $species_softmasked_path ./

autoAugTrain.pl --trainingset=training.gff3  --genome=$species_softmasked --species=$species_augustus --optrounds=1 --verbose
