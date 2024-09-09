ortho_tsv=$1 ## Orthogroups.GeneCount.tsv file from OrthoFinder
cafe5_path=$2
ortho_fa=$3 ### all_single_copy_orthologue_seq.fa 
tree=$4 ## phylogenetic tree
div_spec=$5 ### 2 species name,seprate by comma
div_time=$6 ## diverge time of the 2 species (can be find at TimePoint database)

##prepare cafe5 input files
awk 'OFS="\t" {$NF=""; print}' ${ortho_tsv} | awk '{print "(null)""\t"$0}'|sed '1s/(null)/Desc/g' > 1.cafe.input.tsv

python ${cafe5_path}/tutorial/clade_and_size_filter.py -i 1.cafe.input.tsv -o 1.gene_family_filter.txt -s

seq_len=`seqkit fx2tab --length --name --header-line ${ortho_fa} |grep -v "#"|cut -f 2 |head -1`

python ${cafe5_path}/tutorial/prep_r8s.py -i $tree -o r8s_ctl_file.txt -s $seq_len -p $div_spec -c $div_time

r8s -b -f r8s_ctl_file.txt > r8s_tmp.txt

tail -n 1 r8s_tmp.txt | cut -c 16-  > 1.cafe.ultrametric_tree.nwk

### calculate gene family expansion and contraction
cafe5 -i 1.gene_family_filter.txt -t 1.cafe.ultrametric_tree.nwk

## get a lambda and set as the input of -l parameter and run again or choose a number (from 2 to 5) for -k parameter
