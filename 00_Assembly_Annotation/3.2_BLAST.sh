#!/bin/bash
#$ -cwd
#$ -j y
#$ -pe smp 16
#$ -l h_vmem=20G
#$ -l h_rt=120:0:0
#$ -l highmem

module load anaconda2
source activate blast

cd db/blast_nt_v5
update_blastdb.pl --blastdb_version 5 nt --decompress


export BLASTDB=db/blast_nt_v5/

blastn -db nt \
 -query oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta \
 -outfmt "6 qseqid staxids bitscore std" \
 -max_target_seqs 10 \
 -max_hsps 1 \
 -evalue 1e-25 \
 -num_threads 16 \
 -out oasisia/blobtools/nt_v5/blast.out
 
 

cd /data/SBCS-MartinDuranLab/03-Giacomo/src/blobtools2

mkdir -p uniprot

# fetch latest reference proteome database
wget -q -O uniprot/reference_proteomes.tar.gz \
  ftp.ebi.ac.uk/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/$(curl \
    -vs ftp.ebi.ac.uk/pub/databases/uniprot/current_release/knowledgebase/reference_proteomes/ 2>&1 | \
    awk '/tar.gz/ {print $9}')

cd uniprot

tar xf reference_proteomes.tar.gz

# extract and concatenate protein FASTA files
touch reference_proteomes.fasta.gz
find . -mindepth 2 | grep "fasta.gz" | grep -v 'DNA' | grep -v 'additional' | xargs cat >> reference_proteomes.fasta.gz

# extract and concatenate taxid mapping files
echo "accession\taccession.version\ttaxid\tgi" > reference_proteomes.taxid_map
zcat */*.idmapping.gz | grep "NCBI_TaxID" | awk '{print $1 "\t" $1 "\t" $3 "\t" 0}' >> reference_proteomes.taxid_map

# make diamond blast db with taxonomic information included
diamond makedb -p 16 --in reference_proteomes.fasta.gz --taxonmap reference_proteomes.taxid_map --taxonnodes ../taxdump/nodes.dmp -d reference_proteomes.dmnd

cd /data/scratch/btx604/oasisia/blobtools

diamond blastx \
 --query /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/genomePolishing/illumina/oasisia_pilon_step2.fasta \
 --db /data/SBCS-MartinDuranLab/03-Giacomo/src/blobtools2/uniprot/reference_proteomes.dmnd \
 --outfmt 6 qseqid staxids bitscore qseqid sseqid pident length mismatch gapopen qstart qend sstart send evalue bitscore \
 --sensitive \
 --max-target-seqs 1 \
 --evalue 1e-25 \
 --threads 16 \
 > /data/scratch/btx604/oasisia/blobtools/diamond.out
