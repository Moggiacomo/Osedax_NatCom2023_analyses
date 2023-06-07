
#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 2
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0

species=$1
pasa_gff3="$species".AGAT.noSTOP.gff3
pasa_gtf="$species".AGAT.noSTOP.gtf
repeatmasker="$species"_repeatmasker.fa.out
repeatmasker_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/$species/annotation/repeatmasker_delete_after_step6_Dec2020/$repeatmasker
output_filt_gtf="$species".AGAT.noSTOP.filt.gtf
output_filt_gff3="$species".AGAT.noSTOP.filt.AGAT.gff3
species_softmasked="$species"_softmasked.fa

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step6/

module load anaconda3
source activate augustus

gffread -E $pasa_gff3 -T -o $pasa_gtf

conda deactivate
module unload anaconda3

module load python/2.7.15
module load bedtools

cp $repeatmasker_path ./
sed -e 's/.arrow.arrow.pilon.pilon//' $repeatmasker > repeatmasker_sed.fa.out

python2 /data/SBCS-MartinDuranLab/03-Giacomo/src/various/rep2bed.py repeatmasker_sed.fa.out > RepeatMasker.bed
python2 /data/SBCS-MartinDuranLab/03-Giacomo/src/various/filt-rep-gtf.py $pasa_gtf RepeatMasker.bed

module unload python/2.7.15
module unload bedtools
module load anaconda3
conda activate agat_env

agat_convert_sp_gxf2gxf.pl -g $output_filt_gtf -o $output_filt_gff3
agat_sq_stat_basic.pl -i $output_filt_gff3 -g $species_softmasked
