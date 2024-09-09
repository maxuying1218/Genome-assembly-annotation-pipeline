Genome assembly and annotation pipeline
===
This is a pipeline to assemble and annotate _ _Fusarium graminearum 5035_ _ strain.

## Software requirements
- For genome assembly: hifiasm, juicer, juicer_tools, juice_box, 3D-DNA/yahs
- For repeat and gene annotation: RepeatMasker, RepeatModeler, Trinity, augustus, GeneMark-ES/EK, GenomeThreader, PASA, EVidenceModeler
- For genome quality assessment: BUSCO, QUAST, minimap2, samtools, CRAQ
- For phylogenetic tree and gene family expansion and contraction: OrthoFinder, mafft, Gblocks, seqkit, modeltest-ng, raxml-ng, CAFE5, r8s
## Part 1: _ _Fg.5035_ _ Genome assembly
This part is to assemble fungal genome such as _ _Fusarium_ _ using HiFi and Hi-C data.   Code is stored at [1.assemble_HiFi_HiC_to_chromosome](./1.assemble_HiFi_HiC_to_chromosome).
![image](https://github.com/maxuying1218/Genome-assembly-annotation-pipeline/blob/main/figures/Genome_assembly_HiC_contact_heatmap.jpg)
