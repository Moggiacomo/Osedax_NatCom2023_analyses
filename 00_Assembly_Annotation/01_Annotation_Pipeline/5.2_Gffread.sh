#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0

species=$1
species_softmasked="$species"_softmasked.fa
augustus_output="$species".aug.out
output_mikado_transcripts="$species"_mikado_transcripts_NoncRNA.fa
output_augustus_genes="$species".Augustus.genes.fa

echo "Working on "$species

module load anaconda3
source activate augustus

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5

gffread -C -x $output_mikado_transcripts -g $species_softmasked mikado.loci.AGAT.NOncRNA.gff3

gffread $augustus_output -V -w $output_augustus_genes -g $species_softmasked
