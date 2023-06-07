#Link to gtfToHintsMik.py: https://www.dropbox.com/s/wqmwlj6c9dn440l/gtfToHintsMik.py?dl=0


module load anaconda3
conda activate augustus
cd /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step3
# Convert gff3 to gtf (-T flag) and keep only coding transfrag (-C flag), highlighting any error (-E flag)
gffread -T -E -C -o mikado.loci.gtf mikado.loci.gff3
python2 /data/SBCS-MartinDuranLab/03-Giacomo/src/various/gtfToHintsMik.py mikado.loci.gtf
