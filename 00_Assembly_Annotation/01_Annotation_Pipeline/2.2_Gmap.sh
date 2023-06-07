#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 5
#$ -l h_vmem=10G
#$ -l h_rt=24:0:0

#- $1 is the species name
#- $2 is the name of the folder containing the trinity transcriptomes assembly

species_softmasked=oasisia_Nov2020_softmasked.fa
species_softmasked_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step1/softmasking/$species_softmasked
species_softmasked_output="$1"_softmasked_Nov2020
trinity_name="$2".Trinity.fasta
trinity_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/trinity/$2/$trinity_name
final_output_gff3="$2"_Vs_Genome_gmap.gff3

echo "Working on "$1" using "$2

module load anaconda3
source activate annotation_step2

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/
mkdir -p step2 #this option will create a directory only if it not exists already
cd step2
mkdir $2
cd $2

cp $species_softmasked_path ./
cp $trinity_path ./

# Make a GMAP index and align transcripts to the genome
gmap_build -D /data/scratch/btx654/btx604-scratch/$1/annotation_step2/$2 -d $species_softmasked_output $species_softmasked

gmap -D /data/scratch/btx654/btx604-scratch/$1/annotation_step2/$2 -d $species_softmasked_output -f 3 -n 0 -x 50 -t 5 -B 4 --gff3-add-separators=0 $trinity_name > $final_output_gff3
