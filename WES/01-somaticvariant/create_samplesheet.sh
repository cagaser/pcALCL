#!/bin/bash

for file in /exports/sascstudent/julian/mutationsCTCL/WES_Data/merged_fastq/*
do
 #if [[ ${file} != *"_"* ]]; then
 # python writesamplesheet.py ${file}
  #echo ${file}
 #fi
 python writesamplesheetwes.py ${file}
done

