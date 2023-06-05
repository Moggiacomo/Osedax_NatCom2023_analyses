#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 6
#$ -l h_vmem=8G
#$ -l h_rt=2:0:0

#load the environment
module load anaconda2
source activate kmergenie

kmergenie \
#list_for_kmergenie contains the path to the Illumina raw data and I have generated it with:
#readlink -f OSE_DAX-1_S55_L003_R* > list_for_kmergenie
 list_for_kmergenie \
 --diploid \
 -o osedax_histograms
 
 
