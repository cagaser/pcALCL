#!/bin/bash

#$ -q all.q
#$ -N StartLongranger_WGS
#$ -cwd
#$ -V
#$ -m be
#$ -M L.van_Grieken@lumc.nl

/exports/sascstudent/liana/longranger-2.2.2/longranger wgs --id=ETH-6 --fastqs=/exports/sascstudent/liana/HLKG2CCXY/outs/fastq_path/ --reference=/exports/sascstudent/liana/refdata-GRCh38-2.1.0 --jobmode=/exports/sascstudent/liana/sge.template --overrides=/exports/sascstudent/liana/populate_info_override.json --vcmode=gatk:/usr/local/sasc/programs/gatk/GenomeAnalysisTK-3.5-0/GenomeAnalysisTK.jar
