#!/bin/bash
#$ -wd /data/scratch/btx604/oasisia/blobtools/nt_v5/fasta/
#$ -o /data/scratch/btx604/oasisia/blobtools/nt_v5/fasta/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=5G
#$ -l h_rt=3:0:0

#obtain fasta files for each taxa
#before running this create a directory named "fasta"

module load samtools/1.9

samtools faidx /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta -r /data/scratch/btx604/oasisia/blobtools/nt_v5/headers_proteobacteria.txt > /data/scratch/btx604/oasisia/blobtools/nt_v5/fasta/oasisia_proteobacteria.fasta

samtools faidx /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta -r /data/scratch/btx604/oasisia/blobtools/nt_v5/headers_actinobacteria.txt > /data/scratch/btx604/oasisia/blobtools/nt_v5/fasta/oasisia_actinobacteria.fasta

samtools faidx /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta -r /data/scratch/btx604/oasisia/blobtools/nt_v5/headers_bacteria.txt > /data/scratch/btx604/oasisia/blobtools/nt_v5/fasta/oasisia_bacteria.fasta

samtools faidx /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta -r /data/scratch/btx604/oasisia/blobtools/nt_v5/headers_host.txt > /data/scratch/btx604/oasisia/blobtools/nt_v5/fasta/oasisia_host.fasta
