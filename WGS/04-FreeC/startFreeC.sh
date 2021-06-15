#!/bin/bash

#$ -q all.q
#$ -N ETH-2_filtered
#$ -l h_vmem=8G
#$ -V
#$ -cwd
#$ -m be
#$ -M J.H.van_Toledo@lumc.nl
#$ -pe BWA 1

/exports/huid-derl/FreeC/FREEC-11.5/src/freec -config config_genome.txt

