The scripts used for processing RNA and DNA samples from CALCL patients and normal controls. The directory is divided by folders were each of the scripts and settings are placed. This README will explain the content and purpose of each of the directories.

# WGS
Scripts for processing 13 WGS samples with 10X long read platform. 

## 01_longranger_scripts
Processing the WGS data from 10xGenomics. The folder contains the start script for processing raw sequence files and starting the aligning and SV calling process. The pipeline will first transform the raw bcl folder to a fastq format. Then the second pipeline from longranger will be started and this will align the data to hg38 reference genome and the SV calling will be done. 

## 02_annotate_WGS
Annotating the generated bed files from the Longranger pipeline. The script finds Ensembl ID, gene name and strand with the coordinates that are present in the BED file.

## 03_visualization

### Circos
These are the settings that have been used to make Circos plots. 

### MakeTDF
For a faster overview of the coverage in IGV. The start script to call the software package igvtools count to transform the bam file to a tdf file. It needs the chromosome sizes of hg38 as extra information to run successful. 

### StackedBar_Plot
A python script used to transform and visualize data to show for each sample the number of SV events in the chromosomes. It takes all the files from the input directory and checks for bedpe format. It then counts the chromosomes where a breakpoint is present and visualizes this as a stacked bar plot. It does this for all the samples.

### Upset_Plot
A R script used to visualize the number of SV that are present in multiple samples. It first transforms a file with genes names per sample to a binary table. The row names are the gene names present in the datasets and the columns are samples names. It then places a 0 if gene is not present in set and a 1 if it is present. With the upset package it then gets transformed to a plot. 

## 04_FreeC
Scripts and setting files for CNA analysis using FreeC and GISTIC2.

## 05_variantcalling
Scripts and setting files used for variant calling using bam files generated by the longranger pipeline. Biowdl pipeline was used to call GATK best practice commands (https://github.com/biowdl/gatk-variantcalling/commit/fe6be1ad30ea171c234aa106f5fe704b9130ca53).

# WES
Scripts for processing 7 tumor/normal sample pairs for somatic mutation analysis.

## 01-somaticvariant
BioWDL Pipeline version 1.1.0 run configuration files for somatic variant data analysis. BWA v0.7.15 was used for aligning reads to GRCh38. Mutect2 from GATK v4.1.2 was used for somatic variant calling. Only PASS variants were used for futher downstream analysis. 

## 02-annotation
VEP annotation scripts for the PASSed somatic variants. 

## 03-mutationalpatterns
Running multiple mutational signature analysis packages to compare with known signatures defined in COSMIC DB. 

# RNAseq
Scripts for processing 12 RNAseq samples and additional CD4 control samples (Arrayexpress E-MTAB-2319). BioWDL RNAseq Pipeline version 1.1.0 was used. Cutadapt (version 2.4) was used for adapters clipping. Reads were further aligned to the mouse reference genome GRCh38 using the STAR aligner (version 2.6.0c). Gene raw read quantification was performed using htseq-count (v0.9.1) with the Ensembl human gene annotation version 94. Only uniquely mapped reads are included. 

To minimize the possibility of missing true somatic variants, we also performed somatic variant detection using tumor RNAseq dataset and normal WES dataset pairs. 
