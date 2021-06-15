#!/bin/sh

## output directory
echo --- creating output directory ---
basedir=`pwd`/cALCL_results
mkdir -p $basedir 

echo --- running GISTIC version 2.0 ---
## input file definitions
segfile=cALCL.seg
refgenefile=hg38.UCSC.add_miR.160920.refgene.mat
./gistic2 -b $basedir -seg $segfile -refgene $refgenefile

