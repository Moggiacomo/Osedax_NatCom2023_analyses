#!/bin/bash
#$ -wd /data/scratch/btx654/pfam/pfamScan
#$ -o /data/scratch/btx654/pfam/pfamScan
#$ -j y
#$ -l highmem
#$ -pe smp 12
#$ -l h_vmem=40G
#$ -l h_rt=36:0:0
#$ -l highmem

module load anaconda3
conda activate pfamScan_env

pfam_scan.pl -cpu 12 -fasta ../RIFPA_final_gene_models_AUGUSTUS_v1_AGAT.prot.longestIsoform.fasta -dir /data/SBCS-MartinDuranLab/00-BlastDBs -outfile PFAMscan_oliveira2022NR.out


grep -v "^#" PFAMscan_oliveira2022NR.out | grep -o "RIFPA.*t[0-9]"   | sort | uniq | wc -l
grep -v "^#" PFAMscan_oliveira2022NR.out | grep -o "\sPF.........."  | sort | uniq | wc -l
