#!/bin/bash

##############################################################


./STAR \
--runThreadN 8 \
--runMode genomeGenerate \
--genomeDir /References/STAR_index \
--genomeFastaFiles /References/Genome_FASTA/Homo_sapiens.GRCh38.dna.primary_assembly.fa \
--sjdbGTFfile /References/GTF/Homo_sapiens.GRCh38.91.gtf \
--sjdbOverhang 100



exit
exit
