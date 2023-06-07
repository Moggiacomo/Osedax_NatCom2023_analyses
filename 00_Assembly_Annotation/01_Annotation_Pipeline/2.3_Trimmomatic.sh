
#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 4
#$ -l h_vmem=6G
#$ -l h_rt=24:0:0

species=$1
sample_name=$2
sample_R1="$sample_name"_1.fq.gz
sample_R2="$sample_name"_2.fq.gz
R1_paired="$sample_name"_1_paired.fastq.gz
R1_unpaired="$sample_name"_1_unpaired.fastq.gz
R2_paired="$sample_name"_2_paired.fastq.gz
R2_unpaired="$sample_name"_2_unpaired.fastq.gz

trim_log=trim_"$sample_name"
log="$sample_name".log

module load anaconda2
source activate Trinity

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step2/
mkdir -p trimmomatic
cd trimmomatic
mkdir trimmomatic_"$sample_name"
cd trimmomatic_"$sample_name"
cp /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/00-RNAseq/$sample_R1 ./
cp /data/SBCS-MartinDuranLab/03-Giacomo/data/$species/00-RNAseq/$sample_R2 ./

trimmomatic PE \
 -threads 4 \
 -phred33 \
 -trimlog $trim_log \
 ./$sample_R1 \
 ./$sample_R2 \
 $R1_paired \
 $R1_unpaired \
 $R2_paired \
 $R2_unpaired \
 ILLUMINACLIP:/data/home/btx654/.conda/envs/Trinity/opt/trinity-2.9.1/trinity-plugins/Trimmomatic-0.36/adapters/TruSeq3-PE-2.fa:2:30:10 \
 LEADING:28 TRAILING:28 SLIDINGWINDOW:4:15 MAXINFO:40:0.5 MINLEN:36 \
 > $log 2>&1
