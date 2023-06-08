sort -u -k1,1 Oalv_VS_Ofra_missingBUSCO_blastp_out | cut -f 2 | sort -u > uniq_geneIDs_BLAST_oasisia #22 unique proteins of osedax

sort -u -k1,1 osedax_prot_blastp_out | cut -f 2 | sort -u > uniq_geneIDs_BLAST_metazoadb10 #22 unique proteins of osedax
sort -u -k1,1 osedax_prot_blastp_out | cut -f 1,2 > uniq_geneIDs_BLAST_metazoadb10_vs_BUSCO

cut -f 18,19 23_missingBUSCO_found_osedax.xls | grep -f panther_ids_list_osedax | sort -k2,2 | cut -f 1 > 23_geneIDs_osedax_Panther
cut -f 18,19 23_missingBUSCO_found_osedax.xls | grep -f panther_ids_list_osedax | sort -k2,2 | cut -f 2 > 23_pantherIDs_osedax_Panther
nano 23_geneIDs_osedax_Panther_edited > uniq_geneIDs_panther_vs_BUSCO

grep -f panther_IDs_BUSCO_oasisia ../panther_output | cut -f1,2 | sort -k2,2 > 53_BUSCO_vs_panther_oasisia


awk -F"|" 'NR==FNR{a[$1]=$0;next} ($1 in a){b=$1;$1="";print a[b]  $0}' OFS="|" file1 file2
awk 'NR==FNR{a[$2]=$0;next} ($1 in a){b=$2;$1="";print a[b]  $0}' 62_metazoadb10_vs_panther 63_oasisia_geneIDs_vs_panther

join -1 2 -2 2 62_metazoadb10_vs_panther 63_oasisia_geneIDs_vs_panther


while read line; do
echo $line
annotations=$(cut -f 1,2 63_oasisia_geneIDs_vs_panther | fgrep $line)
cat $annotations
kallisto_body=$(cut -f 2 <<< $annotations)
cat $kallisto_body
kallisto_roots=$(cut -f 3 <<< $annotations)
cat $kallisto_roots
echo $kallisto_body$'\t'$kallisto_roots >> oasisia_geneIDs_missingBUSCO_found_osedax_vs_panther
done < oasisia_geneIDs_missingBUSCO_found_osedax


cut -f 1 oasisia_geneIDs_missingBUSCO_found_osedax_vs_panther | sed -e 's/ /\t/g' | sort -k2,2 > oasisia_geneIDs_missingBUSCO_found_osedax_vs_panther_OK
cut -f 2 oasisia_geneIDs_missingBUSCO_found_osedax_vs_panther_OK > oasisia_geneIDs_missingBUSCO_found_osedax_vs_panther_OK_pantherIDs
grep -f oasisia_geneIDs_missingBUSCO_found_osedax_vs_panther_OK_pantherIDs 62_metazoadb10_vs_panther | sort -k2,2 > missingBUSCO_found_osedax_vs_panther_OK

paste missingBUSCO_found_osedax_vs_panther_OK oasisia_geneIDs_missingBUSCO_found_osedax_vs_panther_OK > link_oasisia_geneIDs_BUSCO

cut -f 1 Oalv_VS_Ofra_missingBUSCO_blastp_out | sed 's/Oalv_//' > blast_output_firstColumn


while read line; do
echo $line
annotations=$(cut -f 1,3 link_oasisia_geneIDs_BUSCO | fgrep $line | cut -f 1)
cat $annotations
echo $annotations >> blast_output_firstColumn_vs_metazoadb10
done < blast_output_firstColumn


cut -f 2 Oalv_VS_Ofra_missingBUSCO_blastp_out > blast_output_firstColumn_osedax_geneIDs
paste blast_output_firstColumn_vs_metazoadb10 blast_output_firstColumn_osedax_geneIDs > uniq_geneIDs_BLAST_oasisia_vs_BUSCO

cat BLAST/uniq_geneIDs_BLAST_metazoadb10_vs_BUSCO Panther/uniq_geneIDs_panther_vs_BUSCO Panther/oasisia_blast/uniq_geneIDs_BLAST_oasisia_vs_BUSCO > ALL_matches_osedax_vs_metazoadb10

sort -u -k1,1 ALL_matches_osedax_vs_metazoadb10 | sort -u -k1,2 | wc -l #26
