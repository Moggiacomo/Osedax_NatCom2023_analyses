#!/bin/bash
#$ -wd /data/scratch/btx654/riftia_oliveira_2022
#$ -o /data/scratch/btx654/riftia_oliveira_2022
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0
#$ -l highmem

module load anaconda3
conda activate agat_env

agat_convert_sp_gxf2gxf.pl --gff RIFPA_final_gene_models_AUGUSTUS_v1.gff3 --merge_loci -o RIFPA_final_gene_models_AUGUSTUS_v1_AGAT.gff3
agat_convert_sp_gxf2gxf.pl --gff RIFPA_final_gene_models_AUGUSTUS_v1_AGAT.gff3 --merge_loci -o RIFPA_final_gene_models_AUGUSTUS_v1_AGAT_lociMerged.gff
agat_sp_keep_longest_isoform.pl --gff RIFPA_final_gene_models_AUGUSTUS_v1_AGAT_lociMerged.gff -o RIFPA_final_gene_models_AUGUSTUS_v1_AGAT_lociMerged_longestIsoform.gff

agat_sq_stat_basic.pl -i RIFPA_final_gene_models_AUGUSTUS_v1_AGAT.gff3 -g 4.2_RIFPA_polished_softMasked_purged_genome_v1.fasta

conda deactivate
source activate augustus

gffread -E RIFPA_final_gene_models_AUGUSTUS_v1_lociMerged_longestIsoform.gff -g 4.2_RIFPA_polished_softMasked_purged_genome_v1.fasta -y RIFPA_final_gene_models_AUGUSTUS_v1.prot.longestIsoform.fasta

conda deactivate

source activate quast


quast ./4.2_RIFPA_polished_softMasked_purged_genome_v1.fasta -o ./quast_4.2_softmasked --eukaryote


conda deactivate
source activate busco_env
#export BUSCO_CONFIG_FILE="/data/home/btx654/.conda/envs/busco_env/busco/config/myconfig.ini"
#export AUGUSTUS_CONFIG_PATH=/data/SBCS-MartinDuranLab/02-Chema/src/Augustus/config/

#busco -i RIFPA_final_gene_models_AUGUSTUS_v1.prot.longestIsoform.fasta -m proteins -o busco_longest_isoform -c 4 -l metazoa_odb10
busco -i RIFPA_final_gene_models_AUGUSTUS_v1.prot.fasta -m proteins -o busco_gene_models -c 4 -l metazoa_odb10
busco -i 4.2_RIFPA_polished_softMasked_purged_genome_v1.fasta -m DNA -o busco_genome -c 4 -l metazoa_odb10
