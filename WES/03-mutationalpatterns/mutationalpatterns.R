library(BSgenome)
library(MutationalPatterns)
library(gridExtra)

ref_genome <- "BSgenome.Hsapiens.UCSC.hg38"
library(ref_genome, character.only = TRUE)

files <- list.files("/vcf_files/", patter=".vcf", full.names=TRUE)
sample_names <- c("wes1", "wes2", "wes3", "wes4", "wes5",
                  "wes6", "wes7", "ref1", "ref2", "ref3",
                  "ref4", "ref5", "ref6", "ref7", "ref8",
                  "ref9", "ref10", "ref11", "ref12", "ref13",
                  "ref15", "ref16", "ref17", "ref18", "ref19",
                  "ref20", "ref21", "ref22", "ref23", "ref26",
                  "ref29", "ref30", "ref31", "ref32",
                  "ref34", "ref35", "ref36", "ref38", "ref39", "ref40")
vcfs <- read_vcfs_as_granges(files, sample_names, ref_genome)
summary(vcfs)

soorten <- c(rep("wes", 7), rep("ref", 33))

muts = mutations_from_vcf(vcfs[[1]])
head(muts, 12)

types = mut_type(vcfs[[1]])
head(types, 12)

context = mut_context(vcfs[[1]], ref_genome)
head(context, 12)

type_context = type_context(vcfs[[1]], ref_genome)
lapply(type_context, head, 12)

type_occurrences <- mut_type_occurrences(vcfs, ref_genome)
#Plot mutation spectrum 
p1 <- plot_spectrum(type_occurrences)
#Plot mutation spectrum with distinction between C>T at CpG sites and other sites
p2 <- plot_spectrum(type_occurrences, CT = TRUE)
#Plot mutation spectrum without legend
p3 <- plot_spectrum(type_occurrences, CT = TRUE, legend = FALSE)

grid.arrange(p1, ncol=1, widths=c(3))

#Plot with point mutation type sorted by WES (our data) and REF (reference data)
p4 <- plot_spectrum(type_occurrences, by = soorten, CT=TRUE, legend=TRUE)
palette <- c("pink", "orange", "blue", "lightblue", "green", "red", "purple")
p5 <- plot_spectrum(type_occurrences, CT=TRUE, colors=palette)
grid.arrange(p4, p5, ncol=2, widths=c(4,2.3))

#Plot mutational profiles
mut_mat <- mut_matrix(vcf_list = vcfs, ref_genome = ref_genome)
plot_96_profile(mut_mat[,c(1:15)], condensed = TRUE)


sp_url <- paste("https://cancer.sanger.ac.uk/cancergenome/assets/", "signatures_probabilities.txt", sep = "")
cancer_signatures = read.table(sp_url, sep = "\t", header = TRUE)
new_order = match(row.names(mut_mat), cancer_signatures$Somatic.Mutation.Type)
# Reorder cancer signatures dataframe
cancer_signatures = cancer_signatures[as.vector(new_order),]
# Add trinucletiode changes names as row.names
row.names(cancer_signatures) = cancer_signatures$Somatic.Mutation.Type
# Keep only 96 contributions of the signatures in matrix

sbs_signatures = read.table("signatures/sigProfiler_SBS_signatures_2019_05_22.csv", sep=",", header=TRUE)
new_order = row.names(mut_mat) <- sbs_signatures$Type
sbs_signatures = sbs_signatures[as.vector(new_order),]

row.names(sbs_signatures) = sbs_signatures$Type

sbs_signatures = as.matrix(sbs_signatures)
cancer_signatures = as.matrix(cancer_signatures[,4:33])
cancer_signatures = as.matrix(cancer_signatures)
plot_96_profile(cancer_signatures)

cos_sim_samples_signatures = cos_sim_matrix(mut_mat, cancer_signatures)
hclust_cosmic = cluster_signatures(cancer_signatures, method = "average")
cosmic_order = colnames(cancer_signatures)[hclust_cosmic$order]
plot_cosine_heatmap(cos_sim_samples_signatures, col_order = cosmic_order, cluster_rows = TRUE)

fit_res <- fit_to_signatures(mut_mat, cancer_signatures)
select <- which(rowSums(fit_res$contribution) > 10)
#Select a color pallete
only7 <- c("#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#7dfc00","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff","#ffffff")
normal <- c("#5d4c86","#d74d4c","#ffff00","#8ad8e8","#0ec434","#7dfc00","#228c68","#425b54","#29bdab","#3998f5","#04ffff","#37294f","#3750db","#f22020","#991919","#ffcba5","#e68f66","#c56133","#96341c","#632819","#ffc413","#f47a22","#2f2aa0","#b732cc","#772b9d","#f07cab","#d30b94","#edeff3","#c3a5b4","#946aa2")

#Barplot of signature contributions
plot_contribution(fit_res$contribution[select,], cancer_signatures[,select],coord_flip = FALSE,mode = "absolute", palette = normal)

#Heatmap of signature contributions
plot_contribution_heatmap(fit_res$contribution,cluster_samples = TRUE,method = "complete",)

