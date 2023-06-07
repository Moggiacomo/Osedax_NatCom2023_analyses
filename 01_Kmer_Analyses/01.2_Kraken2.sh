#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 6
#$ -l h_vmem=10G
#$ -l h_rt=240:0:0
#$ -l highmem

species=$1
kraken_database=/data/SBCS-MartinDuranLab/03-Giacomo/db/kraken2_db_standard_Oct2020
pacbio_corrected="$species"_pacbio_corrected_bbmap.fasta
output_pacbio="$species"_pacbio_bbmap_output.kraken

module load anaconda3
conda activate kraken2_env

cd /data/scratch/btx654/btx604-scratch/$species/kraken2/pacbio_illumina_2

kraken2 --threads 6 --output $output_pacbio --report report_kraken2_pacbio_bbmap --db $kraken_database $pacbio_corrected
