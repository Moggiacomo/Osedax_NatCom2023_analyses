
#!/bin/bash
#$ -wd /data/scratch/btx654/ann_VS_ann_oliveira2022/
#$ -o /data/scratch/btx654/ann_VS_ann_oliveira2022/
#$ -j y
#$ -pe smp 8
#$ -l h_vmem=10G
#$ -l h_rt=36:0:0
#$ -l highmem

#Script to perform a reciprocal blast search
#Usage: bash runRBLAST.sh PATH/TO/QUERY/FILE PATH/TO/DB/FILE PATH/TO/OUTPUTS
#Usage ex: bash runRBLAST.sh PATH/TO/INPUT1/species1.fasta.transdecoder.pep PATH/TO/INPUT2/species2.fasta.transdecoder.pep PATH/TO/OUTPUTS
#qsub runRBLAST.sh /data/scratch/btx654/ann_VS_ann_oliveira2022/oliveira2022_SINGLE.fa /data/scratch/btx654/ann_VS_ann_oliveira2022/Rpac_SINGLE.fa /data/scratch/btx654/ann_VS_ann_oliveira2022/


#Input query file
inputQuery=$1
#Input DB reciprocal file
inputDB=$2
#Path to output results
outputPath=$3
#Move to DB directory
queryPath=$(dirname $inputQuery)

module load anaconda3
conda activate /data/SBCS-MartinDuranLab/03-Giacomo/src/anaconda3/trinotate_env

#cd $queryPath
#Make blastable protein DB of the input query
makeblastdb -in $inputQuery -dbtype prot
#Move to query directory
#dbPath=$(dirname $inputDB)
#cd $dbPath
#Make blastable protein DB of the input DB
makeblastdb -in $inputDB -dbtype prot
#Output start status message
echo "Beginning reciprocal BLAST..."
#Move to outputs folder
#cd $outputPath
#Use blastp to search a database
blastp -query $inputQuery -db $inputDB -max_target_seqs 1 -outfmt 6 -evalue 1e-3 -num_threads 8 > blast.outfmt6
#Switch query and search paths for reciprocal search
blastp -query $inputDB -db $inputQuery -max_target_seqs 1 -outfmt 6 -evalue 1e-3 -num_threads 8 > blast_reciprocal.outfmt6
#Output end status message
echo "Finished reciprocal BLAST!"
