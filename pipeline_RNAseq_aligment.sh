#!/bin/bash

#V1 December 2018
#RNAseq Alignment Pipeline 
#Alan Pittman SGUL 2018

#--------------------------------------------------------------------------------------------

#set the paths to your resources here:

STAR="/homes/athosnew/Genetics_Centre_Bioinformatics/resourses/STAR-2.6.0a/bin/Linux_x86_64/STAR"
samtools="/homes/athosnew/Genetics_Centre_Bioinformatics/resourses/samtools-1.8/samtools"

Genome_FASTA=/"homes/athosnew/Genetics_Centre_Bioinformatics/RNA_seq/resources/Genome_reference/Homo_sapiens.GRCh38.dna.primary_assembly.fa"
GTF="/homes/athosnew/Genetics_Centre_Bioinformatics/RNA_seq/resources/GTFs/Homo_sapiens.GRCh38.91.gtf"
genomeDir="/homes/athosnew/Genetics_Centre_Bioinformatics/RNA_seq/resources/STAR_genome_DIR"

#--------------------------------------------------------------------------------------------

echo " "
echo \
'''---------------------------------------------------------------------------------------------

RNAseq Alignment Pipeline 
Alan Pittman SGUL 2018

---------------------------------------------------------------------------------------------'''
echo " "
date
echo " "
sleep 1
echo " "


echo " "
echo \
'''---------------------------------------------------------------------------------------------

Comencing STAR index generation

---------------------------------------------------------------------------------------------'''
echo " "

#generating sequencing specific STAR index prior to alignemnt (if not done so already)
#--------------------------------------------------------------------------------------------

sjdbOverhang=100 #numerical should be readlength -1 ***check your read length***

$STAR \
	--runThreadN 8 \
	--runMode genomeGenerate \
	--genomeDir $genomeDir \
	--genomeFastaFiles $Genome_FASTA \
	--sjdbGTFfile $GTF \
	--sjdbOverhang $sjdbOverhang # check your overhang

identify out project directory and list our samples:
#--------------------------------------------------------------------------------------------

myPROJECT=$1
masterDIR=`pwd`

projectDIR=$masterDIR/Unaligned/$myPROJECT
AlignedOUT=$masterDIR/Aligned/$myPROJECT

mkdir $masterDIR/Aligned/$myPROJECT

samples=`ls $projectDIR/`

echo " "
echo \
'''---------------------------------------------------------------------------------------------

Identifying project samples for alignemnt

---------------------------------------------------------------------------------------------'''
sleep 1
echo " "
echo $samples
echo " "
sleep 1

#identify our fastq file for alignemnt:
#--------------------------------------------------------------------------------------------

for sample in $samples; do
	
	mkdir $AlignedOUT/$sample

	echo " "

	fastQs=`ls $projectDIR/$sample`
		
	echo $fastQs
	echo " "

#execute sample specific alignment:
#--------------------------------------------------------------------------------------------

	echo " "
	echo \
	'''---------------------------------------------------------------------------------------------

	Comencing alignment of:

	---------------------------------------------------------------------------------------------'''
	echo "$sample"
	sleep 1
	echo " "


	$STAR \
		--runThreadN 8 \
		--genomeDir $genomeDir \
		--readFilesIn $projectDIR/$sample/$fastQs \
		--readFilesCommand gunzip -c \
		--outSAMstrandField intronMotif \
		--outFileNamePrefix $AlignedOUT/$sample/$sample  \
		--outSAMtype BAM SortedByCoordinate

#index .bam file
#--------------------------------------------------------------------------------------------

	$samtools index \
		$AlignedOUT/$sample/${sample}Aligned.sortedByCoord.out.bam

done

echo " "
echo \
'''---------------------------------------------------------------------------------------------

Samples Aligned
Happy RNA counting !

---------------------------------------------------------------------------------------------'''
echo " "
sleep 1
echo " "


exit
exit
exit

