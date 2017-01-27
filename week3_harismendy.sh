#!/bin/bash

################################################################
#
#  "Looking at raw data: reads, alignment and variants"
#	MED263 Harismendy
#	W2017
#
################################################################


###########
#
# PreRequisite
#
###########
#
# 	1. Download the class material
#	2. unzip
#	3 confihure your machien runnign sudo ./provision.sh
#	4. Create a working directory:

mkdir workingdir # the following command assume workingdir is inside the MED263_harismendy directory
cd workingdir


###########
#
# Using screen
#
###########

		#Use screen
		screen -S name to create

		#^A ^D to detach
		screen -x [PID].name #to attach
		exit #to kill

###########
#
# UNIX/AWK to work with intervals
#
###########

#How many lines in the CGC.bed file?
	wc -l ../resources/CGC.exons.bed
#How many CGC exons on chromosome 1 ?
	awk '$1=="chr1"' ../resources/CGC.exons.bed | wc -l
#how many CGC genes in total?
	cut -f 4 ../resources/CGC.exons.bed | sort | uniq | wc -l
#how many exons per CGC gene ?
	cut -f 4 ../resources/CGC.exons.bed | sort | uniq -c | sort -r | more
#what is the longest gene in the list ?
	awk '$5=$3-$2' ../resources/CGC.exons.bed | sort -nrk 5 | head
#what is the sum of the length of all the exons
	awk '{sum=sum+$3-$2} END {print sum}' ../resources/CGC.exons.bed


###########
#
# FASTQC and MULTIQC
#
###########

#Inspect the fastq file. How long are the reads?
	zcat ../materials/SRR866442_1.fastq.gz | more
#Create an output directory
	mkdir fastqc
#Run fastqc on all files
	for file in ../materials/*SRR*fastq.gz; do fastqc -o fastqc $file & done
#Running MultiQC
	cd fastqc
	multiqc . # the dot indcates the current directory
	cd ..
	tar -cvf fastqc_results.tar fastqc #creates an archive of the results
#On your Desktop/Laptop
	scp -P 9221 username@172.xxxxxxxx:/home/username/MED263/workingdir/fastqc_results.tar # copy the results
	#open the multiqc_report.html with your browser

###########
#
# Read Alignment (targeted amplicons)
#
###########

#Start a Screen session
	screen -S alignment

#Alignment + convert to sorted bam
	bwa mem ../resources/chr1.fa.gz ../materials/SRR866442_1.fastq.gz ../materials/SRR866442_2.fastq.gz | samtools view -buSh - > SRR866442.bam

#Sort and index the bam file
	samtools sort -m 2G SRR866442.bam > SRR866442.sorted.bam
	samtools index SRR866442.sorted.bam

#What fraction of reads are properly aligned?
	samtools flagstat SRR866442.sorted.bam > SRR866442.flagstat.txt


###########
#
# Statistics and Slices (whole exome)
#
###########

#What fraction of reads are properly aligned?
	samtools flagstat ../materials/CPTRES7.chr21.bam > CPTRES7.flagstat.txt

#How many "gapped reads" ?
	samtools view ../materials/CPTRES7.chr21.bam | awk '$6~/[ID]/' | wc -l

#how many reads over the CGC exons
	samtools view -L ../resources/CGC.exons.bed ../materials/CPTRES7.chr21.bam | wc -l

###########
#
# Visualize Alignments in IGV
#
###########

# 	1 copy the bam and bai file to your laptop
#      # type this your terminal application in your laptop 
#      scp -P 9221 username@172.XX.XX.XX:/home/username/MED263_harismendy/materials/CPTRES7*bam* .
#      password:*******
#      
#	2. open with IGV
#


###########
#
# Calculating Coverage Depth
#
###########

#what fraction of the CGC chr1 are covered by more than 20 reads
	grep '^chr21' ../resources/CGC.exons.bed | samtools depth -b - ../materials/CPTRES7.chr21.bam | awk '$3>20' | wc -l
	grep '^chr21' ../resources/CGC.exons.bed | awk '{sum+=$3-$2} END {print sum}' #total number of CGC exons bp on chr21

#how many RUNX1 base pairs are covered at 20x or greater?
	bedtools coverage -a ../resources/CGC.exons.bed -b ../materials/CPTRES7.chr21.bam -hist | grep 'RUNX1' | awk '$5>20' | awk '{sum+=$6} END {print sum}' #solution #1
	grep 'RUNX1' ../resources/CGC.exons.bed | samtools depth -b - ../materials/CPTRES7.chr21.bam | awk '$3>20' | wc -l #solution #2


###########
#
# Filtering Variants
#
###########

# index the vcf file
 	tabix -p vcf ../materials/CPTRES1vs15.vcf.gz

# how many variants pass the filters?
	zgrep -v '^##' ../materials/CPTRES1vs15.vcf.gz | awk '$7=="PASS"' | wc -l

# Filter the variants
 	bcftools filter -i 'FILTER=="PASS"' ../materials/CPTRES1vs15.vcf.gz > CPTRES1vs15.PASS.vcf.gz

# What is the transition to transversion ratio?
	bcftools stats CPTRES1vs15.PASS.vcf.gz

# how many somatic variants ?
	bcftools filter -i 'INFO/SS==2' CPTRES1vs15.PASS.vcf.gz | wc -l

# export the somatic variant to tsv
	bcftools filter -i 'INFO/SS==2' CPTRES1vs15.PASS.vcf.gz | bcftools view -O z > CPTRES1vs15.PASS.SOM.vcf.gz
	vcf2tsv -g CPTRES1vs15.PASS.SOM.vcf.gz > CPTRES1vs15.PASS.SOM.tsv

# How many nonsense somatic variants

	#annotate with annovar
	../resources/annovar/table_annovar.pl --vcfinput --nastring . --protocol refGene --operation g --buildver hg19 --outfile CPTRESann CPTRES1vs15.PASS.SOM.vcf.gz ../resources/annovar/humandb/
	# count the 2nd column of the variant_function file
	cut -f 2 CPTRESann.refGene.exonic_variant_function | sort | uniq -c

###########
#
# Using R for data wrangling and plotting
#
###########

# Import variant TSV into R


	# aggregate, annotate
	xx going over dplyr, reshape, aggregate

	# plot
	xx going over ggplot





