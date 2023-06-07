#!/bin/bash

species=$1

grep "\sK" "$species"_kofam_result.txt | awk '{print $1"\t"$2}' | sed "s/$species//g" | sed "s/_//g" > "$species"_kofam_result_ok.txt
cut -f 1 "$species"_kofam_result_ok.txt > "$species"_IDs_kofam
#select the genes annotated with KAAS which don't have an annotation with kofam
fgrep -vf "$species"_IDs_kofam  ../$species | tail -n +2 > "$species"_KAAS_only
#combine the annotations using kofam as the primary one
cat "$species"_kofam_result_ok.txt "$species"_KAAS_only > "$species"_combined
