
#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=6G
#$ -l h_rt=12:0:0

LTR_gff=oasisia_Nov2020_LTRfinder_FullOutput.gff
LTR_gff_original=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1/ltr_finder/$LTR_gff
LTR_gff_ok=oasisia_Nov2020_LTRfinder_FullOutput_ok.gff

RM_out=oasisia_purged_Nov2020.fa.out
RM_out_original=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1/repeatmasker/$RM_out
RM_out_ok=oasisia_purged_Nov2020.fa.out

RM_out_gff=oasisia_purged_Nov2020.fa.out.gff
RM_out_gff_original=/data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1/repeatmasker/$RM_out_gff
RM_out_gff_ok=oasisia_purged_Nov2020_ok.fa.out.gff

output=oasisia_Nov2020_RepeatCraft

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step1
mkdir repeatcraft
cd repeatcraft

#obtain longest ltr size for the configuration file of repeatcraft:
#awk 'BEGIN {FS="\t"}; {print $5 -= $4}' oasisia_Nov2020_LTRfinder_FullOutput.gff | sort -nr | head -n1

echo "#configuration file for RepeatCraft

# Label short TEs
shortTE_size: 100
mapfile: None

# LTR grouping (based on LTR_FINDER result).
ltr_finder_gff: $LTR_gff_ok
max_LTR_size: 25000
LTR_flanking_size: 200

# TEs grouping
gap_size: 150" > repeatcraft.cgf

# Load python
module load python

# Copy required files into the working directory
cp $RM_out_original ./
cp $RM_out_gff_original ./
cp $LTR_gff_original ./

sed -e 's/.arrow.arrow.pilon.pilon//' $RM_out > $RM_out_ok
sed -e 's/.arrow.arrow.pilon.pilon//' $RM_out_gff > $RM_out_gff_ok
sed -e 's/.arrow.arrow.pilon.pilon//' $LTR_gff > $LTR_gff_ok

# Run RepeatCraft
/data/SBCS-MartinDuranLab/02-Chema/src/repeatcraftp/repeatcraft.py \
 -r $RM_out_gff_ok \
 -u $RM_out_ok \
 -c repeatcraft.cgf \
 -o $output
