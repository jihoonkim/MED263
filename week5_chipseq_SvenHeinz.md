
# MED 263: ChIP-Seq Exercises

---

##### Reference
http://homer.ucsd.edu/homer/workshops/170209-MED263/

## Goal
This tutorial will walk you through an example of ChIP-seq analysis using HOMER.  It starts with aligned SAM files (only reads from mouse chr17) and performs many of the basic analysis tasks that one might normally do when analyzing ChIP-seq data.

## Download data
Download the zip file containing SAM alignment files and unzip the archive.
```Shell
wget -O samfiles.zip http://homer.ucsd.edu/homer/workshops/170209-MED263/samfiles.zip
unzip samfiles.zip
```

The archive should contain the following SAM files that have been aligned to the mouse mm9 genome:

h3k27ac-esc.chr17.2m.sam
h3k4me2-esc.chr17.2m.sam
input-esc.chr17.2m.sam
klf4-esc.chr17.2m.sam
oct4-esc.chr17.2m.sam
sox2-esc.chr17.2m.sam

These files are originally from the following study investigating the roles that reprogramming factors play when transforming MEF (fibroblasts) into embryonic stem cells.

[Chronis et al. Cooperative Binding of Transcription Factors Orchestrates Reprogramming](https://www.ncbi.nlm.nih.gov/pubmed/28111071)

Sequencing Data: [GSE90893](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE90893)

For this tutorial we extracted the ChIP-seq experiments for several transcription factors and histone modifications performed ESC (embryonic stem cells).  To reduce runtimes, only reads that mapped to chr17 (and chr17_random) are included in the SAM files.



## Create a tag directory
Create a "tag directory" for the Oct4 ChIP-seq experiment using the makeTagDirectory command.  
Tag directories are analogous to sorted bam files and are the starting point for most HOMER operations like finding peaks, creating visualization files, or calculating read densities. 
The command also performs several quality control and parameter estimation calculations. 
The command has the following form:
```Shell
makeTagDirectory <Output Tag Directory> [options] <input SAM file1> [input SAM file2] ...
```

You can see a full list of program options by simply running the command without any options. To create a tag directory for the Oct4 experiment, run the following command with recommended options:
```Shell
makeTagDirectory ESC-Oct4-mm9 -genome mm9 -checkGC oct4-esc.chr17.2m.sam
```

The command will take several seconds to run.  What it is doing is parsing through the SAM file, removing reads that do not align to a unique position in the genome, separating reads by chromosome and sorting them by position, calculating now often reads appear in the same position to estimate the clonality (i.e. PCR duplication), calculating the relative distribution of reads relative to one another to estimate the ChIP-fragment length, calculating sequence properties and GC-content of the reads, and performs a simple enrichment calculation to check if the experiment looks like a ChIP-seq experiment (vs. an RNA-seq experiment).

The command creates a new directory, in this case named "ESC-Oct4-mm9".  Inside the directory are several text files that contain various QC results.  Try opening the following in a spreadsheet program (like open office or Excel):

* tagInfo.txt - summary information from the experiment, including read totals
* tagFreqUniq.txt - nucleotide frequencies relative to the 5' end of the sequencing reads.
* gcContent.txt - distribution of ChIP-fragment GC%
* tagAutocorrelation.txt - relative distribution of reads found on the same strand vs. different strands.
* tagCountDistribution.txt - number of reads appearing at the same positions.


Create tag directories for the input (control), Sox2, and H3K27ac ChIP-seq experiments similar to how the Oct4 tag directory was created.
```Shell
makeTagDirectory ESC-Input-mm9 -genome mm9 -checkGC input-esc.chr17.2m.sam
makeTagDirectory ESC-Sox2-mm9 -genome mm9 -checkGC sox2-esc.chr17.2m.sam
makeTagDirectory ESC-H3K27ac-mm9 -genome mm9 -checkGC h3k27ac-esc.chr17.2m.sam
```

At this point you should have 4 tag directories (including the ESC-Oct4-mm9 directory). 
Feel free to look through the QC stats.


## Created bedGraph files for visualization
Next we will visualize the ChIP-seq experiments by creating bedGraph files from the tag directories and using the UCSC genome browser to look at the results.  We will do this using the makeUCSCfile command.  For most ChIP-seq experiments all you need to do is specify the tag directory and specify "-o auto" for the command to automatically save the bedGraph file inside the tag directory:
```Shell
makeUCSCfile <Tag Directory> -o auto
```

For Oct4, the command would be:
```Shell
makeUCSCfile ESC-Oct4-mm9 -o auto
```

This creates the file "ESC-Oct4-mm9/ESC-Oct4-mm9.ucsc.bedGraph.gz".  This file format specifies the normalized read depth at variable intervals along the genome (use zmore and the filename to view the file format for yourself). To view the file in the genome browser, do the following:

1. Visit https://genome.ucsc.edu/ with your internet browser.
2. In the top menu, click on "Genomes" -> "Mouse NCBI37/mm9" to go to the mouse mm9 version of the genome.
3. In the top menu, click on "My Data" -> "Custom Tracks".
4. In the "Paste URLs or data" input field, upload the ESC-Oct4-mm9.ucsc.bedGraph.gz file from the tag directory and hit submit.

Once the file finishes uploading, click go to go to the genome browser and start surfing the genome.  The read pileups will display the relative density of ChIP-seq reads at each position in the genome.  REMEMBER that we only have data for chr17 in this example, so stick to that chromosome.

Create bedGraph files for the other tag directories and upload them to the genome browser.  Repeat step 4 for Sox2, Input, and H3K27ac:
```Shell
makeUCSCfile ESC-Sox2-mm9 -o auto
makeUCSCfile ESC-Input-mm9 -o auto
makeUCSCfile ESC-H3K27ac-mm9 -o auto
```

See if there are any interesting patterns in the data that catch your eye.  Try visiting the Pou5f1 locus (the gene for Oct4) by typing the gene name into the search bar at the top.  Once at the Pou5f1 locus, zoom out 10x to see if there any nearby sites that might resemble enhancers.


## Find peaks

One of the most common tasks with ChIP-seq data is to find 'enriched' regions commonly called "peaks".  HOMER contains a command called findPeaks which is used to analyze tag directories for peaks.  There are two common ways to use the command:
```Shell
findPeaks <tag directory> -i <control tag directory> -style factor -o auto
findPeaks <tag directory> -i <control tag directory> -style histone -o auto
```

The difference between the two is in the "-style factor/histone" argument, which will tell the program to look for focal, fixed width peaks vs. variable lengthed peaks, the later which is more common in the case of histone modifications. To find Oct4 peaks in the data, run the following command:
```Shell
findPeaks ESC-Oct4-mm9 -i ESC-Input-mm9 -style factor -o auto
```

This command will look for enriched regions and filter them based on several criterion, including ensuring that they have at least 4-fold more reads in peak regions relative to the control experiment (in this case "ESC-Input-mm9/"). The output will be stored in a HOMER-style peak file located in the Oct4 tag directory ("ESC-Oct4-mm9/peaks.txt").  The beginning of this file contains statistics and QC stats from the peak finding, including the number of peaks, number of peaks lost to input filtering, etc.  One field worth paying attention to is the "Approximate IP efficiency" which reports what fraction of reads from the experiment were actually found in peaks.  For most decent experiments this value ranges from 1% to >30% (remember ChIP is an enrichment strategy... there is plenty of background in the data too!).  Below this are the peaks along with enrichment statistics for each region.

One other thing to note is that HOMER reports the results in a 'peak' file, which has a slightly different format from a traditional BED file format.  To create a BED file from the peak file, use the tool pos2bed.pl (i.e. pos2bed.pl ESC-Oct4-mm9/peaks.txt > oct4.bed). BED files can be uploaded to the Genome Browser just like a bedGraph file.  Also, most HOMER programs will work with either BED or peak files as input.
Next find peaks for Sox2 and H3K27ac - remember that H3K27ac is a histone modification, and it is recommended to use the "-style histone" for that experiment.
```Shell
findPeaks ESC-Sox2-mm9 -i ESC-Input-mm9 -style factor -o auto
findPeaks ESC-H3K27ac-mm9 -i ESC-Input-mm9 -style histone -o auto
```