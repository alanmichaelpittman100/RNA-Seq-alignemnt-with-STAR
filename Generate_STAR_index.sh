#!/bin/bash

##############################################################






/hades/Alan/RNA_seq_pipeline_AP/Resources/Software/STAR/STAR \
--runThreadN 8 \
--runMode genomeGenerate \
--genomeDir /hades/Alan/RNA_seq_pipeline_AP/Resources/References/STAR_index \
--genomeFastaFiles /hades/Alan/RNA_seq_pipeline_AP/Resources/References/Genome_FASTA/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
--sjdbGTFfile /hades/Alan/RNA_seq_pipeline_AP/Resources/References/GTF/Homo_sapiens.GRCh38.91.gtf \
--sjdbOverhang 100



exit
exit
