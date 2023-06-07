library(ggplot2)
library(plyr)
library(reshape2)
library("RColorBrewer")

lm <- melt(table_oasisia_Feb2021, id.vars=0:1)

ggplot(data=lm, aes(x=lm$Div, y=lm$value, fill=lm$variable))+geom_bar(stat="identity")+labs(x="Kimura Substitution Level (%)", y="Genome Proportion")+ scale_fill_brewer(name=element_blank(), palette="Set3")+theme_bw(base_size = 14)

ggplot(pie_oasisia_Feb2021, aes(x = "", y=percentage, fill=name, order=pie_oasisia_Feb2021$name)) +
    geom_bar(width = 1, stat = "identity", color = "white") +
    coord_polar("y", start = 0) +
    scale_fill_brewer (name=element_blank(), palette="Set3") +
    theme_void()
