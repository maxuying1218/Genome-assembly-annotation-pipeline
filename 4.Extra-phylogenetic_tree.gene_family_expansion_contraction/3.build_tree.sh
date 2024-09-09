model=$1 ## best model tested by modeltest-ng

##build tree
raxml-ng --msa all_single_copy_orthologue_seq.fa --model ${model} --threads 20 --workers 5

##get bootstraps
raxml-ng --msa all_single_copy_orthologue_seq.fa --model ${model} --bootstrap --threads 20 --workers 5

##add bootstraps to the tree
raxml-ng --support --tree all_single_copy_orthologue_seq.fa.raxml.bestTree --bs-trees all_single_copy_orthologue_seq.fa.raxml.bootstraps

