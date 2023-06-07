#create a folder which can be deleted after this step6: 
#/data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/repeatmasker_delete_after_step6_Dec2020
#containing the output of repeatmasker named as: - “$species”_repeatmasker.fa.out


#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 2
#$ -l h_vmem=3G
#$ -l h_rt=24:0:0

species=$1
species_softmasked="$species"_softmasked.fa
species_softmasked_path=/data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5/$species_softmasked
pasa_second_step_gff3="$species"_pasa_SecondStep.gff3
pasa_second_step_path=/data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5/$pasa_second_step_gff3
pasa_second_step_AGAT="$species"_pasa_SecondStep.AGAT.gff3
output_gff3="$species".AGAT.noSTOP.gff3

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/

mkdir -p step6
cd step6

cp $species_softmasked_path ./
cp $pasa_second_step_path ./

module load anaconda3
conda activate agat_env

agat_convert_sp_gxf2gxf.pl -g $pasa_second_step_gff3 -o $pasa_second_step_AGAT

conda deactivate
source activate augustus

gffread -E $pasa_second_step_AGAT -g $species_softmasked -V -H -o $output_gff3
