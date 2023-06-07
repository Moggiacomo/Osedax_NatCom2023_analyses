cd /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step3
cp mikado.loci.exh.gff /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/annotation_step4/augustus
cd /data/SBCS-MartinDuranLab/03-Giacomo/data/oasisia/annotation/new_annotation_Nov2020/step4/exonerate
cp *parsed.exh.gff /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/annotation_step4/augustus

cd /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/annotation_step4/augustus

cat mikado.loci.exh.gff oasisia_oweniaProt_Exo_parsed.exh.gff oasisia_lamellibrachiaProt_Exo_parsed.exh.gff oasisia_capitellaProt_Exo_parsed.exh.gff oasisia_O_A__1C.intronhints.gff oasisia_O_A__1O.intronhints.gff oasisia_O_A__1T.intronhints.gff oasisia_O_A__2C.intronhints.gff oasisia_O_A__2O.intronhints.gff oasisia_O_A__2T.intronhints.gff > oasisia_merged_hints.gff
