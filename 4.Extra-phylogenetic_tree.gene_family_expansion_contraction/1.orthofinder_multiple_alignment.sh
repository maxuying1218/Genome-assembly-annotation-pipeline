fasta_path=$1 ### dir stored fasta format protein file splited by each gene

## find orthologues for all selected species
orthofinder -f ${fasta_path} -M msa -t 20 -a 20 -S diamond

###use single-copy orthologues to do muliple alignment
for i in ./OrthoFinder/*/Single_Copy_Orthologue_Sequences/OG*fa;do l=${i##*/};l=${l/.fa/};mafft --maxiterate 1000 --localpair $i > ${l}.aln;Gblocks ${l}.aln -b4=5 -b5=h -t=p -e=.gb;seqkit seq ${l}.aln.gb -w 0 > ${l}.new.aln;done

seqkit concat *new.aln > all_single-copy_orthologue_seq.fa

