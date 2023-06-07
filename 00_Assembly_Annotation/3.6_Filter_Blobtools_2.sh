#!/bin/bash
#$ -wd /data/scratch/btx604/
#$ -o /data/scratch/btx604/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=1G
#$ -l h_rt=1:0:0

#This script is working on subsets depending on taxa of blobtools tables (e.g. oasisia_blobplot_host.table.txt)
#This script will create a list of contig names (one per line) that will then be used to extract fasta sequences. It requires 3 inputs from the command line: $1 is the name to one of the tables we obtained before, $2 is the taxa of the organisms contained in the table (e.g. Actinobacteria, host…) and $3 is the path of the directory containing the input file and where you want to place the output.

#variables
input=$1
taxa=$2
working_directory=$3
output=headers_"$2".txt

cd $working_directory
touch $output

while IFS= read -r line 
do
 echo $line | awk '{print $1;}' >> $output
done < $input
