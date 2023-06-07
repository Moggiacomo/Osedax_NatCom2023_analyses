#!/bin/bash
#$ -wd /data/scratch/btx654/
#$ -o /data/scratch/btx654/
#$ -j y
#$ -pe smp 12
#$ -l h_vmem=20G
#$ -l h_rt=240:0:0
#$ -l highmem

mkdir -p gene_family_evolution
cd gene_family_evolution
mkdir -p orthofinder_ultra_sensitive_Jun2021
cd orthofinder_ultra_sensitive_Jun2021
module load anaconda3
conda activate /data/SBCS-MartinDuranLab/03-Giacomo/src/anaconda3/orthofinder_env

cp -r /data/SBCS-MartinDuranLab/03-Giacomo/NR_proteomes/ ./
echo "(Nvec,(Hmia,(((Skow,Spur),(Blan,(Locu,Hsap))),((Smar,Tcas),(Smed,(((Lgig,Gaeg),(Cgig,(Myes,Bpla))),(((Ofus,(Dgyr,(((Lluy,(Pech,(Oalv,Rpac))),Ofra),(Ctel,(Hrob,Eand)))))),(Ngen,(Paus,Lana)))))))));" > SpeciesTree.nwk
#Run orthofinder with mmseqs and inflation of 2
orthofinder -f NR_proteomes -t 12 -S diamond_ultra_sens -I 2 -s SpeciesTree.nwk
