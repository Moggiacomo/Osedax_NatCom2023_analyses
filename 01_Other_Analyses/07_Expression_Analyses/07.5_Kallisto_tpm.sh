#!/bin/bash
cut -f 1 oasisia_1_mapping/abundance.tsv | tail -n +2 > genes
for i in {1..6}
do
   cut -f 5 oasisia_"$i"_mapping/abundance.tsv | tail -n +2 > tpm_"$i"
done
paste genes tpm_1 tpm_2 tpm_3 tpm_4 tpm_5 tpm_6 > intermediate_file
echo "target_id"$'\t'"crown_1"$'\t'"opistosoma_1"$'\t'"trophosome_1"$'\t'"crown_2"$'\t'"opistosoma_2"$'\t'"trophosome_2" > oasisia_kallisto_tpm.tsv
cat intermediate_file >> oasisia_kallisto_tpm.tsv
