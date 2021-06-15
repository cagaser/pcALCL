# CNV calling with [control-FreeC](http://boevalab.inf.ethz.ch/FREEC/index.html#downloads) v11.5.

## Preprocessing
* First run filter.sh on BAM files you want to use to remove low mapping quality reads from the bam file. This removes noise from your output
* Then run remove_softclipped.sh on the filtered BAM file. This removes more noise from your bam file.

## Running control-FreeC

* Make your config file where 'mateFile' = your preprocessed BAM file, use [this](http://boevalab.inf.ethz.ch/FREEC/tutorial.html#CONFIG) link to check you made the config file correctly for your data.
* qsub the startFreeC.sh script with the config.txt file you created 

## Visualization and significance assesment

* Run FreeCCNVPlot.R with Rscript to **visualize all the chromosomes** in a single plot **OR** Run makeGraphs.R with "cat makeGraph.R | R --slave --args 2 [_ratio.txt file from FreeC output]" to visualize each **individual chromosome**.
* Use [this](https://github.com/BoevaLab/FREEC/blob/master/scripts/assess_significance.R) script for assesing significance of the found CNVs.

# CNA focal region analysis using GISTIC2 version 2.0

* cALCL_seg_FreeC.txt is the concatenated CNA output from FreeC
* fix_CN2.sh is the script to convert FreeC output to the required .seg file for running GISTIC2
* run_gistic_FreeC.sh is the script to run GISTIC2
