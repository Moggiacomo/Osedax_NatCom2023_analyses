
#!/bin/bash
#$ -wd /data/scratch/btx654/metabolism
#$ -o /data/scratch/btx654/metabolism
#$ -j y
#$ -pe smp 12
#$ -l h_vmem=40G
#$ -l h_rt=72:0:0
#$ -l highmem

species=$1
NR_proteome="$species".fa 
NR_proteome_path=/data/SBCS-MartinDuranLab/03-Giacomo/NR_proteomes/$NR_proteome
output_kofam="$species"_kofam_result.txt

echo "Working on "$species

module load anaconda3
conda activate kofam_env

mkdir $species
cd $species

exec_annotation \
 --profile=/data/SBCS-MartinDuranLab/03-Giacomo/db/kofam/profiles/ \
 --ko-list=/data/SBCS-MartinDuranLab/03-Giacomo/db/kofam/ko_list \
 --cpu=12 \
 --format=mapper \
 --report-unannotated \
 -o $output_kofam \
 $NR_proteome_path
