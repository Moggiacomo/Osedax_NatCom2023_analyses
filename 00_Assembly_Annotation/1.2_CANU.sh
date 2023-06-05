module load gnuplot
module load java/1.8.0_152-oracle

#Depending on the cluster one might need to modify the file canu-1.8/Linux-amd64/lib/site_perl/canu/Grid_SGE.pm:
#change #"-pe threads THREADS"); with #"-pe smp THREADS"); and  #"-l mem=MEMORY"); with #"-l h_vmem=MEMORY");

canu \
 -p Oasisia \
 -d Oasisia_dir \
 -pacbio-raw Oasisia_pb_raw.fastq.gz \
 genomeSize=1g \
 useGrid=true \
 gridEngineResourceOption="-l h_vmem=MEMORY -pe smp THREADS" \
 gridOptions="-l h_rt=72:0:0 -j y -l highmem" \
 "batOptions=-dg 3 -db 3 -dr 1 -ca 500 -cp 50" \
 "gridOptionsGFA=-l h_vmem=300G" \
 "gridOptionsovb=-l h_vmem=120G" \
 "gridOptionsovs=-l h_vmem=120G" \
 "gridOptionscorovl=-l h_vmem=30G" \
 "gridOptionscor=-l h_vmem=30G" \
 "gridOptionscns=l h_vmem=40G" \
 gnuplot=$(which gnuplot) \
 java=$(which java) > Oasisia_dir/LOG/LOG 2>&1
