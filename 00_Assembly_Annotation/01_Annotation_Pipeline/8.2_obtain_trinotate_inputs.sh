#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 1
#$ -l h_vmem=20G
#$ -l h_rt=72:0:0
#$ -l highmem

species=$1
fasta_mRNA="$species"_mRNA.fa
fasta_CDS="$species"_CDS.fa
fasta_proteins="$species"_proteins.fa
gene_trans_map="$species".gene_trans_map

echo "Working on "$species

cd /data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step8/

grep ">" $fasta_mRNA | awk '{ print $2"(+)"}' > positions.txt
sed -i 's/CDS=/:/' positions.txt

awk '/^>/ {if (seqlen){print "len:"seqlen}; print ;seqlen=0;next; } { seqlen += length($0)}END{print "len:"seqlen}' $fasta_proteins | grep -v ">" > lenghts.txt

grep ">" $fasta_proteins > names.txt
sed 's/>//' names.txt > names_clean.txt

sed '/^>/s/ .*//' $fasta_mRNA > input_trinotate_mRNA.fa

cp $fasta_proteins input_trinotate_proteins.fa
INDEX=1
while read -r line
do
original_name=$(echo $line)
lenght=$(head -$INDEX lenghts.txt | tail -1)
name_clean=$(head -$INDEX names_clean.txt | tail -1)
position=$(head -$INDEX positions.txt | tail -1)

sed -i "s/$original_name/$original_name $lenght $name_clean$position/" input_trinotate_proteins.fa

INDEX=$((INDEX+1))
done < names.txt


grep ">" input_trinotate_proteins.fa > full_names.txt
sed -i 's/>//' full_names.txt

INDEX=1
while read -r line
do
full_name=$(echo $line)
name_clean=$(head -$INDEX names_clean.txt | tail -1)

echo -e $full_name'\t'$name_clean >> $gene_trans_map

INDEX=$((INDEX+1))
done < full_names.txt
