awk '{print $2}' oasisia_KAAS_custom_SBH.txt > only_KOnumbers.txt
#add a line at the top of this file saying "KO_number"
nano only_KOnumbers.txt
paste oasisia_annotation_Dec2020_TrinoPanther.xls only_KOnumbers.txt > oasisia_annotation_Jan2021_TrinoPanther.xls
