#First create a folder containing the outputs of GMAP (gff3 files), the outputs of STAR (gtf files), the BED outputs of portcullis (/data/scratch/btx654/btx604-scratch/riftia/portcullis/R_P__3C/riftia_R_P__3C_portcullis/3-filt/portcullis_filtered.pass.junctions.bed) and the softmasked genome for each species. /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3

#Generate configuration file and merge all input files into a single “all-contained” GTF file
#As a first step, one needs to generate a configuration file that tells Mikado where all input evidences are, what type they are, whether they are stranded or not, and what value should Mikado add to each of them. (TAB separated file). 

#oasisia: oasisia_mikadoInput_list.txt (Be sure this is TAB separated)

#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_O_A__1C_transcripts.gtf       stringtie1      True    0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_O_A__1O_transcripts.gtf       stringtie2      True    0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_O_A__1T_transcripts.gtf       stringtie3      True    0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_O_A__2C_transcripts.gtf       stringtie4      True    0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_O_A__2O_transcripts.gtf       stringtie5      True    0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_O_A__2T_transcripts.gtf       stringtie6      True    0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_crown_trinity_Vs_Genome_gmap.gff3        gmap1   True   -0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_opistosoma_trinity_Vs_Genome_gmap.gff3    gmap2   True   -0.5
#    /data/scratch/btx654/btx604-scratch/oasisia/new_annotation_Nov2020/step3/oasisia_trophosome_trinity_Vs_Genome_gmap.gff3    gmap3   True   -0.5



module load anaconda3
source activate portcullis

junctools set -m 1 -o portcullis_oasisia.bed union portcullis_O_A__1C_filtered.pass.junctions.bed portcullis_O_A__1O_filtered.pass.junctions.bed portcullis_O_A__1T_filtered.pass.junctions.bed portcullis_O_A__2C_filtered.pass.junctions.bed portcullis_O_A__2O_filtered.pass.junctions.bed portcullis_O_A__2T_filtered.pass.junctions.bed
