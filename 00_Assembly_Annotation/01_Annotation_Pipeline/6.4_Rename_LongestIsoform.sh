#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=5G
#$ -l h_rt=2:0:0

species=$1
prefix=$2
final_pasa_gff3="$species".AGAT.noSTOP.filt.noTE.AGAT.gff3
final_pasa_gtf="$species".AGAT.noSTOP.filt.noTE.gtf
output_annotation="$species"_annotation_v101220.gff3
loci_merged="$species"_lociMerged.gff
longest_isoform="$species"_lociMerged_longestIsoform.gff

echo "Working on "$species" using prefix: "$prefix

mkdir /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step6
cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step6/

cp $final_pasa_gff3 /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step6/
cp $final_pasa_gtf /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step6/

cd /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/New_annotation_Dec2020/step6/

module load anaconda3
conda activate agat_env

agat_sp_manage_IDs.pl -f $final_pasa_gff3 --ensembl --prefix $prefix --type_dependent --tair -o $output_annotation

agat_convert_sp_gxf2gxf.pl --gff $output_annotation --merge_loci -o $loci_merged
agat_sp_keep_longest_isoform.pl --gff $loci_merged -o $longest_isoform
