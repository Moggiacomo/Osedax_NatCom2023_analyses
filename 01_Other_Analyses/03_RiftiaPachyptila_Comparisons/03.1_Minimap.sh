
#!/bin/bash
#$ -wd /data/scratch/btx654/alignment
#$ -o /data/scratch/btx654/alignment
#$ -j y
#$ -pe smp 12
#$ -l h_vmem=30G
#$ -l h_rt=240:0:0
#$ -l highmem

module load anaconda3
source activate minimap2_env

minimap2 -cx asm5 /data/scratch/btx654/riftia_oliveira_2022_SINGLE/4.2_RIFPA_polished_softMasked_purged_genome_v1_SINGLE.fasta /data/SBCS-MartinDuranLab/03-Giacomo/data/riftia/annotation/riftia_softmasked.fa > alignment_riftia_OUR_VS_oliveira_2022.paf
