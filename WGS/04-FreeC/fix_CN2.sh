INPUT_FREEC=/exports/sasc/hmei/git/project-261-CompareWithPublicCD8TcellForDGE/src/05_GISTIC2/cALCL_seg_FreeC.txt
REF_IDX=/exports/sasc/hmei/git/project-261-CompareWithPublicCD8TcellForDGE/src/05_GISTIC2/ref_38.genome
WORK_DIR=/exports/sasc/hmei/git/project-261-CompareWithPublicCD8TcellForDGE/analysis/05_GISTIC2/cALCL

mkdir -p $WORK_DIR

for sample in $(cut -f1 $INPUT_FREEC |uniq); do
    echo $sample
    grep -P "$sample\t" $INPUT_FREEC |cut -f2-6|sed 's/^/chr/' > $WORK_DIR/$sample.bed
    bedtools sort -i $WORK_DIR/$sample.bed -faidx $REF_IDX > $WORK_DIR/$sample.sorted.bed
    bedtools complement -i $WORK_DIR/$sample.sorted.bed -g $REF_IDX > $WORK_DIR/$sample.complement.bed
    sed 's/$/\tNA\t0/' $WORK_DIR/$sample.complement.bed > $WORK_DIR/$sample.CN2.bed
    cat $WORK_DIR/$sample.sorted.bed $WORK_DIR/$sample.CN2.bed > $WORK_DIR/$sample.whole.bed
    bedtools sort -i $WORK_DIR/$sample.whole.bed -faidx $REF_IDX > $WORK_DIR/$sample.whole.sorted.bed
    sed "s/^/$sample\t/" $WORK_DIR/$sample.whole.sorted.bed > $WORK_DIR/$sample.whole.sorted.seg
done

cd $WORK_DIR
find . -name "*.whole.sorted.seg" -exec cat {} \; > cALCL.seg

