#!/bin/bash

##Define I/O
CONFIG=SLURM_50-dev-fingerprint_singularity.conf
JAR=/exports/sasc/cagaser/cromwell-50-60ddc42-SNAP.jar
INPUTS=inputs.json
PIPELINE=/exports/sasc/project-317-CALCLJulianInternship/src/10-WES-RNAseq-Somatic/01-biowdl/run-03/gatk-variantcalling/multisample-variantcalling.wdl
LOG=pipeline.log

##Command
java -Xmx5G -Dconfig.file=$CONFIG -jar $JAR run -i $INPUTS $PIPELINE 2>&1 | tee $LOG