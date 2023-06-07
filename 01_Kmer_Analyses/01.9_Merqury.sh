
#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 10
#$ -l h_vmem=20G
#$ -l h_rt=100:0:0
#$ -l highmem

species=$1
purged="$species".fa
R1="$species"_R1.fq
R2="$species"_R2.fq
meryl_R1="$species"_R1.meryl
meryl_R2="$species"_R2.meryl
meryl_final="$species".meryl
merqury_output="$species"_merqury_nonBacteria

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/kmer_Dec2020/
mkdir -p merqury
cd merqury

module load anaconda3
conda activate /data/SBCS-MartinDuranLab/03-Giacomo/src/anaconda3/merqury_env

meryl k=21 threads=10 count output $meryl_R1 ../$R1
meryl k=21 threads=10 count output $meryl_R2 ../$R2

meryl union-sum output $meryl_final *_R*.meryl

merqury.sh $meryl_final ../$purged $merqury_output > Merqury.log

#spectra_cn="$species"_merqury_nonBacteria."$species".spectra-cn.hist
#only_hist="$species"_merqury_nonBacteria.dist_only.hist
#output_plot="$species".spectra-cn

#Rscript $MERQURY/plot/plot_spectra_cn.R -f $spectra_cn -o $output_plot -z $only_his -m (kmer_multiplicity) and -n (Count)
