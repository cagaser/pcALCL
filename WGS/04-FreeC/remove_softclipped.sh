#!/bin/bash
#$ -S /bin/bash
#$ -q all.q
#$ -N remove_clipping1012
#$ -l h_vmem=4G
#$ -cwd
#$ -j Y
#$ -V
#$ -pe BWA 2
#$ -m be
#$ -M J.H.van_Toledo@lumc.nl
samtools view -h /exports/sascstudent/julian/FreeC_Git/bamfiles/ETH-10_filtered.bam | /exports/sascstudent/julian/Tools/miniconda2/bin/samclip --ref /exports/sascstudent/julian/FreeC_Git/Homo_sapiens_assembly38_phix_stableid.fasta | samtools sort > /exports/sascstudent/julian/FreeC_Git/bamfiles/ETH-10_noClipped.bam
samtools view -h /exports/sascstudent/julian/FreeC_Git/bamfiles/ETH-12_filtered.bam | /exports/sascstudent/julian/Tools/miniconda2/bin/samclip --ref /exports/sascstudent/julian/FreeC_Git/Homo_sapiens_assembly38_phix_stableid.fasta | samtools sort > /exports/sascstudent/julian/FreeC_Git/bamfiles/ETH-12_noClipped.bam

