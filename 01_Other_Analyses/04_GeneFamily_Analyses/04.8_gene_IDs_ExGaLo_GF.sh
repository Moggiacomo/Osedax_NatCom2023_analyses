cut -f 1,7 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep -w Rpac | cut -f 1 > gene_families_expanded_riftia.txt #families expanded in riftia
fgrep -f gene_families_expanded_riftia.txt ../../Orthogroups.csv > gene_families_expanded_riftia.csv
cut -f 1,24 gene_families_expanded_riftia.csv | sed 's/Rpac|//g' | cut -f 2 | sed 's/, /\n/g' > gene_IDs_expanded_riftia.txt


cut -f 1,4 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep -w Rpac | cut -f 1 > gene_families_originated_riftia.txt #families expanded in riftia
fgrep -f gene_families_originated_riftia.txt ../../Orthogroups.csv > gene_families_originated_riftia.csv
cut -f 1,24 gene_families_originated_riftia.csv | sed 's/Rpac|//g' | cut -f 2 | sed 's/, /\n/g' > gene_IDs_originated_riftia.txt


cut -f 1,6 ../../orthofinder_ultrasensitive_stats_Jun2021.tsv | grep -w Rpac | cut -f 1 > gene_families_lost_riftia.txt
grep -f gene_families_lost_riftia.txt owenia_all_GF > losses_riftia_owenia 
fgrep -f losses_riftia_owenia ../../Orthogroups.csv > gene_families_lost_riftia_owenia.csv
cut -f 1,21 gene_families_lost_riftia_owenia.csv | sed 's/Ofus|//g' | cut -f 2 | sed 's/, /\n/g' > gene_IDs_lost_riftia_owenia.txt
