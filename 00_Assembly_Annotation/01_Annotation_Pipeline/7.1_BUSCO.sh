#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -pe smp 4
#$ -l h_vmem=20G
#$ -l h_rt=48:0:0
#$ -j y
#$ -l highmem

species=$1
annotation_gtf="$species".AGAT.noSTOP.filt.noTE.gtf
annotation_fa="$species"_annotation.prot.fa
species_softmasked="$species"_softmasked.fa
output_busco="$species"_busco_annotation

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step6/

module load anaconda3
source activate augustus

gffread -E $annotation_gtf -g $species_softmasked -y $annotation_fa

conda deactivate
source activate busco_env
#export BUSCO_CONFIG_FILE="/data/home/btx654/.conda/envs/busco_env/busco/config/myconfig.ini"
#export AUGUSTUS_CONFIG_PATH=/data/SBCS-MartinDuranLab/02-Chema/src/Augustus/config/

busco -i $annotation_fa -m proteins -o $output_busco -c 4 -l metazoa_odb10

cd $output_busco
cd run_*
mkdir /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step7
cp full_table.tsv /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step7
cp missing_busco_list.tsv /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step7
cp short_summary.txt /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step7
