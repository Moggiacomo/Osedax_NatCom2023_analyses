#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -pe smp 1
#$ -l h_vmem=48G
#$ -j y
#$ -l h_rt=72:00:00
#$ -l highmem
#$ -t 1-100


species=$1
target=$2
species_softmasked="$species"_Nov2020_softmasked.fa
species_softmasked_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step1/softmasking/$species_softmasked
target_chunk="$target"_proteome.fa_chunk_"${SGE_TASK_ID}"
target_directory="$target"_chunks
target_path=/data/SBCS-MartinDuranLab/03-Giacomo/data/02-other_proteomes/$target_directory/$target_chunk
output_gff="$species"_"$target"Prot_Exo_"${SGE_TASK_ID}".gff
log="$species"_"$target"Prot_Exo_LOG.txt

module load anaconda3
source activate exonerate

if [ -e "$log" ]
then
  echo "It's the turn of: "$target_chunk >> $log
else
    touch $log
    echo "Working on "$species" using "$target" proteins" >> $log
    echo "It's the turn of: "$target_chunk >> $log
fi

echo "Working on "$species" using "$target" proteins"

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/
mkdir -p annotation_step4
cd annotation_step4
mkdir -p exonerate_conda
cd exonerate_conda
cp $target_path ./

if [ -e "$species_softmasked" ]
then
  echo $species_softmasked" it's here" >> $log
else
    cp $species_softmasked_path ./
fi

# Run exonerate
exonerate --model protein2genome --cores 1 --bestn 3 --showtargetgff T --showvulgar F --maxintron 500000 --fsmmemory 45000 --softmasktarget T $target_chunk $species_softmasked > $output_gff 2>> $log

rm $target_chunk
