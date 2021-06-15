#!/bin/bash
#$ -S /bin/bash
#$ -q all.q
#$ -N filter
#$ -cwd
#$ -j Y
#$ -V
#$ -m be
#$ -pe BWA 4
#$ -M J.H.van_Toledo@lumc.nl


samtools view -h -b -q 50 /exports/sascstudent/julian/FreeC_Git/bamfiles/ETH-2.bam > /exports/sascstudent/julian/FreeC_Git/bamfiles/ETH-2_filtered.bam

samtools index /exports/sascstudent/julian/FreeC_Git/bamfiles/ETH-2_filtered.bam

