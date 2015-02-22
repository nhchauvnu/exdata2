library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
colnames(SCC) = c('scc','category','shortname','sector','option','scc1','scc2','scc3','scc4')

SCC$shortname = as.character(SCC$shortname)
notall = grep('All combust', SCC$shortname, ignore.case=T)
# notall = 1:0
coal = grep('coal', SCC$shortname[-notall], ignore.case=T)
coalcombust = grep('combust', SCC$shortname[-notall][coal], ignore.case=T)
cc = SCC[-notall,][coal,][coalcombust,]
neiscc = merge(x=NEI, y=cc, by.x="SCC", by.y="scc", all=F)

gr = group_by(neiscc, year, shortname)
s1 = summarize(gr, total=sum(Emissions))
g = ggplot(data=s1, aes(x=as.character(year),y=total,group=shortname))+geom_line()+geom_point()+facet_wrap(~shortname, ncol=2)
g = g+xlab('Year') + ylab('Emission amount (tons)')
g = g+ggtitle('PM2.5 emission from coal combustion-related in the United State\nbroken down by source, 1999-2008')
png('plot4.png', width=896,height=768)
g
dev.off()
