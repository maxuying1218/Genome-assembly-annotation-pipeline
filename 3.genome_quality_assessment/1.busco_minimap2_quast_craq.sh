genome_path=$1
bus_res=$2 ## directory stored busco results
qua_res=$3 ## directory stored quast results
hifi_fq=$4
mini_res=$5 ## prefix for minimap2 results
ngs_fq=$6
craq_res=$7

### download fungi database
wget -c https://busco-data.ezlab.org/v5/data/lineages/fungi_odb10.2021-06-28.tar.gz
tar -zxvf fungi_odb10.2021-06-28.tar.gz

## busco assessment
busco -i ${genome_path} -m genome -o ${bus_res} -l ./fungi_odb10 --cpu 30 offline

## quast assessment
quast.py ${genome_path} --pacbio ${hifi_fq} -t 30 -o ${qua_res}

## minimap2 alignment
minimap2 -t 20 -ax map-pb ${genome_path} ${hifi_fq} > ${mini_res}.sam
samtools flagstat ${mini_res}.sam > ${mini_res}.mapping_info.txt

### craq assessment, R-AQI > 90 is a reference level genome
craq -g ${genome_path} -sms ${hifi_fq} -ngs ${ngs_fq} -t 30 -D ${craq_res}

