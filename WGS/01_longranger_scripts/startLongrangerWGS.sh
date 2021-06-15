#!/bin/bash

#$ -q all.q
#$ -N StartLongranger_WGS
#$ -l h_vmem=67G
#$ -V
#$ -cwd
#$ -m be
#$ -M L.van_Grieken@lumc.nl
#$ -pe BWA 12

/exports/sascstudent/liana/longranger-2.2.2/longranger wgs --id=ETH-6_Version2 --fastqs=/exports/sascstudent/liana/HLKG2CCXY/outs/fastq_path/ --reference=/exports/sascstudent/liana/refdata-GRCh38-2.1.0/ --vcmode=gatk:/usr/local/sasc/programs/gatk/GenomeAnalysisTK-3.7.0/GenomeAnalysisTK.jar --localcores=12 --localmem=800
