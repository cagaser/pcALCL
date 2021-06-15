#!/bin/bash

##Define I/O
#CONFIG=/exports/sasc/common/cromwell_config/SLURM_51_singularity.conf
CONFIG=/exports/sasc/common/cromwell-cluster-config/cromwell.conf
JAR=/exports/sasc/common/cromwell_jars/cromwell-51/cromwell-51.jar
INPUTS=inputs.json
PIPELINE=../somatic-variantcalling/mutect2.wdl
LOG=pipeline.log

##Command
java -Xmx5G -Dconfig.file=$CONFIG -jar $JAR run -i $INPUTS $PIPELINE 2>&1 | tee $LOG
