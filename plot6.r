library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
colnames(SCC) = c('scc','category','shortname','sector','option','scc1','scc2','scc3','scc4')

btm = filter(NEI,fips=='24510'|fips=='06037') # Baltimore, Maryland or Los Angeles, California
SCC$shortname = as.character(SCC$shortname)
mv = grep('motor vehicle', SCC$shortname, ignore.case=T)
cc = SCC[mv,]
neiscc = merge(x=btm, y=cc, by.x="SCC", by.y="scc", all=F)

sname = neiscc$fips
sname = gsub('06037','Los Angeles',sname)
sname = gsub('24510','Baltimore City',sname)
neiscc = cbind(neiscc, sname)
gr = group_by(neiscc, sname, year, shortname)
s1 = summarize(gr, total=sum(Emissions))
g = ggplot(data=s1, aes(x=as.character(year),y=total,group=shortname))+geom_line()+geom_point()+facet_wrap(shortname~sname, ncol=2)
g = g+xlab('Year') + ylab('Emission amount (tons)')
g = g+ggtitle('Comparison of PM2.5 emission from motor vehicles\nin the Baltimore City and Los Angeles\nbroken down by source, 1999-2008')
png('plot6.png', width=480,height=480)
g
dev.off()
