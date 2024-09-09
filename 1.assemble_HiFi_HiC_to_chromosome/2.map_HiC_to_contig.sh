GENOME_NAME=$1
GENOME_PATH=$2 ###contig genome fasta file path
RESTRIC=$3 ##restrction type. eg: DpnII
JUICER_PATH=$4 ### juicer install path
HIC_R1=$5 
HIC_R2=$6

## make some new directories for juicer 
mkdir -p work/fastq references restriction_sites 
ln -s ${JUICER_PATH}/CPU scripts

## prepare chromosome length and restriction sites files 
/${JUICER_PATH}/misc/generate_site_positions.py $RESTRIC $GENOME_NAME $GENOME_PATH
cp ${GENOME_NAME}_${RESTRICT}E.txt restriction_sites/${GENOME_NAME}_${RESTRICT}.txt

awk 'BEGIN{OFS="\t"}{print $1, $NF}' ${GENOME_NAME}_${RESTRICT}.txt > restriction_sites/${GENOME_NAME}.ChromSizes

## prepare genome and index fasta file
cp $GENOME_PATH references/${GENOME_NAME}.fa
cd references && bwa index ${GENOME_NAME}.fa
cd -

##put Hi-C data to work dir
HIC_R1=${HIC_R1##*/}
HIC_R2=${HIC_R2##*/}
ln -s $HIC_R1 work/fastq/${HIC_R1}
ln -s $HIC_R2 work/fastq/${HIC_R2} 
## run juicer
$(pwd)/scripts/juicer.sh -z $(pwd)/references/${GENOME_NAME}.fa -p $(pwd)/restriction_sites/${GENOME_NAME}.ChromSizes -y $(pwd)/restriction_sites/${GENOME_NAME}_${RESTRICT}.txt -s $RESTRICT -d $(pwd)/work/ -D $(pwd) -t 24 


