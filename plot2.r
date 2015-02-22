library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
# Using dplyr functions
btm = filter(NEI,fips=='24510') # Baltimore, Maryland
gr = group_by(btm, year)
s1 = summarize(gr, total=sum(Emissions))
png('plot2.png', width=480, height=480)
ymax = ceiling(max(s1$total/1000))*1000
barplot(s1$total, names.arg=s1$year, main="Total emission from PM2.5 in the Baltimore City, 1999-2008",
	xlab="Year", ylab="Emission amount (tons)", ylim=range(0:ymax))
am = sprintf("%.1f",s1$total)
n = length(s1$total)
for (i in 1:n) text(x=i,y=s1$total[i]+70, am[i])
dev.off()
