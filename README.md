Genome assembly and annotation pipeline
===
This is a pipeline to assemble and annotate _Fusarium graminearum 5035_ strain.

## Software requirements
- For genome assembly: hifiasm, juicer, juicer_tools, juice_box, 3D-DNA/yahs
- For repeat and gene annotation: RepeatMasker, RepeatModeler, Trinity, augustus, GeneMark-ES/EK, GenomeThreader, PASA, EVidenceModeler
- For genome quality assessment: BUSCO, QUAST, minimap2, samtools, CRAQ
- For phylogenetic tree and gene family expansion and contraction: OrthoFinder, mafft, Gblocks, seqkit, modeltest-ng, raxml-ng, CAFE5, r8s

## Pipeline workflow 
![image](https://github.com/maxuying1218/Genome-assembly-annotation-pipeline/blob/main/figures/workflow.png)

## Part 1: _Fg.5035_ Genome assembly
This part is to assemble fungal genome such as _Fusarium_ using HiFi and Hi-C data.  
Code is stored at [1.assemble_HiFi_HiC_to_chromosome](./1.assemble_HiFi_HiC_to_chromosome).  
After genome assembly, a whole genome contact matrix heatmap could be drawn like this (using Hi-C data):
![image](https://github.com/maxuying1218/Genome-assembly-annotation-pipeline/blob/main/figures/Genome_assembly_HiC_contact_heatmap.jpg)

## Part 2: Repeat and gene annotation
This part is to annotate repeat elements and genes in fungal genomes (RNA-Seq data is required).  
Code is stored at [2.genome_annotation](./2.genome_annotation).  
First, annotate repeat elements.Then mask the repeat elements from the genome and annotate genes.  
After the annotation, a circos plot could be drawn like this (I: GC content, II: gene expression, III: gene density, IV: TE density,V: chromosomes):  
![image](https://github.com/maxuying1218/Genome-assembly-annotation-pipeline/blob/main/figures/Circos_plot_2_genomes.jpg)

## Part 3: Genome quality assessment
This part is to assess the quality of the assembled genome.  
Code is stored at [3.genome_quality_assessment](./3.genome_quality_assessment).  
After this step, a picture could be drawn from the BUSCO results like this:  
![image](https://github.com/maxuying1218/Genome-assembly-annotation-pipeline/blob/main/figures/busco_figure.png)

## Part 4 (extra part): Phylogenetic tree construction and gene family expansion and contraction analysis
This part is to build a phylogenetic tree and get the number of gene family expansion and contraction.  
Code is stored at [4.Extra-phylogenetic_tree.gene_family_expansion_contraction](./4.Extra-phylogenetic_tree.gene_family_expansion_contraction).  
After this step, a phylogenetic tree with gene family expansion and contraction information could be drawn like this:  
![image](https://github.com/maxuying1218/Genome-assembly-annotation-pipeline/blob/main/figures/expansion_contraction.jpg)
