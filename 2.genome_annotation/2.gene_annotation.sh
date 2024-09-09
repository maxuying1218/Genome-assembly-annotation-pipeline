species_name=$1 ###species name in augustus
masked_genome=$2
genome_name=$3
convert_augustus_to_gff3_path=$4
ref_pro=$5  ### related genome protein file,fasta format
sam_info=$6 ## RNA-Seq fastq information file used by Trinity
genome_path=$7
EVM_path=$8
wei_file=$9 ### EVM weight file

###usd augustus and genemark-ES/EK to do de novo prediction
##run augustus
augustus --species=${species_name} ${masked_genome} > ${genome_name}.augustus.gff

## convert format tools can be found at https://github.com/jorvis/biocode
$convert_augustus_to_gff3_path -i ${genome}.augustus.gff -o ${genome_name}.augustus.standard.gff

##run GeneMark-ES/EK
gmes_petap.pl --ES --fungus --cores 30 --sequence ${masked_genome}
mv genemark.gtf ${genome_name}.genemark.gtf
###use genomethreader to do homology-based prediction
gth -gff3out -intermediate -genomic ${masked_genome} -protein ${ref_pro} -o ${genome_name}.genomethreader.gff

####use Trinity to do transcriptome-based prediction
Trinity --samples_file ${sam_info} --seqType fq --CPU 30 --max_memory 40G

#sqlite3 ${genome_name}
#.database

seqclean trinity_out_dir.Trinity.fasta

Launch_PASA_pipeline.pl -c pasa.alignAssembly.config -C -R -g ${genome_path} -t trinity_out_dir.Trinity.fasta.clean -T -u trinity_out_dir.Trinity.fasta --ALIGNERS blat,gmap,minimap2 --CPU 30

### merge all results using EVM
${EVM_path}/EvmUtils/misc/augustus_GFF3_to_EVM_GFF3.pl ${genome_name}.augustus.standard.gff > ${genome_name}.augustus.gff3
${EVM_path}/EvmUtils/misc/GeneMarkHMM_GTF_to_EVM_GFF3.pl ${genome_name}.genemark.gtf > ${genome_name}.genemark.gff3
${EVIM_path}/EvmUtils/misc/genomeThreader_to_evm_gff3.pl ${genome_name}.genomethreader.gff > ${genome_name}.genomethreader.gff3

cat ${genome_name}.augustus.gff3 ${genome_name}.genemark.gff3 > ${genome_name}.denovo.gff3

EVidenceModeler --sample_id ${genome_name} --genome ${genome_path} --gene_predictions ${genome_name}.denovo.gff3 --protein_alignments ${genome_name}.genomethreader.gff3 --transcript_alignments ${genome_name}.pasa_assemblies.gff3 --segmentSize 100000 --overlapSize 10000 --weights 0.weights.txt



