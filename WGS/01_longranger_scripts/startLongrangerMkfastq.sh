#!/bin/bash

#$ -q all.q
#$ -N StartLongranger_mkfastq
#$ -l h_vmem=10G
#$ -V
#$ -cwd
#$ -m be
#$ -M L.van_Grieken@lumc.nl
#$ -pe BWA 12

module load bcl2fastq/2.17.4

/usr/local/10xgenomics/longranger-2.1.3/longranger mkfastq --run=/exports/huid-derl/10xGenomics/ --csv=sampleSheet.csv 