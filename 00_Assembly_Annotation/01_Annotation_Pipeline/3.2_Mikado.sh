#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 10
#$ -l h_vmem=10G
#$ -l h_rt=120:0:0
#$ -l highmem

species=$1
mikadoInput_list="$species"_mikadoInput_list.txt
species_softmasked=oasisia_Nov2020_softmasked.fa
portcullis=portcullis_"$species".bed

echo "Working on "$species

module load anaconda3
source activate mikado_v3

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/
cp /data/SBCS-MartinDuranLab/00-BlastDBs/Uniprot_SwissProt_210720.fasta ./

makeblastdb -in Uniprot_SwissProt_210720.fasta -dbtype prot -parse_seqids > blast_prepare.log

# All required files (gtfs and filtered junctions) are in the folder ./mikado_input and the file Owenia_mikadoInput_list.txt points to them. First step is generate configuration file
mikado configure -t 6 --list $mikadoInput_list --reference $species_softmasked --mode permissive --scoring mammalian.yaml --copy-scoring mammalian.yaml --junctions $portcullis -bt Uniprot_SwissProt_210720.fasta configuration.yaml

mikado prepare --json-conf configuration.yaml

blastx -max_target_seqs 5 -num_threads 10 -query mikado_prepared.fasta -outfmt 5 -db Uniprot_SwissProt_210720.fasta -evalue 1e-6 2> blast.log | sed '/^$/d' | gzip -c - > mikado.blast.xml.gz

TransDecoder.LongOrfs -t mikado_prepared.fasta

TransDecoder.Predict -t mikado_prepared.fasta

# serialise and pick
mikado serialise --procs 1 --json-conf configuration.yaml --xml mikado.blast.xml.gz --orfs mikado_prepared.fasta.transdecoder.bed --blast_targets Uniprot_SwissProt_210720.fasta --transcripts mikado_prepared.fasta --junctions $portcullis

mikado pick --procs 10 --json-conf configuration.yaml --subloci-out mikado.subloci.gff3
