
#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=72:0:0

species_unmasked=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1/oasisia_purged_Nov2020.fa
txt_output=oasisia_Nov2020_LTRfinder_FullOutput.txt
gff_output=oasisia_Nov2020_LTRfinder_FullOutput.gff

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1
mkdir ltr_finder
cd ltr_finder

module load anaconda2
source activate ltr_finder

ltr_finder $species_unmasked -w 0 -C 2>&1 > $txt_output

conda deactivate
source activate myperl

perl /data/SBCS-MartinDuranLab/03-Giacomo/src/dawgpaws/MODIFIED_cnv_ltrfinder2gff.pl -i $txt_output -o $gff_output
