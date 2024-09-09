GENOME_NAME=$1
HIC_R1=$2 ###fastq/fastq.gz format
HIC_R2=$3
HIFI_DATA=$4 ##fq.gz format

## use hifiasm to assemble HiFi and Hi-C data to contig level genome
hifiasm -o $GENOME_NAME -t 20 --h1 $HIC_R1 --h2 $HIC_R2 $HIFI_DATA 2>1.log

##for haploid genome
awk '/^S/{print ">"$2;print $3}' ${GENOME_NAME}.bp.p_ctg.gfa >${GENOME_NAME}.fa

