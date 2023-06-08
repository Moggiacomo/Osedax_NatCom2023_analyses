#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 10
#$ -l h_vmem=5G
#$ -l h_rt=80:00:0
#$ -l highmem

module load perl
module load hmmer/

export PERL5LIB=/data/SBCS-MartinDuranLab/03-Giacomo/src/hmmscoring/lib/

perl /data/SBCS-MartinDuranLab/03-Giacomo/src/hmmscoring/pantherScore2.2.pl -l /data/SBCS-MartinDuranLab/03-Giacomo/src/hmmscoring/PANTHER15.0/ -D B -n -o panther_output -i ../missing_busco.fa -c 10 -V -s
