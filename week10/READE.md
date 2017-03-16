## MED 263, week 10: Searching for disease mutations using DNA sequence data and bioinformatics 

---

## 0. Preparation

```Shell
cd ~
git clone https://github.com/vibansal/med263.git
mv med263 week10
cd week10
```

## 1. Analysis of loss-of-function mutations
Loss-of-function (LoF) mutations in genes are expected to have a strong impact on gene function. In the lecture on Tuesday, we learned that LoF mutations in the MLL2 (also known as KMT2D) cause Kabuki syndrome, a severe pediatric disease. Therefore, LoF mutations in this gene should be depleted in normal individuals. In this exercise, we will estimate the frequency of LoF mutations in KMT2D in the ExAc database (65,000 individuals) using command line tools and python.

(i) We will use the 'tabix' tool to download the portion of the ExAc VCF file that contains all mutations in the KMT2D gene. 'tabix' is a very useful command line tool that works with tabular data (VCF files, bed files) to extract the subset of lines that overlap a genomic interval (start and end of the KMT2D gene in this example).

```Shell
tabix -h ftp://ftp.broadinstitute.org/pub/ExAC_release/release0.3.1/ExAC.r0.3.1.sites.vep.vcf.gz 12:49412758-49453557  > KMT2D.ExAc.vcf
```

(ii) Using simple grep commands, we can identify the number of LoF variant sites in this VCF file. LoF variants are of three types: stop_gain, splice_acceptor/splice_donor and frameshift.

```Shell
grep "stop_gain" KMT2D.ExAc.vcf | grep PASS | wc -l
grep "splice_acceptor" KMT2D.ExAc.vcf | grep PASS | wc -l
grep "splice_donor" KMT2D.ExAc.vcf | grep PASS | wc -l
grep "frameshift_variant" KMT2D.ExAc.vcf | grep PASS | wc -l
```

What is the total number of LoF variant sites in the KMT2D gene ? Does the number of LoF variants match up with the ExAc website: http://exac.broadinstitute.org/gene/ENSG00000167548 (select LoF box). What is the total number of LoF mutations if we do not use the 'PASS' variant filter ? 

(iii) Notice that some of the LoF sites are multi-allelic, i.e. the same base has multiple variant alleles. This information is represented in the VCF file on a single line but makes it difficult to parse it. We will use the python script "count_lof.py" to calculate the combined frequency of LoF variants in this gene.

```Shell
python count_lof.py KMT2D.ExAc.vcf
```


(iv) Next, we will use LoF constraint scores (pLI, column 20 in the file 'fordist_cleaned_exac_nonTCGA_z_pli_rec_null_data.txt') from the ExAc database to prioritize LoF mutations in an individual. The list of LoF mutations in an individual's exome has already been extracted from the VCF file.

The two files needed for this analysis: 
* fordist_cleaned_exac_nonTCGA_z_pli_rec_null_data.txt 
* sample.LoFgenes

```Shell
sort -k 2,2 DATA/fordist_cleaned_exac_nonTCGA_z_pli_rec_null_data.txt > allgenes.scores
sort -k 1,1 DATA/sample.LoFgenes > sample.LoFgenes.sorted
join -1 2 -2 1 allgenes.scores sample.LoFgenes.sorted | cut -d ' ' -f1,20 | sort -k 2,2g > sample.LoFgenes.scores
```
The sample.LoFgenes.scores should have the list of genes with a LoF mutation in the individual and the corresponding LoF constraint score (pLI). What is the most constrained gene in the list (high pLI score) ? Does this gene have a disease association in humans (https://www.omim.org/entry/603732) ?



## 2. Prioritizing disease genes using gene expression data (RNA-seq) 

Gene expression information can be used to prioritize genes for association with disease. The GTEx project (http://gtexportal.org/home/) has generated RNA-seq data on more than 50 different tissues and cell-lines on > 50 individuals. Summary data (RPKM values per gene for each tissue) is available for download from the GTEX website. We will use this data to analyze gene expression in disease-associated genes. 

File with RPKM values for all ENSEMBL transcripts and 50+ tissues/cell lines in a table format. 
* GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_median_rpkm.gct

The first line of this file gives information about the tissues/cell-lines and each subsequent line has the expression information for an individual transcript. This file can easily be loaded into excel as well. 

(i) Extract the gene expression values for KMT2D from the data. 

```Shell
grep KMT2D DATA/GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_median_rpkm.gct
```
KMT2D is expressed at a high level across virtually all tissues which is consistent with the multi-organ phenotype associated with Kabuki syndrome. A visual plot of the RPKM values can be seen at http://gtexportal.org/home/gene/KMT2D 


(ii) Compare the expression pattern for KMT2D to a tissue-specific gene such as INS which is expressed at a very high level in the pancreas (RPKM = 1289) and at very low levels in all other tissues: http://gtexportal.org/home/gene/INS 

```Shell
cat DATA/GTEx_Analysis_v6p_RNA-seq_RNA-SeQCv1.1.8_gene_median_rpkm.gct | awk '{ if ($2 == "INS") print; }' 
```

(iii) MLL2/KMT2D is the primary gene that is mutated in Kabuki syndrome (discussed in lecture). KDM6A is another gene that has been implicated in Kabuki syndrome. This suggests that the genes should have a similar expression profile. We will calculate the correlation between the expression profiles of KMT2D and KDM6A using the scipy.stats.spearmanr function:

```Shell
python corr.py KMT2D KDM6A
```

The correlation between the expression values of the two genes is high. This is also apparent from visual inspection of plots for the two genes: http://gtexportal.org/home/gene/KMT2D and http://gtexportal.org/home/gene/KDM6A 


(iv) Next, we will use correlation analysis to find genes that have a very similar (corr. coefficient > 0.9) expression profile to KMT2D.

```Shell
python corr.py KMT2D all > KMT2D.highcorrgenes
```

(v) Sort the list by the correlation coefficient value to find the top three genes whose expression is highly correlated with the expression profile of KMT2D. Use the constrained LoF scores data to determine if these genes are also constrained against LoF mutations.

```Shell
sort -k 3,3g KMT2D.highcorrgenes | tail -n 5
grep KMT2B DATA/fordist_cleaned_exac_nonTCGA_z_pli_rec_null_data.txt | cut -f2,20
grep BRPF1 DATA/fordist_cleaned_exac_nonTCGA_z_pli_rec_null_data.txt | cut -f2,20
```

All these genes correspond to epigenetic regulators or histone-modifying proteins and have been linked to rare childhood diseases. 


## 3. Phasing of heterozygous variants from sequence data.
In the lecture, we discussed how sequence reads can be used to infer haplotypes for human genomes. In this exercise, we will use aligned sequence data from a human genome (NA12878) generated using two different sequencing technologies to assemble haplotypes using a computational tool, HapCUT. 

Input files are (BAM file and VCF file for each platform in the region chr6:117,198,376-117,253,326): 
* na12878.illumina.bam 
* na12878.illumina.vcf
* na12878.pacbio.bam 
* na12878.pacbio.vcf (same as na12878.illumina.vcf except for chromosome names)

(i) First, we will assemble haplotypes using the Illumina sequence data: 

```Shell
~/hapcut/extractHAIRS --bam DATA/na12878.illumina.bam --VCF DATA/na12878.illumina.vcf > na12878.illumina.fragments
~/hapcut/HAPCUT --fragments na12878.illumina.fragments --VCF DATA/na12878.illumina.vcf --out na12878.illumina.haplotypes --maxiter 20 > na12878.illumina.log 
```
The output file 'na12878.illumina.haplotypes' is a text file with information about variants that could be phased together into haplotype blocks. For each variant, the 2nd and 3rd columns indicate whether the '0' allele (reference) or '1' allele (variant) is on the first (or second) haplotype. 

Next, we will get statistics on the number of haplotype blocks in this file and the average length of each haplotype block: 

```Shell
grep BLOCK na12878.illumina.haplotypes  | awk '{ b++; len += $9; } END { print "blocks:",b,"mean-length",len/b; }'
```
From the output, we can see that there are 21 haplotype blocks. The input VCF file has 111 variants (103 of which are heterozygous). 

(ii) We will repeat the same process to assemble haplotypes using the Pacific Biosciences SMRT long-read data: 

```Shell
~/hapcut/extractHAIRS --bam DATA/na12878.pacbio.bam --VCF DATA/na12878.pacbio.vcf > na12878.pacbio.fragments
~/hapcut/HAPCUT --fragments na12878.pacbio.fragments --VCF DATA/na12878.pacbio.vcf --out na12878.pacbio.haplotypes --maxiter 20 > na12878.pacbio.log
grep BLOCK na12878.pacbio.haplotypes  | awk '{ b++; len += $9; } END { print "blocks:",b,"mean-length",len/b; }'
```

From the output, we observe that the all the 103 heterozygous variants were assembled into a single haplotype block. This is due to the long read lengths of the PacBio reads (5-20 kb) compared to Illumina reads (100 bp reads, 300-500 bp fragments). 

(iii) We can visualize the aligned reads for the two technologies using the IGV tool. 

```Shell
java -jar ~/IGV_2.3.89/igv.jar  DATA/na12878.illumina.bam chr6:117,198,376-117,253,326 
```

In the IGV view, we can load the na12878.pacbio.bam file and change the view to 'squished'. If we zoom in to a small region, we can see that the same variants are identified using both sequence technologies. Visualizing aligned reads using the IGV tool is useful for visually validating variants as well as comparing datasets. 


## Homework exercises

1. Modify the count_lof.py script to calculate the number of missense mutations in Exon 51 of KMT2D (12:49416372-49416658) in the ExAc database. Alternatively, use data from the ExAc website for the KMT2D gene to do this calculation. Calculate the per-base rate of missense mutations in Exon 51 using the length of the exon. Do the same analysis for Exon 48 (12:49419964-49421105). Is the rate of missense mutations in Exon 51 higher than Exon 48 ? 

2. Use the GTEX RNA-seq expression data to find genes that show a tissue-specific expression profile, i.e. genes for which the expression in the tissue with the maximum RPKM value is at least 5 times the RPKM values in all other tissues. Report the top 5 genes that are primarily expressed in 'pancreas'. 

3. The number of haplotype blocks assembled from sequence data depends on the length of the sequence reads. Use the na12878.illumina.vcf variant file to estimate the number of haplotype blocks for different read lengths: 100, 250, 500, 1000, 2000, 3000 bp. Assume that sequence coverage is not a limitation. Does the number of haplotype blocks continue to decrease as read lengths are increased or does it reach a plateau ?







