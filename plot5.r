library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
colnames(SCC) = c('scc','category','shortname','sector','option','scc1','scc2','scc3','scc4')

btm = filter(NEI,fips=='24510') # Baltimore, Maryland
SCC$shortname = as.character(SCC$shortname)
mv = grep('motor vehicle', SCC$shortname, ignore.case=T)
cc = SCC[mv,]
neiscc = merge(x=btm, y=cc, by.x="SCC", by.y="scc", all=F)

gr = group_by(neiscc, year, shortname)
s1 = summarize(gr, total=sum(Emissions))
g = ggplot(data=s1, aes(x=as.character(year),y=total,group=shortname))+geom_line()+geom_point()+facet_wrap(~shortname, ncol=2)
g = g+xlab('Year') + ylab('Emission amount (tons)')
g = g+ggtitle('PM2.5 emission from motor vehicles in the Baltimore City\nbroken down by source, 1999-2008')
png('plot5.png', width=480,height=480)
g
dev.off()
