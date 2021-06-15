#!/bin/bash
#$ -S /bin/bash
#$ -q all.q
#$ -l h_vmem=20G
#$ -cwd
#$ -j Y
#$ -V

cache="/exports/sascstudent/cedrick/data/vep_cache_98"
dbnfpPath="/exports/sascstudent/cedrick/data/dbNSFP3.5/dbNSFP.gz"
scores="SIFT_pred,Polyphen2_HVAR_pred"
gonlPath="/exports/genomes/species/H.sapiens/GRCh38_goNL/annotation/gonl/multisample.parents_only.info_only.vcf.gz"
linsightPath="/exports/sascstudent/cedrick/data/linsight/LINSIGHT.bw"
#phastconsPath="/exports/sascstudent/cedrick/data/phastcons/hg19.100way.phastCons.bw"
#phylopPath="/exports/sascstudent/cedrick/data/phylop/hg19.100way.phyloP100way.bw"
gnomadPath="/exports/sascstudent/cedrick/data/gnomADv3/gnomad.genomes.r3.0.sites.vcf.bgz"
caddPath="/exports/sascstudent/cedrick/data/CADD/whole_genome_SNVs.tsv.gz"
referencefile="/usr/local/Genomes/species/H.sapiens/GRCh38_no_alt_analysis_set/reference.fa"

PERL5LIB=''
#1 = input
#2 = output
#3 = vcf or tab output format 

source /exports/sascstudent/cedrick/conda/bin/activate ensembl-vep
/exports/sascstudent/cedrick/conda/envs/ensembl-vep/bin/vep \
    -i ${1} \
    -o ${2} \
    --${3} \
    --no_stats \
    --cache \
    --format vcf \
    --dir_cache ${cache} \
    --offline \
    --cache_version 98 \
    --everything \
    --fasta ${referencefile} \
    --plugin dbNSFP,${dbnfpPath},gnomAD_genomes_NFE_AF \
    --plugin CADD,${caddPath},PHRED \
    --custom ${linsightPath},linsight,bigwig,exact,0 \
    --custom ${gonlPath},goNl,vcf,exact,0,AF \
    --custom ${gnomadPath},gnomadCustom,vcf,exact,0,AF_nfe\
    --biotype \
    --regulatory \
    --force_overwrite

