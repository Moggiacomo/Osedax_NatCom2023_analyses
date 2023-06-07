#!/bin/bash

species=$1
xls="$species"*xls
output="$species"_DNArepair.txt
output2="$species"_DNArepair_count.txt

cut -f 18,19 ../$xls > "$species"_annotations
annotations="$species"_annotations

while read line; do
   Panther_ID=$(cut -f 2 <<< "$line")
   echo $Panther_ID
   genes=$(fgrep "$Panther_ID" $annotations | cut -f 1)
   count=$(fgrep "$Panther_ID" $annotations | wc -l)
   echo $genes
   echo $genes >> $output
   echo $count >> $output2
done < DNA_repair_pantherID.txt
