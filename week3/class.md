# Looking at Raw NGS data

all steps assume that you are running the week 3 class docker container and that the class archive (material and ressources) are available in the /work directory of the docker container.

```{bash}
docker run -it -v /Users/johndoe/mylocalfolder:/work j5kim/med263-harismendy /bin/bash
```


### using screen

Screen allows you to detach your analysis from the patent shell and reattach it later (so you can go home at night)

Create a screen session

```{bash}
		screen –S myfirstscreen
```

You press ^A^D to detach

You call -x to attach back

```{bash}
	screen –x [PID].name #to attach
```

you type 'exit' to kill it



### UNIX/AWK to work with intervals

How many lines in the CGC.bed file?

```{bash}
	wc –l ../resources/CGC.exons.bed
```

How many CGC exons on chromosome 1 ?

```{bash}
	awk ‘$1==“chr1”’ ../resources/CGC.exons.bed | wc -l
```

how many CGC genes on chromsome 1?

```{bash}
	cut –f 4 ../resources/CGC.exons.bed | sort | uniq | wc –l
```

how many exons per CGC gene ?

```{bash}
	cut –f 4 ../resources/CGC.exons.bed | sort | uniq –c | sort –r | more
```

what is the longest gene in the list ?

```{bash}
	awk ‘$5=$3-$2’ ../resources/CGC.exons.bed | sort –nrk 5 | head
```

what is the sum of the length of all the exons

```{bash}
	awk ‘{sum=sum+$3-$2} END {print sum/NR}’ ../resources/CGC.exons.bed
```


### FASTQC and MULTIQC


Inspect the fastq file. How long are the reads?

```{bash}
	zcat ../materials/SRR866442_1.fastq.gz | more
```

Create an output directory

```{bash}
	mkdir fastqc
```

Run fastqc on all files

```{bash}
	for file in ../materials/*SRR*fastq.gz; do fastqc –o fastqc $file & done
```

Running MultiQC

```{bash}
	cd fastqc
	multiqc . # the dot indicates the current directory
	cd ..
	tar -cvf fastqc_results.tar fastqc #creates an archive of the results
```

Now open the html file on your laptop to browse the results.



### Read Alignment (targeted amplicons)


Start a Screen session
```{bash}
	screen –S alignment
```

Alignment + convert to sorted bam
```{bash}
	bwa mem ../resources/chr1.fa.gz ../materials/SRR866442_1.fastq.gz ../materials/SRR866442_2.fastq.gz | samtools view –buSh - > SRR866442.bam
```

Sort and index the bam file
```{bash}
	samtools sort –m 2G SRR866442.bam > SRR866442.sorted.bam
	samtools index SRR866442.sorted.bam
```

What fraction of reads are properly aligned?
```{bash}
	samtools flagstat SRR866442.sorted.bam > SRR866442.flagstat.txt
```


### Statistics and Slices (whole exome)

What fraction of reads are properly aligned?
```{bash}
	samtools flagstat ../materials/CPTRES7.chr21.bam > CPTRES7.flagstat.txt
```

How many “gapped reads” ?
```{bash}
	samtools view ../materials/CPTRES7.chr21.bam | awk ‘$6~/[ID]/’ | wc -l
```

how many reads over the CGC exons
```{bash}
	samtools view –L ../resources/CGC.exons.bed ../materials/CPTRES7.chr21.bam | wc -l
```


### Visualize Alignments in IGV


Locate the bam and bai file to your laptop, open with IGV


### Calculating Coverage Depth


what fraction of the CGC chr1 are covered by more than 20 reads
```{bash}
	grep '^chr21' ../resources/CGC.exons.bed | samtools depth -b - ../materials/CPTRES7.chr21.bam | awk '$3>20' | wc -l
	grep '^chr21' ../resources/CGC.exons.bed | awk '{sum+=$3-$2} END {print sum}' #total number of CGC exons bp on chr21
```

how many RUNX1 base pairs are covered at 20x or greater?
```{bash}
	bedtools coverage -a ../resourcesCGC.exons.bed -b ../material/CPTRES7.chr21.bam -hist | grep 'RUNX1' | awk '$5>20' | awk '{sum+=$6} END {print sum}' #solution #1
	grep 'RUNX1' ../resources/CGC.exons.bed | samtools depth -b - ../materials/CPTRES7.chr21.bam | awk '$3>20' | wc -l #solution #2
```


### Filtering Variants

index the vcf file
```{bash}
 	tabix -p vcf ../materials/CPTRES1vs15.vcf.gz
```

how many variants pass the filters?
```{bash}
	zgrep -v '^##' ../materials/CPTRES1vs15.vcf.gz | awk '$7=="PASS"' | wc -l
```

Filter the variants
```{bash}
 	bcftools filter -i 'FILTER=="PASS"' ../materials/CPTRES1vs15.vcf.gz > CPTRES1vs15.PASS.vcf.gz
```


What is the transition to transversion ratio?
```{bash}
	bcftools stats CPTRES1vs15.PASS.vcf.gz
```

how many somatic variants ?
```{bash}
	bcftools filter -i 'INFO/SS==2' CPTRES1vs15.PASS.vcf.gz | wc -l
```

export the soamtic variant to tsv
```{bash}
	bcftools filter -i 'INFO/SS==2' CPTRES1vs15.PASS.vcf.gz | bcftools view -O z > CPTRES1vs15.PASS.SOM.vcf.gz
	vcf2tsv -g CPTRES1vs15.PASS.SOM.vcf.gz > CPTRES1vs15.PASS.SOM.tsv
```

How many nonsense somatic variants? First let's annotate them with annovar

```{bash}
	../resources/annovar/table_annovar.pl --vcfinput --nastring . --protocol refGene --operation g --buildver hg19 --outfile CPTRESann CPTRES1vs15.PASS.SOM.vcf.gz ../resources/annovar/humandb/
```

Then we can tally by variant function 
```{bash}
	cut -f 2 CPTRESann.refGene.exonic_variant_function | sort | uniq -c
```

