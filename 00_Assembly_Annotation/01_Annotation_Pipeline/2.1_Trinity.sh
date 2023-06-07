#!/bin/bash
#$ -wd /data/scratch/btx604/
#$ -j y
#$ -o /data/scratch/btx604/
#$ -pe smp 20
#$ -l h_vmem=20G
#$ -l h_rt=240:0:0
#$ -l highmem

#modify according to species and sample name

species=oasisia
sample_name=crown #e.g. body, roots, crown, trunk_wall...
sample1=O_A__1C_ #all characters before 1.fq.gz or 2.fq.gz
sample1_r1="$sample1"1.fq.gz #for osedax is 1.fastq.gz
sample1_r2="$sample1"2.fq.gz #for osedax is 1.fastq.gz
sample2=O_A__2C_ #all characters before 1.fq.gz or 2.fq.gz
sample2_r1="$sample2"1.fq.gz #for osedax is 1.fastq.gz
sample2_r2="$sample2"2.fq.gz #for osedax is 1.fastq.gz
output="$species"_"$sample_name"_trinity

echo "Working on "$output

module load anaconda2
source activate Trinity

cd $species/trinity
mkdir $output
cd $output
cp /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/00-RNAseq/"$sample1"* ./
cp /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/00-RNAseq/"$sample2"* ./

Trinity \
 --seqType fq \
 --left $sample1_r1,$sample2_r1 \
 --right $sample1_r2,$sample2_r2 \
 --SS_lib_type RF \
 --max_memory 400G \
 --CPU 20 \
 --output $output \
 --full_cleanup \
 --trimmomatic  

if [ -f "$output".Trinity.fasta ]
then
    if [ -s "$output".Trinity.fasta ]
    then
        echo $output".Trinity.fasta exists and not empty"
    else
        echo $output".Trinity.fasta exists but empty"
    fi
else
    echo $output".Trinity.fasta not exists"
fi
