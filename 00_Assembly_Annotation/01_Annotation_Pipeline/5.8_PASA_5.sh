#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 30
#$ -l h_vmem=3G
#$ -l h_rt=48:0:0
#$ -l highmem

species=$1
species_softmasked="$species"_softmasked.fa
mikado_transcripts_clean="$species"_mikado_transcripts_NoncRNA.fa.clean

echo "Working on "$species

module load anaconda3
source activate pasa
module load samtools

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5

/data/home/btx654/.conda/envs/pasa/opt/pasa-2.4.1/Launch_PASA_pipeline.pl -c annotCompare.config -A -g $species_softmasked -t $mikado_transcripts_clean --CPU 30

#change name pasa gff3 and bed outputs

mv sqlite_db.gene_structures_post_PASA_updates.37064.gff3 oasisia_pasa_SecondStep.gff3
mv sqlite_db.gene_structures_post_PASA_updates.37064.bed oasisia_pasa_SecondStep.bed
cp oasisia_pasa_SecondStep.* /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/New_annotation_Dec2020/step5/
