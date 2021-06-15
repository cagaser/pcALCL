#!/bin/bash

##Define I/O
CONFIG=/exports/sasc/common/cromwell_config/SLURM_51_singularity.conf
JAR=/exports/sasc/common/cromwell_jars/cromwell-51/cromwell-51.jar
INPUTS=/exports/sasc/project-317-CALCLJulianInternship/src/10-WES-RNAseq-Somatic/01-biowdl/run-02/01-RNAseq-pipeline/inputs.json
PIPELINE=/exports/sasc/project-317-CALCLJulianInternship/src/10-WES-RNAseq-Somatic/01-biowdl/run-02/01-RNAseq-pipeline/RNA-seq/RNA-seq.wdl
LOG=/exports/sasc/project-317-CALCLJulianInternship/src/10-WES-RNAseq-Somatic/01-biowdl/run-02/01-RNAseq-pipeline/pipeline.log

##Command
java -Xmx5G -Dconfig.file=$CONFIG -jar $JAR run -i $INPUTS $PIPELINE 2>&1 | tee $LOG
