#Link to script: https://www.dropbox.com/s/bw16z5l1mbtn1w0/exoToHints.py?dl=0


module load anaconda3
conda activate augustus

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/annotation_step4/exonerate_conda

cat oasisia_oweniaProt_Exo_*.gff > oasisia_oweniaProt_Exo.gff
cat oasisia_lamellibrachiaProt_Exo_*.gff > oasisia_lamellibrachiaProt_Exo.gff
cat oasisia_capitellaProt_Exo_*.gff > oasisia_capitellaProt_Exo.gff
#grep -c "^tig" oasisia_oweniaProt_Exo.gff 
#grep -c "^#" oasisia_oweniaProt_Exo.gff 

grep "^tig" oasisia_oweniaProt_Exo.gff > oasisia_oweniaProt_Exo_parsed.gff
grep "^tig" oasisia_lamellibrachiaProt_Exo.gff > oasisia_lamellibrachiaProt_Exo_parsed.gff
grep "^tig" oasisia_capitellaProt_Exo.gff > oasisia_capitellaProt_Exo_parsed.gff

python2 /data/SBCS-MartinDuranLab/03-Giacomo/src/various/exoToHints.py oasisia_oweniaProt_Exo_parsed.gff
python2 /data/SBCS-MartinDuranLab/03-Giacomo/src/various/exoToHints.py oasisia_lamellibrachiaProt_Exo_parsed.gff
python2 /data/SBCS-MartinDuranLab/03-Giacomo/src/various/exoToHints.py oasisia_capitellaProt_Exo_parsed.gff

cp *.exh.gff /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step4/exonerate
