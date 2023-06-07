# TUTORIAL: https://bioinformatics.uconn.edu/genome-size-estimation-tutorial/#outline4
#Using the hist file produced with the script (kat_hist_universal_kraken_standard_illumina_v1.sh 28/10/20) and cropping out of the plot the first area of erroneous kmers as suggested by the tutorial

plot(oasisia_21mer[5:60,], type="l")
# points(oasisia_21mer[5:60,])
# export as a pdf 5 x 5.5 inches in landscape orientation


#here I am assuming I have 10000 data points (which is the length of the hist file)
# 28 is the peak for the homozygous and the result is similar to my assembly size
> sum(as.numeric(oasisia_21mer[5:10000,1]*oasisia_21mer[5:10000,2]))/28
# [1] 785764774

#The other Genome Size estimation was made with "kat_21mer_illumina.hist" using GenomeScope (http://qb.cshl.edu/genomescope/genomescope2.0/analysis.php?code=5hnEsmQKmAf6j8u65ub7)
