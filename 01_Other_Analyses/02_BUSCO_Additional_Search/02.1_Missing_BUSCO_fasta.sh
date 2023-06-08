sed 's/a//g' missing_busco_list.tsv | sed 's/^/>/' > missing_busco_list_OK.txt 

cp /data/SBCS-MartinDuranLab/03-Giacomo/db/datasets/metazoa_odb10/ancestral ./
mv ancestral ancestral.fa

module load seqtk
seqtk subseq /data/scratch/btx654/missing_busco_osedax/busco_downloads/lineages/metazoa_odb10/ancestral missing_busco_list.txt  > missing_busco.fa
