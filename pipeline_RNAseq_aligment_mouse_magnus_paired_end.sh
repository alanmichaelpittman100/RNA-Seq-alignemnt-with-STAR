#!/bin/bash

#V1 December 2018
#RNAseq Alignment Pipeline 
#Alan Pittman SGUL 2018

#--------------------------------------------------------------------------------------------

#set the paths to your resources here:

STAR="/homes/athosnew/Genetics_Centre_Bioinformatics/resourses/STAR-2.6.0a/bin/Linux_x86_64/STAR"
samtools="/homes/athosnew/Genetics_Centre_Bioinformatics/resourses/samtools-1.8/samtools"

Genome_FASTA="/homedirs-porthos/sgul/shares/incc/porthos/Alan/RNA_seq_mouse/resources/References/Genome_FASTA/Mus_musculus.GRCm38.dna.primary_assembly.fa"
GTF="/homedirs-porthos/sgul/shares/incc/porthos/Alan/RNA_seq_mouse/resources/References/GTF/Mus_musculus.GRCm38.98.gtf" #download from ensemble
genomeDir="/homedirs-porthos/sgul/shares/incc/porthos/Alan/RNA_seq_mouse/resources/References/STAR_index"

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

	rm $projectDIR/$sample/fastqlistfile.txt
	
	fastQs=`ls $projectDIR/$sample`
	
	for fastq in $fastQs; do
		echo $fastq
		echo "$masterDIR/Unaligned/$myPROJECT/$sample/$fastq" >> $projectDIR/$sample/fastqlistfile.txt
		
	done	
		
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
		--readFilesIn `cat $projectDIR/$sample/fastqlistfile.txt` \
		--outSAMstrandField intronMotif \
		--outFileNamePrefix $AlignedOUT/$sample/$sample  \
		--outSAMtype BAM SortedByCoordinate

		#--readFilesCommand gunzip -c \
		
		
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

