## Overlap in genes between samples
## Load used libraries
library("UpSetR")
library("dplyr")

# Read & transform data
Mytransform <- function(x){
  is.element(my_genes,x)
}
mutations <- read.csv("genes_rest_Rinput.csv", header=T, sep = "\t")
my_genes <- unique(unlist(mutations))

lapply(mutations, Mytransform)
bin_mutations <- as.data.frame(lapply(mutations, Mytransform))
rownames(bin_mutations) <- my_genes
bin_mutations[bin_mutations=="TRUE"]<- 1
write.csv(bin_mutations, file="Binary_genes", sep = "\t")

# remove empty row
bin_mutations <- bin_mutations[-c(239), ]


# code for visualising
upset(bin_mutations, sets = c("P039",	"P836",	"P837",	"P838",	"P840",	"P707",	"P841",	"P842",	"P749_T",	
                              "P749_G",	"P432",	"P691"),
      order.by = "degree", main.bar.color = c("#EA5D4E") ,sets.bar.color = c("#317EAB"),
      nintersects = NA, point.size = 1.5, line.size = 0.5)

# Get intersects of intrest
res <- subset(bin_mutations,P842==1 & P749_G==1 & P838==0 & P691==0 & P432==1 & P836==0 & P841==1 &
                            P707==1 & P039==0 & P837==1 & P749_T==1 & P840==0)
show(rownames(res))


  