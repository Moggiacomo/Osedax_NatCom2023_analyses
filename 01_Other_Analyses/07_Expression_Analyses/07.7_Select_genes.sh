while read line; do
echo $line
annotations=$(cut -f 1,2,3 /Users/giacomo/Dropbox/11-Siboglinids/05-PAPER/00-DATA/06-Metabolism/01-AA/expression/osedax_kallisto_tpm_scaled_ok_ok.tsv | fgrep $line)
cat $annotations
kallisto_body=$(cut -f 2 <<< $annotations)
cat $kallisto_body
kallisto_roots=$(cut -f 3 <<< $annotations)
cat $kallisto_roots
echo $kallisto_body$'\t'$kallisto_roots >> GlycineCleavageSystem_kallisto_tpm_ALLscaled.tsv
done < GlycineCleavageSystem_JUSTgeneIDs_osedax.txt

cut -f 1 GlycineCleavageSystem_kallisto_tpm_ALLscaled.tsv | sed -e 's/ /\t/g' | cut -f 2,3 > GlycineCleavageSystem_kallisto_tpm_ALLscaled_ONLY.tsv
cut -f 1 GlycineCleavageSystem_geneIDs_osedax.txt > firstColumn
paste firstColumn GlycineCleavageSystem_kallisto_tpm_ALLscaled_ONLY.tsv > FINAL_GlycineCleavageSystem_osedax_kallisto_tpm_ALLscaled.tsv
