#!/bin/bash

#$ -q all.q
#$ -N igvtools_tdf
#$ -l h_vmem=3G
#$ -V
#$ -cwd
#$ -m be
#$ -M L.van_Grieken@lumc.nl
#$ -pe BWA 4


/usr/local/sasc/programs/IGVTools/igvtools_2.3.80/igvtools count phased_possorted_bam.bam ETH-6.tdf hg38.chrom.sizes