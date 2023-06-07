#working directory:
#/data/scratch/btx654/btx604-scratch/$species/New_annotation_Dec2020/step5

#in the working directory there must be:

#- softmasked genome as “$species”_softmasked.fa
#- mikado.loci.gff3
#- Augustus output as “$species”.aug.out
#- alignAssembly.config and annotCompare.config with the right paths specified


module load anaconda3
conda activate agat_env
agat_convert_sp_gxf2gxf.pl -g mikado.loci.gff3 -o mikado.loci.AGAT.gff3
#grep "ncRNA" mikado.loci.AGAT.gff3 | awk '{print $9}' | uniq > mikado.ncRNA.IDs
grep "ncRNA" mikado.loci.AGAT.gff3 | awk '{print $9}' | uniq | sed "s/=/\t/" | sed "s/;/\t/" | awk '{print $2}' > mikado.ncRNA.IDs
fgrep -v -w -f mikado.ncRNA.IDs mikado.loci.AGAT.gff3 > mikado.loci.AGAT.NOncRNA.gff3
