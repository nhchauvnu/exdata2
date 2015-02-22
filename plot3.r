library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
btm = filter(NEI,fips=='24510') # Baltimore, Maryland
gr = group_by(btm, type, year)
s1 = summarize(gr, total=sum(Emissions))
g = ggplot(data=s1, aes(x=as.character(year),y=total, group=type, col=type))
g = g+geom_line()+geom_point()
g = g+xlab('Year') + ylab('Emission amount (tons)')
g = g+ggtitle('Emission from PM2.5 in the Baltimore City\nbroken down by source, 1999-2008')
g
png('plot3.png',width=640,height=480)
print(g)
dev.off()