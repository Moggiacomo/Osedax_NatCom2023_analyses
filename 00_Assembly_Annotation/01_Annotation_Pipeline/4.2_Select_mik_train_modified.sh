#link to the script: https://www.dropbox.com/s/kgtty04uwwfig67/select_mik_train.py?dl=0,

module load anaconda3
source activate augustus
cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/annotation_step4
mkdir augustus
cd augustus
mkdir augustus_training
cd augustus_training 
python2 /data/SBCS-MartinDuranLab/03-Giacomo/src/various/select_mik_train_modified.py -f 0.5 -e 2 /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step3/mikado.loci.metrics.tsv /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step3/mikado.loci.gff3 > select_mik_train_modified_log.txt
