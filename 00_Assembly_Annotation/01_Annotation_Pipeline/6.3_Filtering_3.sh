#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 8
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0

species=$1
pasa_gtf="$species".AGAT.noSTOP.filt.gtf
species_softmasked="$species"_softmasked.fa
pasa_prot_fasta="$species".AGAT.noSTOP.filt.prot.fasta
final_pasa_gtf="$species".AGAT.noSTOP.filt.noTE.gtf
final_pasa_prot_fasta="$species".AGAT.noSTOP.filt.noTE.prot.fasta
final_pasa_gff3="$species".AGAT.noSTOP.filt.noTE.AGAT.gff3

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step6/

module load anaconda3
source activate augustus

gffread -E $pasa_gtf -S -g $species_softmasked -y $pasa_prot_fasta

conda deactivate
module unload anaconda3

cp /data/SBCS-MartinDuranLab/03-Giacomo/src/RepeatMasker/Libraries/RepeatPeps.lib ./
module load diamond/0.9.22
diamond makedb --in RepeatPeps.lib -d RepeatPeps
diamond blastp -d RepeatPeps -q $pasa_prot_fasta -o pasa.vs.RepeatPeps.1e5.blastp -f 6 qseqid bitscore evalue stitle -k 25 -e 1e-5 -p 8

cat pasa.vs.RepeatPeps.1e5.blastp | cut -f 1 | sort | uniq > TEsIDs.txt
fgrep -w -v -f TEsIDs.txt $pasa_gtf > $final_pasa_gtf

#check if we still have TEs in our proteins
module load anaconda3
source activate augustus

gffread -E $final_pasa_gtf -S -g $species_softmasked -y $final_pasa_prot_fasta

conda deactivate
module unload anaconda3

module load diamond/0.9.22
diamond blastp -d RepeatPeps -q $final_pasa_prot_fasta -o pasa_noTE.vs.RepeatPeps.1e5.blastp -f 6 qseqid bitscore evalue stitle -k 25 -e 1e-5 -p 8
#check end

module load anaconda3
conda activate agat_env

agat_convert_sp_gxf2gxf.pl -g $final_pasa_gtf -o $final_pasa_gff3
agat_sq_stat_basic.pl -i $final_pasa_gff3 -g $species_softmasked
