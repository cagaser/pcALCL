# Top level
This folder contains pipeline settings for RNAseq analysis using https://github.com/biowdl/RNA-seq/tree/v1.1.0

## differential_analysis
This folder contains input files, R script, and output files of the differential gene expression analysis. Differential gene expression analysis was performed using R v3.6.1 with Limma-Voom v3.40.6. Raw read counts are converted to a CPM matrix and filtered based on a cut-off value of log2CPM 10. This is done to remove noise and focus analysis on genes with higher expression. Next, using TMM normalization a normalized count matrix is created that is used as input to Limma-Voom. Benjamini and Hochberg FDR were calculated to define adjusted p-values. Genes with an FDR less than 0.01 were reported to be differentially expressed. Finally, genes differentially expressed with a low log2FC are removed using a log2FC cutoff of 2 and -2.

## fusion_genes
This folder contains the analysis results of fusion gene using STAR-Fusion, Fusioncatcher, and FuMa

### version information of Fusioncatcher
fusioncatcher-build.py 0.99.6a beta
Ensembl database version: 84
Organism: Homo sapiens
Genome version: GRCh38
NCBI Viral Genomes version: 2016-04-25
UCSC database version (hg38): 2015-06-28
RefSeq NCBI database version (downloaded thru UCSC database; hg38): 2016-04-03
Gencode database version: 24
Non-cancer tissues and cells (Babiceanu et al. Nucl. Acids Res. 2016) database version: 2016-04-26
Cell lines (Klijn et al. Nature Biotechnology 2014) database version: 2016-04-26
Prostate Tumor Patients (Robison et al. Cell 2015) database version: 2016-04-26
Pancreatic Tumor Patients (Bailey et al. Nature 2016) database version: 2016-04-26
ChimerDB database version: 2.0
TICdb database version: 2016-04-26
ConjoinG database version: 2016-04-26
CGP database version: 2016-04-26
CACG database version: 2016-04-26
DGD database version: 2016-04-26
GTEx database version (thru FusionAnnotator): 2016-04-26 

### version information of STAR-fusion
* STAR version=STAR_2.5.1b
* GRCh38 Gencode v23

## somatic_variant_calling_with_WES
Besides running standard somatic variant analysis using Whole Exome Sequencing of both tumor and normal samples, we further investigate somatic variants using tumor RNAseq dataset and normal WES dataset again to minimize the possibility of missing true somatic variants. This folder contains code/scripts used for this analysis.

### 01-RNAseq-pipeline
RNAseq pipeline settings used for variant calling using GATK.

### 02-Somatic-variant-calling-pipeline
Pipeline settings used for running mutect2 using the RNAseq tumor and WES normal sample pair (https://github.com/biowdl/somatic-variantcalling/commit/0ff5733df302e2f8199b5ec6b2fc8edccaecfe38)

