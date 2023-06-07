
#!/bin/bash
#$ -wd /data/scratch/btx604/
#$ -j y
#$ -o /data/scratch/btx604/
#$ -pe smp 12
#$ -l h_vmem=30G
#$ -l h_rt=240:0:0
#$ -l highmem

#All the programs that we need (Busco and Quast as well) are inluded in the following unique and universal script. It just needs a directory “purge_dups” containing the output of blobtools (e.g. oasisia_host.fasta) and it should be submitted like this:
#this script must be launched like so: qsub purge_dups_v2.sh $1 $2  - $1 is the species name (e.g. oasisia) - $2 is the absolute path to the PacBio raw reads obtained transforming subreads.bam into fq.gz with BAM2fastx tools 19/08/19 (e.g. /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/00-pacbio/oasisia_pb_raw.fastq.gz )


#variables
ref_genome=/data/scratch/btx604/$1/purge_dups/"$1"_host.fasta
pb_fasta=$2
ref_genome_split=/data/scratch/btx604/$1/purge_dups/"$1"_host.split.fasta
self_aln_genome=/data/scratch/btx604/$1/purge_dups/"$1"_host.split.self.paf.gz


cd /data/scratch/btx604/$1/purge_dups/

echo 'working on '$1

echo 'MINIMAP2 ______________________________________________________________________'
if [ -e ./purge_"$1".paf.gz ]
then
  echo "purge_$1.paf.gz found"
else
  module load anaconda2
  source activate Minimap2

  minimap2 -x map-pb $ref_genome $pb_fasta | gzip -c - > purge_$1.paf.gz

  source deactivate
  module unload anaconda2
fi

echo 'PBCSTAT _______________________________________________________________________'
if [ -e ./PB.base.cov ]
then
  echo "PB.base.cov found"
else
  module load python

  /data/SBCS-MartinDuranLab/03-Giacomo/src/purge_dups/bin/pbcstat *.paf.gz #(produces PB.base.cov and PB.stat files)

  module unload python
fi

echo 'CALCUTS _______________________________________________________________________'
if [ -e ./calcults.log ]
then
  echo "calcults.log found"
else
  module load python

  /data/SBCS-MartinDuranLab/03-Giacomo/src/purge_dups/bin/calcuts PB.stat > cutoffs 2> calcults.log

  module unload python
fi

echo 'SPLIT_FA ______________________________________________________________________'
if [ -e "$ref_genome_split" ]
then
  echo "$ref_genome_split found"
else
  module load python

  /data/SBCS-MartinDuranLab/03-Giacomo/src/purge_dups/bin/split_fa $ref_genome > $ref_genome_split

  module unload python
fi

echo 'MINIMAP2 ______________________________________________________________________'
if [ -e "$self_aln_genome" ]
then
  echo "$self_aln_genome found"
else
  module load anaconda2
  source activate Minimap2

  minimap2 -x asm5 -DP $ref_genome_split $ref_genome_split | gzip -c - > $self_aln_genome

  source deactivate
  module unload anaconda2
fi

echo 'PURGE_DUPS ____________________________________________________________________'
if [ -e ./purge_dups.log ]
then
  echo "purge_dups.log found"
else
  module load python

  /data/SBCS-MartinDuranLab/03-Giacomo/src/purge_dups/bin/purge_dups -2 -T cutoffs -c PB.base.cov $self_aln_genome > dups.bed 2> purge_dups.log

  module unload python
fi

echo 'GET_SEQS ______________________________________________________________________'
if [ -e ./hap.fa ]
then
  echo "hap.fa found"
else
  module load python

  /data/SBCS-MartinDuranLab/03-Giacomo/src/purge_dups/bin/get_seqs dups.bed $ref_genome > purged.fa 2> hap.fa

  module unload python
fi

echo 'BUSCO _________________________________________________________________________'
if [ -e ./busco/ ]
then
  echo "hap.fa found"
else
  module load busco/3.0
  module load augustus
  export AUGUSTUS_CONFIG_PATH=/data/SBCS-MartinDuranLab/02-Chema/src/Augustus/config

  mkdir busco
  cd ./busco/

  BUSCO.py -i ../purged.fa -m genome -o busco -f -c 4 -l /data/home/btx604/datasets/metazoa_odb9

  cd ..

  module unload busco/3.0
  module unload augustus
fi

echo 'QUAST _________________________________________________________________________'
if [ -e ./quast/ ]
then
  echo "quast found"
else
  module load anaconda2
  source activate quast

  mkdir quast
  quast \
   ./purged.fa \
   -o ./quast \
   --eukaryote \

  source deactivate
  module unload anaconda2
fi
