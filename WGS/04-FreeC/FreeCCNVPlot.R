library('naturalsort')

# Script taken from  http://bioinfo-out.curie.fr/projects/freec/tutorial.html and modified for biopet

#input should be the .bam_rate.txt file from a samples freec output
input <- "/exports/sascstudent/julian/FreeC_results/results_ETH-2/ETH-2_noClipped.bam_ratio.txt"
output <- "ETH-2map"

#
# Load Data
#


dataTable <- read.table( input , header=TRUE)
input_ratio <- data.frame(dataTable)

chromosomes <- naturalsort(levels(input_ratio$Chromosome))
input_ratio$Chromosome <- factor(input_ratio$Chromosome, levels=chromosomes, ordered=T)

sorted_ratio <- input_ratio[order(input_ratio$Chromosome),]
ratio <- input_ratio[order(input_ratio$Chromosome, input_ratio$Start),]

ploidy <- 2
ppi <- 50
plot_margins <- c(3,4,1,2)+0.1
label_positions <- c(2,0.5,0)
CEX <- 1

maxLevelToPlot <- 3
for (i in c(1:length(ratio$Ratio))) {
  if (ratio$Ratio[i]>maxLevelToPlot) {
    ratio$Ratio[i]=maxLevelToPlot
  }
}



# Export the whole genome graph

png(filename = paste(output, ".wg.png",sep=""), width = 50 * ppi, height = 10 * ppi,
    res=ppi, bg = "white")

plot_margins <- c(5,4,5,3)+0.1
label_positions <- c(2,0.5,0)

par(mfrow = c(1,1))
par(mar=plot_margins)
par(mgp=label_positions)
par(xaxs="i", yaxs="i")
par(cex.axis=2, cex.main=2, cex.lab = 2, cex.sub=2)


maxLevelToPlot <- 3
for (i in c(1:length(ratio$Ratio))) {
  if (ratio$Ratio[i]>maxLevelToPlot) {
    ratio$Ratio[i]=maxLevelToPlot
  }
}

for (i in c(1:length(ratio$Start))) {
  ratio$Position[i] = (i-1) *5000 +1
}


plotRatioLT <- 0.10

filteredSet <- ratio#[ ratio$score > plotRatioLT, ]

plot(filteredSet$Position,
     filteredSet$Ratio*ploidy,
     ylim = c(0,maxLevelToPlot*ploidy),
     xlab = paste ("Chr. on genome"),
     ylab = "normalized CN",
     pch = ".",
     cex = CEX,
     cex.lab = 2.5,
     ces.axis=2.5,
     cex.main=2.5,
     cex.sub=2.5,
     col = colors()[88])


title(outer=TRUE)
tt <- which(filteredSet$CopyNumber>ploidy)
points(filteredSet$Position[tt],filteredSet$Ratio[tt]*ploidy,pch = ".",cex = CEX,col = colors()[136])

tt <- which(filteredSet$Ratio==maxLevelToPlot & filteredSet$CopyNumber>ploidy)
points(filteredSet$Position[tt],filteredSet$Ratio[tt]*ploidy,pch = ".",cex = CEX, col = colors()[136])

tt <- which(filteredSet$CopyNumber<ploidy & filteredSet$CopyNumber!= -1)
points(filteredSet$Position[tt],filteredSet$Ratio[tt]*ploidy,pch = ".",cex = CEX,col = colors()[461], bg="black")


for (i in c(1:22, 'X', 'Y')) {
  tt <- which(filteredSet$Chromosome == i)
  print(filteredSet[tt[1],])
  xpos <- filteredSet$Position[tt][1]
  abline(v=xpos, col="grey")
  axis(3, at=xpos, labels=i , las=2, cex.lab = 2.5, cex.main=2.5, cex.axis=2.5, cex.sub=2.5)
}


dev.off()


