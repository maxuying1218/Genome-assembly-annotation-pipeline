3D-DNA_PATH=$1
GENOME_PATH=$2
merged_nodups=$3
HIC_map_sam=$4 ##mapped hic sam file,from juicer
RESTRICT_SITES=$5
juicer_tools=$6

## option1 : 3d-dna pipeline
### for simple genome like Fusarium,r=0 is enrough;for more complicate genome ,maybe r=2 is a better choice
/3D-DNA_PATH/run-asm-pipeline.sh -r 0 ${GENOME_PATH} $mergd_nodups

GENOME_NAME=${GENOME_PATH##*/}
GENOME_NAME=${GENOME_NAME/.fa/}
### visualize GENOME_NAME.rawchrom.hic and GENOME_NAME.FINAL.assembly in juicebox and correct mistakes manually
### use GENOME_NAME.review.assembly from juicebox as an input file and scaffold againg
/3D-DNA_PATH/run-asm-pipeline-post-review.sh -r ${GENOME_NAME}.review.assembly $GENOME_PATH $merged_nodups

## option2 : yahs pipeline
### prepare bam file for yahs
HIC_DATA=${HIC_map_sam##*/}
HIC_DATA=${HIC_DATA/.sam/}
samtools view -@ 30 -b ${HIC_map_sam} |samtools sort -T ${HIC_DATA} -@ 30 -o ${HIC_DATA}.sorted.bam -

### run yahs
yahs $GENOME_PATH ${HIC_DATA}.sorted.bam -e $RESTRICT_SITES -o ${GENOME_NAME}.yahs

juicer pre -a -o ${GENOME_NAME}.yahs_JBAT_pre ${GENOME_NAME}.yahs.bin ${GENOME_NAME}.yahs_scaffolds_final.agp ${GENOME_PATH}i

GENOME_SIZE=$(awk '{s+=$2} END{print s}' ${GENOME_PATH}i)
java -Xmx36G -jar $juicer_tools pre ${GENOME_NAME}.yahs_JBAT_pre.txt ${GENOME_NAME}.yahs_JBAT_pre.hic <(echo "assembly $GENOME_SIZE") 

### visualize GENOME_NAME.yahs_JBAT_pre.hic and GENOME_NAME.yahs_JBAT_pre.assembly in juice_box and correct mistakes manually
### use GENOME_NAME.yahs_JBAT_pre.review.assembly from juicebox as an input file and scaffold again
juicer post -o ${GENOME_NAME}.yahs_JBAT_post ${GENOME_NAME}.yahs_JBAT_pre.review.assembly ${GENOME_NAME}.yahs_JBAT_pre.liftover.agp $GENOME_PATH


