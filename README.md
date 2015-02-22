### How to run the R scripts
<li>Download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip</li>

<li>Unzip the NEI_data.zip. The zip file contains two files: PM2.5 Emissions Data (summarySCC_PM25.rds)
and Source Classification Code Table (Source_Classification_Code.rds)</li>

<li>From directory containing two .rds files, run the following shell commands:

<p>Rscript --no-save plot1.r</p>
<p>Rscript --no-save plot2.r</p>
<p>Rscript --no-save plot3.r</p>
<p>Rscript --no-save plot4.r</p>
<p>Rscript --no-save plot5.r</p>
<p>Rscript --no-save plot6.r</p>

The commands create 6 plots named from plot1.png to plot6.png.</li>
