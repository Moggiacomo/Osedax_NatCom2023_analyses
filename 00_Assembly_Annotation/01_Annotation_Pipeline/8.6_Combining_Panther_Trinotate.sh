cd /data/scratch/btx654/btx604-scratch/riftia/annotation_step9
cp /data/SBCS-MartinDuranLab/03-Giacomo/data/riftia/annotation/step8/riftia_annotation_report.xls ./
sort oasisia_Panther > panther_sorted
cut -f 1 panther_sorted > IDs_panther
cut -f 2 annotation_report.xls | tail -n +2 > IDs_all
fgrep -v -f IDs_panther IDs_all > IDs_absentPanther ### There are oasisia:8632 osedax:4052 riftia:8182 genes without Panther annotation
awk '{print $0"\t""NO PTHR""\t""NO HIT"}' IDs_absentPanther > PANTHER_nohits
cat panther_sorted PANTHER_nohits | sort -k 1,1 > Panther_sorted_allgenes
# now we need to remove duplicated lines from panther all genes
awk '!a[$1]++' Panther_sorted_allgenes > Panther_sorted_allgenes_noduplicates
## use vim to add a header in Owenia_Panther_sorted_allgenes so that it matches Trinotate file
# #gene_id        transcript_id        sprot_Top_BLASTX_hit        RNAMMER        prot_id        prot_coords        sprot_Top_BLASTP_hit        Pfam        SignalP        TmHMM        eggnog        Kegg        gene_ontology_BLASTX        gene_ontology_BLASTP        gene_ontology_Pfam        transcript        peptide
paste annotation_report.xls Panther_sorted_allgenes_noduplicates > oasisia_annotation_Dec2020_TrinoPanther.xls
