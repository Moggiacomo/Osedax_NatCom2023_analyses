#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=1G
#$ -l h_rt=72:0:0

#load the environment
module load anaconda2
source activate BAM2fastx_env
#to convert subreads.bam into fastq file
bam2fastq \
#output_name
-o Oasisia_pb_raw \
#path to the subreads.bam file received from PacBio
pb/r64044_20190812_215729/1_A01/m64044_190812_220643.subreads.bam
