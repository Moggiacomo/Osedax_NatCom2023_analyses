cd /data/scratch/btx654/RNAseq/
cd $species
mkdir -p kallisto
cd kallisto

cp $species_softmasked_path ./
cp $final_annotation_path ./


gffread -w oasisia_mRNA.fa -g oasisia_Nov2020_softmasked.fa oasisia_annotation_v101220.gff3
