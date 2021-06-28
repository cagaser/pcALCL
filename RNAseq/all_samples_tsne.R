library(Rtsne)
library(plotly)

counttable <- as.matrix(read.table("all_samples.fragments_per_gene.tsv", row.names="feature", header=T, check.names=F, sep="\t"))
design_file <- read.csv("samples.csv", row.names="sample", header=T, check.names=F)

#### remove genes with low read count ####
idx <- which(apply(counttable, 1, sum)==0)
counttable <- counttable[-idx,]
idx <- which(apply(counttable,1, function(x){any(x > 20)}))
counttable <- counttable[idx,]


#### normalize data with DESeq2 ####
sizeFactors.mad <- function (counts, locfunc = median){
  loggeomeans <- rowMeans(log(counts))
  apply(counts, 2, function(cnts) exp(locfunc((log(cnts) - 
                                                 loggeomeans)[is.finite(loggeomeans)])))
}
sf <- sizeFactors.mad(counttable)

#countdata delen door de sizefactors#
counttable.norm <- counttable
for(i in 1:ncol(counttable.norm)){counttable.norm[,i] <- counttable.norm[,i]/sf[i]}


#### tsne ####
set.seed(12345)
tsne_model_1 <- Rtsne(
  t(counttable.norm),
  check_duplicates = FALSE,
  perplexity = 5,
  initial_dims = 36,
  dims = 2,
  max_iter = 2000,
  normalize = FALSE,
  eta = 250)

tsne_data <- as.data.frame(tsne_model_1$Y)

p <- plot_ly(
  data = tsne_data,
  x = ~V1,
  y = ~V2,
  type = "scatter",
  mode = "markers",
  marker = list(size=15,
                line = list(color = '#999999',
                            width = 1)),
  color = factor(design_file$detailed_group)) %>%
  plotly::layout(
    title = "t-SNE Cluster",
    xaxis = list(title = "tSNE 1"),
    yaxis = list(title = "tSNE 2")) %>%
  config(
    toImageButtonOptions = list(
      format = "svg",
      filename = "t-SNE_plot",
      width = 1000,
      height = 600
    )
  )
p
