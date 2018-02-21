## MED 263: Chip-seq

---


## Goal
This tutorial will walk you through an example of ChIP-seq analysis using [HOMER](http://homer.ucsd.edu/).  It starts with aligned SAM files (only reads from mouse chr17) and performs many of the basic analysis tasks that one might normally do when analyzing ChIP-seq data.


## Step 0. Prerequisites

1. Install [Docker Community Edition](https://www.docker.com/community-edition#/download)

2. Choose a working directory, for example, `/Users/johndoe/mylocalfolder`,  and change to that directory in your host computer (your laptop computer in most cases).
```bash
cd /Users/johndoe/mylocalfolder
```

## Step 1. Start running docker and download data

1. Start running docker by typing following command in Terminal (macOS/Linux) or Docker Quickstart Terminal (Windows). Be sure to replace `/Users/johndoe/mylocalfolder` with your own working directory in your local/host computer (=laptop computer).
```bash
docker run -it -v /Users/johndoe/mylocalfolder:/work j5kim/med263-heinz /bin/bash
```
In this way, you are binding a host directory (outside docker container) to the directoy inside docker container so that all your works (e.g. processed data, output) remain after docker container gets stopped. Otherwise, all your work will be gone and you will have to rerun everything from the beginning.

2. `INSIDE DOCKER CONTAINER`, download the mouse (mm9) resource data
```bash
perl /opt/homer/configureHomer.pl -install mm9
```

3. Download example data, a zip file containing SAM alignment files, and unzip the archive.
```bash
cd /work
wget -O samfiles.zip http://homer.ucsd.edu/homer/workshops/170209-MED263/samfiles.zip
unzip samfiles.zip
```
The archive should contain the following SAM files that have been aligned to the **mouse mm9 genome**:
* h3k27ac-esc.chr17.2m.sam
* h3k4me2-esc.chr17.2m.sam
* input-esc.chr17.2m.sam
* klf4-esc.chr17.2m.sam
* oct4-esc.chr17.2m.sam
* sox2-esc.chr17.2m.sam
These files are originally from the following study investigating the roles that reprogramming factors play when transforming MEF (fibroblasts) into embryonic stem cells. [Chronis et al. Cooperative Binding of Transcription Factors Orchestrates Reprogramming](https://www.ncbi.nlm.nih.gov/pubmed/28111071) with sequencing data [GSE90893](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE90893). For this tutorial we extracted the ChIP-seq experiments for several transcription factors and histone modifications performed ESC (embryonic stem cells).  To reduce runtimes, only reads that mapped to chr17 (and chr17_random) are included in the SAM files.



## Step 2. Create a tag directory

Create a "tag directory" for the Oct4 ChIP-seq experiment using the makeTagDirectory command.  
Tag directories are analogous to sorted bam files and are the starting point for most HOMER operations like finding peaks, creating visualization files, or calculating read densities. 
The command also performs several quality control and parameter estimation calculations. 
The command has the following form:
```bash
makeTagDirectory <Output Tag Directory> [options] <input SAM file1> [input SAM file2] ...
```

You can see a full list of program options by simply running the command without any options. To create a tag directory for the Oct4 experiment, run the following command with recommended options:
```bash
makeTagDirectory ESC-Oct4-mm9 -genome mm9 -checkGC oct4-esc.chr17.2m.sam
```

The command will take several seconds to run.  What it is doing is parsing through the SAM file, removing reads that do not align to a unique position in the genome, separating reads by chromosome and sorting them by position, calculating now often reads appear in the same position to estimate the clonality (i.e. PCR duplication), calculating the relative distribution of reads relative to one another to estimate the ChIP-fragment length, calculating sequence properties and GC-content of the reads, and performs a simple enrichment calculation to check if the experiment looks like a ChIP-seq experiment (vs. an RNA-seq experiment).

The command creates a new directory, in this case named "ESC-Oct4-mm9".  Inside the directory are several text files that contain various QC results.  Try opening the following in a spreadsheet program (like open office or Excel):

* tagInfo.txt - summary information from the experiment, including read totals
* tagFreqUniq.txt - nucleotide frequencies relative to the 5' end of the sequencing reads.
* gcContent.txt - distribution of ChIP-fragment GC%
* tagAutocorrelation.txt - relative distribution of reads found on the same strand vs. different strands.
* tagCountDistribution.txt - number of reads appearing at the same positions.


## Step 3. Create more tag directories

Create tag directories for the input (control), Sox2, and H3K27ac ChIP-seq experiments similar to how the Oct4 tag directory was created.
```bash
makeTagDirectory ESC-Input-mm9 -genome mm9 -checkGC input-esc.chr17.2m.sam
makeTagDirectory ESC-Sox2-mm9 -genome mm9 -checkGC sox2-esc.chr17.2m.sam
makeTagDirectory ESC-H3K27ac-mm9 -genome mm9 -checkGC h3k27ac-esc.chr17.2m.sam
```

At this point you should have 4 tag directories (including the ESC-Oct4-mm9 directory). 
Feel free to look through the QC stats.


## Step 4. Create bedGraph files for visualization

Next we will visualize the ChIP-seq experiments by creating bedGraph files from the tag directories and using the UCSC genome browser to look at the results.  We will do this using the makeUCSCfile command.  For most ChIP-seq experiments all you need to do is specify the tag directory and specify "-o auto" for the command to automatically save the bedGraph file inside the tag directory:
```bash
makeUCSCfile <Tag Directory> -o auto
```

For Oct4, the command would be:
```bash
makeUCSCfile ESC-Oct4-mm9 -o auto
```

This creates the file "ESC-Oct4-mm9/ESC-Oct4-mm9.ucsc.bedGraph.gz".  This file format specifies the normalized read depth at variable intervals along the genome (use zmore and the filename to view the file format for yourself). To view the file in the genome browser, do the following:

1. Visit https://genome.ucsc.edu/ with your internet browser.
2. In the top menu, click on "Genomes" -> "Mouse NCBI37/mm9" to go to the mouse mm9 version of the genome.
3. In the top menu, click on "My Data" -> "Custom Tracks".
4. In the "Paste URLs or data" input field, upload the ESC-Oct4-mm9.ucsc.bedGraph.gz file from the tag directory and hit submit.

Once the file finishes uploading, click go to go to the genome browser and start surfing the genome.  The read pileups will display the relative density of ChIP-seq reads at each position in the genome.  REMEMBER that we only have data for chr17 in this example, so stick to that chromosome.

## Step 5. Create more bedGraph files 

Create bedGraph files for the other tag directories and upload them to the genome browser.  Repeat step 4 for Sox2, Input, and H3K27ac:
```bash
makeUCSCfile ESC-Sox2-mm9 -o auto
makeUCSCfile ESC-Input-mm9 -o auto
makeUCSCfile ESC-H3K27ac-mm9 -o auto
```

See if there are any interesting patterns in the data that catch your eye.  Try visiting the Pou5f1 locus (the gene for Oct4) by typing the gene name into the search bar at the top.  Once at the Pou5f1 locus, zoom out 10x to see if there any nearby sites that might resemble enhancers.


## Step 6. Find peaks

One of the most common tasks with ChIP-seq data is to find 'enriched' regions commonly called "peaks".  HOMER contains a command called findPeaks which is used to analyze tag directories for peaks.  There are two common ways to use the command:
```bash
findPeaks <tag directory> -i <control tag directory> -style factor -o auto
findPeaks <tag directory> -i <control tag directory> -style histone -o auto
```

The difference between the two is in the "-style factor/histone" argument, which will tell the program to look for focal, fixed width peaks vs. variable lengthed peaks, the later which is more common in the case of histone modifications. To find Oct4 peaks in the data, run the following command:
```bash
findPeaks ESC-Oct4-mm9 -i ESC-Input-mm9 -style factor -o auto
```

This command will look for enriched regions and filter them based on several criterion, including ensuring that they have at least 4-fold more reads in peak regions relative to the control experiment (in this case "ESC-Input-mm9/"). The output will be stored in a HOMER-style peak file located in the Oct4 tag directory ("ESC-Oct4-mm9/peaks.txt").  The beginning of this file contains statistics and QC stats from the peak finding, including the number of peaks, number of peaks lost to input filtering, etc.  One field worth paying attention to is the "Approximate IP efficiency" which reports what fraction of reads from the experiment were actually found in peaks.  For most decent experiments this value ranges from 1% to >30% (remember ChIP is an enrichment strategy... there is plenty of background in the data too!).  Below this are the peaks along with enrichment statistics for each region.

One other thing to note is that HOMER reports the results in a 'peak' file, which has a slightly different format from a traditional BED file format.  To create a BED file from the peak file, use the tool pos2bed.pl (i.e. pos2bed.pl ESC-Oct4-mm9/peaks.txt > oct4.bed). BED files can be uploaded to the Genome Browser just like a bedGraph file.  Also, most HOMER programs will work with either BED or peak files as input.
Next find peaks for Sox2 and H3K27ac - remember that H3K27ac is a histone modification, and it is recommended to use the "-style histone" for that experiment.
```bash
findPeaks ESC-Sox2-mm9 -i ESC-Input-mm9 -style factor -o auto
findPeaks ESC-H3K27ac-mm9 -i ESC-Input-mm9 -style histone -o auto
```

## Step 7. Annotate peaks

Now that we have identified peaks from our ChIP-seq data, it is time to figure out more information about where they are and what genes they might be regulating.  HOMER contains a program called annotatePeaks.pl that performs a wide variety of functions using peak/BED files.  First, lets use it to perform basic annotation of the peak file.  The annotatePeaks.pl program works like this:
```bash
annotatePeaks.pl <peak/BED file> <genome version> [options] > output.txt
```

The "> output.txt" part at the end means that the results will be sent to stdout, and the "> output.txt" is used to capture the output information in a file.  To annotate peaks from the Oct4 experiment:
```bash
annotatePeaks.pl ESC-Oct4-mm9/peaks.txt mm9 > oct4.annotation.txt
```

If we open the "oct4.annotation.txt" file with a spreadsheet program/Excel, you'll see several annotation columns. Take note of the columns specifying the nearest gene TSS, the distance, and the annotation of the genomic region the peak is located in. This annotation is split into two separate columns - one is basic (i.e. exon, promoter, intergenic, intron etc.), and a more detailed annotation that describes CpG islands, repeat elements, etc.). You might have also noticed while the command was running that stats about annotation enrichment too.


## Step 8. Annotate more peaks

The annotatePeaks.pl program can also be used to create histograms that display the relative read enrichment relative to given genomic features, including transcription start sites (TSS) or any other set of regions the user wants to define.  Since the TSS is so commonly used for this purpose, HOMER has a built-in annotation for TSS (based on RefSeq transcripts).  The key parameters to create a histogram are the "-hist #" and "-size #" options, which control the binning size and total length of the histogram.  The other important option is the "-d <tag directory>", which specifies which experiments to compile histograms for.  In general:
```bash
annotatePeaks.pl <peak/BED file> <genome version> -size <#> -hist <#> -d <Tag Directory1> > output.txt
```

(note that the peak/BED file can be replaced with the key work "tss" to make a histogram at the TSS)
To create a histogram will the experiments we've looked at so far near the TSS, run the following:
```bash
annotatePeaks.pl tss mm9 -size 8000 -hist 10 -d ESC-Oct4-mm9/ ESC-Sox2-mm9/ ESC-H3K27ac-mm9/ ESC-Input-mm9/ > output.txt
```

Open the "output.txt" file with a spreadsheet program/Excel.  You'll notice that the first column gives the distance offsets from the TSS followed by columns corresponding to the 'coverage', '+ Tags', and '- Tags' for each experiment.  Try graphing each as X-Y line graph using the first column as the X-coordinate to see the patterns.



## Step 9. Find DNA motifs

DNA motif finding is a powerful technique to analyze ChIP-seq experiments.  Unlike gene expression data, ChIP-seq localizes signals to very specific regions of the genome allowing for accurate identification of the genetic signals responsible for recruiting various transcription factors.  To use HOMER's motif analysis program, run the findMotifsGenome.pl command using peak files from the experiments.  In general the command works like this:
```bash
findMotifsGenome.pl <peak/BED file> <genome version> <output directory> [options]
```

Common options for motif finding are "-p <#cpu>" for parallel execution, and "-size <#>" to specify the size of the regions you which to search for DNA motifs. For transcription factor motifs, a good size is 100.  To find Oct4 enriched motifs, run the following command:
```bash
findMotifsGenome.pl ESC-Oct4-mm9/peaks.txt mm9r Motifs-Results-Oct4/ -size 100 -p 10
```

This command will perform several different steps, including checking for the enrichment of a library of known transcription factor motifs as well as perform a de novo search for enriched motifs.  The "mm9r" tells the program to mask repeat sequences in the genome, but it will still work well if you simply specify "mm9" as well. Depending on the speed of your computer this program may take while to run.  Once it's finished, use your Internet Browser to open the homerResults.html file located in the Motifs-Results-Oct4/ directory.  This file will list the top de novo motifs found as well as provide stats and best matches to known transcription factor motifs.  A second file called knownResults.html contains the enrichment statistics for known motifs.  Next try the same for Sox2:
```bash
findMotifsGenome.pl ESC-Sox2-mm9/peaks.txt mm9r Motifs-Results-Sox2/ -size 100 -p 10
```

You might notice that both analyses indicate that Oct4 and Sox2 peaks in ESC are highly enriched for an OCT:SOX composite motif, which has been shown to be very important in establishing pluripotent enhancers.


## Step 10. Find motif locations 

Now that you've found the most enriched motifs in a ChIP-seq experiment, it is worth it to see where those motifs are located (i.e. which peaks, etc.). One of the key outputs from motif finding are "motif files", which contain the information needed to understand where the motif is located in the genome. For example, the top de novo motifs found during motif finding are located in the output directory in the homerResults/ directory.  To make it easier, lets copy to top Oct4 motif to the the file "topOct4.motif" in the main directory where we are executing these commands (alternatively you could save the motif file down from the HTML results):
```bash
cp Motifs-Results-Oct4/homerResults/motif1.motif topOct4.motif
```

Now lets perform two separate analyses - first, lets create a histogram showing the motif positions relative to Oct4 peaks so we can check if it really looks enriched relative to the center of the Oct4 peaks.  We can do this using the annotatePeaks.pl program like before, but instead of looking at read densities with the "-d <tag directory>" option we can look at motif densities using the '-m <motif file>" option instead:
```bash
annotatePeaks.pl ESC-Oct4-mm9/peaks.txt mm9 -size 2000 -hist 10 -m topOct4.motif > output.Oct4motifHistogram.txt
```

Once the command finishes, open output.Oct4motifHistogram.txt in a spreadsheet program and create an X-Y plot to examine the distribution of the motif relative to the peaks.

Next, lets see where these motifs are located in the actual genome browser.  To do this, we can run annotatePeaks.pl again, but this time we will not make a histogram and instead use the "-mbed <bedfile>" option to tell it to create a bed file of the motif positions that we can upload to the genome browser.  Try the following:
```bash
annotatePeaks.pl ESC-Oct4-mm9/peaks.txt mm9 -mbed topOct4.motifTrack.bed -m topOct4.motif > output.txt
```

Now you can load the "topOct4.motifTrack.bed" file as a custom track in the UCSC genome browser just like we did in step 4 for bedGraph files.  In addition, the other output file "output.txt" will contain the peak annotation results with an additional column showing the peaks that contain the given motif.


## Step 11. Investigate differential peaks

Finally, we want to gain some experience comparing ChIP-seq experiments. At first pass it might make sense to make a Venn diagram comparing peaks from two experiments to see how many overlap. This is a horrible way to analyze ChIP-seq data!!! This is because many peaks are close to the threshold of detection, barely making the cut for statistical significance (or not) in one experiment or another.  A good practice is to create a scatter plot comparing the read counts between two experiments directly at all of the sites where there is signal (i.e. peaks).  To do this, first lets merge the peak files from the two experiments, collapsing peaks found that overlap:
```bash
mergePeaks ESC-Oct4-mm9/peaks.txt ESC-Sox2-mm9/peaks.txt > Oct4andSox2.peaks.txt
```

When you run this command, you'll notice that it will print out the numbers of overlapping and unique peaks from each file (i.e. Venn diagram).  This can be useful to give you a general idea of how similar the experiments are, but be careful not to over interpret these values.  Now that you have the combined features in the "Oct4andSox2.peaks.txt" file, lets use annotatePeaks.pl to quantify the read counts from each experiment at each of the peaks by specify each tag directory with the -d option like the following:
```bash
annotatePeaks.pl Oct4andSox2.peaks.txt mm9 -d ESC-Oct4-mm9/ ESC-Sox2-mm9/ > scatter.txt
```

We can not open the scatter.txt file in a spreadsheet program to directly look at the read counts at each peak to find those with low levels in one experiment or the other.  Try creating an X-Y scatter plot of the read counts with log-transformed axes to get a sense for how different (or similar) each experiment is from one another. Now that we have an appreciation for how similar the experiments are, lets try using the getDifferentialPeaks command to selective find peaks that are 'specific' to one experiment relative to another.  In the following example we'll specify "-F 2" to indicate that we want to find Sox2 peaks that are 2-fold higher in the Sox2 experiment relative to the Oct4 experiment:
```bash
getDifferentialPeaks <peak file to check> <target tag directory> <background tag directory> -F <fold change> > output.txt
getDifferentialPeaks ESC-Sox2-mm9/peaks.txt ESC-Sox2-mm9/ ESC-Oct4-mm9/ -F 2 > sox2-specific-peaks.txt
```

Now that we have found Sox2 peaks that are relatively uniquely bound by Sox2 (and not Oct4), open the peak file (with Excel or using "more sox2-specific-peaks.txt") and look at several of the peaks in the genome browser to convince yourself that we have found interesting peaks.

Finally, lets use motif finding to see if we can identify what is unique about the DNA sequences in the Sox2 -specific peaks that might have lead to a differential recruitment of Sox2 versus Oct4 at these sites.  Run motif finding on the Sox2 specific peaks:
```bash
findMotifsGenome.pl sox2-specific-peaks.txt mm9r Motif-Results-Sox2-Specific/ -size 100 -p 10
```

Notice anything different about these results relative to the results from all Sox2 peaks that we found in step 9?


# Homework

---

This homework follows the basic framework of the practical session above using additional SAM files that we did not analyze in class.  Below are questions found highlighted in RED - place the answers to the questions in a text file to turn in next week.

1. If you haven't already downloaded the files for the practical session above, download the zip file containing SAM alignment files and unzip the archive (NOTE: these are the same as above):
```bash
wget -O samfiles.zip http://homer.ucsd.edu/homer/workshops/170209-MED263/samfiles.zip
unzip samfiles.zip
```

2. Create tag directories for the remaining sam files using the makeTagDirectory command (H3K4me2, a histone modification found at enhancer and promoters, and Klf4, another pluripotent transcription factor).
```
Q1: What is the average GC% of the ChIP-fragments found in the H3K4me2 and Klf4 ChIP-seq experiments?(hint: look in the tagInfo.txt file or look at the values reported at the end of the makeTagDirectory command)
```

3. Next visualize the H3K4me2 and Klf4 ChIP-seq experiments by creating bedGraph files from the tag directories and using the UCSC genome browser upload and view the tracks. Go to the Zfp57 gene located on chr17, and zoom out 10x (relative to the length of the gene).
```
Q2: Within this range (chr17:37,102,000-37,184,000), where  is the highest Klf4 peak located (coordinates)? Is there significant signal for H3K4me2 and H3K27ac (relative to Input) in the vicinity of the peak (i.e. within 1kb)?
```

4. Find peaks for Klf4 and H3K4me2 ChIP-seq experiments. Remember that Klf4 is a transcription factor and H3K4me2 is a histone modification.  Also remember to consider the Input experiment as well!
```
Q3: How many peaks were found for Klf4 and H3K4me2?
```

5. Use annotatePeaks.pl to provide annotation for the Klf4 peaks from the previous step.  Look at the entry for the top/best peak in the file (top row after the header).
```
Q4: Which gene is the top Klf4 peak nearest to?  Is is located in an exon, intron, intergenic, or promoter region?
```

6. Use findMotifsGenome.pl to analyze the Klf4 peaks for the enriched DNA motifs found associated with the Klf4 peaks.  (remember to use a size range of 100 i.e. "-size 100").
```
Q5: What was the consensus sequence for the top de novo motif discovered by the motif finding program? What was the p-value? Which known motif was the best match to this motif?** (NOTE: since background sequences are random, the exact results may vary a little bit, particularly the exact p-value.  Also, the motif may appear in the reverse opposite direction, i.e AACCGG vs. CCGGTT).
```

7. Using annotatePeaks.pl, calculate the read coverage around the Klf4 peaks (+/- 2000 bp) for the H3K4me2, H3K27ac, Oct4, and Sox2 experiments. (Hints: The Klf4 peak file will be the first argument for annotatePeaks.pl, and set the options "-size 4000" and "-hist 10", and remember that you can specify multiple tag directories after the -d option).  Open the resulting file with a spreadsheet program or excel and graph the results (X-Y plot).
```
Q6: At what position relative to the Klf4 peak do each of the ChIP-seq experiments (Sox2, Oct4, H3K4me2, H3K27ac) reach their maximum coverage?  There may be multiple locations where the signal is high.
```

