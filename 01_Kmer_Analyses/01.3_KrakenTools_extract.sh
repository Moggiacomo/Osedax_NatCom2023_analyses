module load anaconda3
conda activate kraken2_env
extract_kraken_reads.py -k oasisia_pacbio_bbmap_output.kraken -r report_kraken2_pacbio_bbmap -s oasisia_pacbio_corrected_bbmap.fasta --taxid 2 --exclude --include-children -o oasisia_nonBacteria_pacbio_corrected_bbmap.fasta
