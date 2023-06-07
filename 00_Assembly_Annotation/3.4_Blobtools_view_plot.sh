#!/bin/bash
#$ -wd /data/scratch/btx604/oasisia/blobtools/nt_v5
#$ -o /data/scratch/btx604/oasisia/blobtools/nt_v5
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0

module load anaconda2
source activate blobtools

cd /data/scratch/btx604/oasisia/blobtools/nt_v5

blobtools view \
 -i /data/scratch/btx604/oasisia/blobtools/nt_v5/oasisia_blobplot.blobDB.json \
 -o /data/scratch/btx604/oasisia/blobtools/nt_v5/

blobtools plot \
 -i /data/scratch/btx604/oasisia/blobtools/nt_v5/oasisia_blobplot.blobDB.json \
 -o /data/scratch/btx604/oasisia/blobtools/nt_v5/
