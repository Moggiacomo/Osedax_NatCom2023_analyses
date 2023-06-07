#!/bin/bash
#$ -wd /data/scratch/btx604/
#$ -o /data/scratch/btx604/
#$ -j y
#$ -pe smp 2
#$ -l h_vmem=5G
#$ -l h_rt=24:0:0

#To get all the phyla present in my assembly do this:
#awk -F '\t' '{print $6}' oasisia_blobplot.blobDB.bestsum.table.txt | sort | uniq

#variables:
blobplot_original=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools/"$1"_blobplot.blobDB.bestsum.table.txt
blobplot=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools/"$1"_blobplot_tail_13.blobDB.bestsum.table.txt
host_table=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools/new_filter/new_filter_"$1"_blobplot_host.table.txt
proteobacteria_table=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools/new_filter/new_filter_"$1"_blobplot_proteobacteria.table.txt
actinobacteria_table=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools/new_filter/new_filter_"$1"_blobplot_actinobacteria.table.txt
other_bacteria_table=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools/new_filter/new_filter_"$1"_blobplot_other_bacteria.table.txt
virus_table=/data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools/new_filter/new_filter_"$1"_blobplot_virus.table.txt

echo 'working on '$1

cd /data/SBCS-MartinDuranLab/03-Giacomo/data/$1/blobtools
mkdir new_filter

tail -n +13 $blobplot_original > $blobplot

grep -wi Arthropoda $blobplot >> $host_table
grep -wi Annelida $blobplot >> $host_table
grep -wi Ascomycota $blobplot >> $host_table
grep -wi Brachiopoda $blobplot >> $host_table
grep -wi Chordata $blobplot >> $host_table
grep -wi Cnidaria $blobplot >> $host_table
grep -wi Echinodermata $blobplot >> $host_table
grep -wi Hemichordata $blobplot >> $host_table
grep -wi Mollusca $blobplot >> $host_table
grep -wi Nematoda $blobplot >> $host_table
grep -wi Nemertea $blobplot >> $host_table
grep -wi Platyhelminthes $blobplot >> $host_table
grep -wi Porifera $blobplot >> $host_table
grep -wi Priapulida $blobplot >> $host_table
grep -wi Streptophyta $blobplot >> $host_table
grep -wi Chytridiomycota $blobplot >> $host_table
grep -wi Ciliophora $blobplot >> $host_table
grep -wi Euglenozoa $blobplot >> $host_table
grep -wi Apicomplexa $blobplot >> $host_table
grep -wi Basidiomycota $blobplot >> $host_table
grep -wi Chlorophyta $blobplot >> $host_table
grep -wi Cryptophyta $blobplot >> $host_table
grep -wi Eukaryota-undef $blobplot >> $host_table
grep -wi Evosea $blobplot >> $host_table
grep -wi Haptista $blobplot >> $host_table
grep -wi Mucoromycota $blobplot >> $host_table
grep -wi Placozoa $blobplot >> $host_table
grep -wi Rotifera $blobplot >> $host_table

grep -wi unresolved $blobplot >> $host_table
grep -wi phylum.t.6%s $blobplot >> $host_table
grep -wi no-hit $blobplot >> $host_table

grep -wi Proteobacteria $blobplot >> $proteobacteria_table

grep -wi Actinobacteria $blobplot >> $actinobacteria_table


grep -wi Bacteria-undef $blobplot >> $other_bacteria_table
grep -wi Bacteroidetes $blobplot >> $other_bacteria_table
grep -wi Calditrichaeota $blobplot >> $other_bacteria_table
grep -wi Chlorobi $blobplot >> $other_bacteria_table
grep -wi Cyanobacteria $blobplot >> $other_bacteria_table
grep -wi Firmicutes $blobplot >> $other_bacteria_table
grep -wi Fusobacteria $blobplot >> $other_bacteria_table
grep -wi Ignavibacteriae $blobplot >> $other_bacteria_table
grep -wi Kiritimatiellaeota $blobplot >> $other_bacteria_table
grep -wi Lentisphaerae $blobplot >> $other_bacteria_table
grep -wi Nitrospirae $blobplot >> $other_bacteria_table
grep -wi Planctomycetes $blobplot >> $other_bacteria_table
grep -wi Verrucomicrobia $blobplot >> $other_bacteria_table
grep -wi Chlamydiae $blobplot >> $other_bacteria_table
grep -wi Nitrospinae $blobplot >> $other_bacteria_table
grep -wi Spirochaetes $blobplot >> $other_bacteria_table
grep -wi Thermodesulfobacteria $blobplot >> $other_bacteria_table

grep -wi Viruses-undef $blobplot >> $virus_table
