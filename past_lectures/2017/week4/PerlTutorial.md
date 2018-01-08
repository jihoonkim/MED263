---
title: "MED263 Perl  Tutorial"
author: "Jihoon Kim (j5kim@ucsd.edu)"
date: "2/2/2017"
output: html_document
fontsize: 10pt
---


### Perl 

Perl is a general-purpose, interepreted programming language extensively
used in bioinformatics. 


### Text Editor

An application program to create, type, and edit text documents.
We will use 'gedit' to edit Perl codes.
You can use other editors (e.g. emacs, nano, sublime, vim) 
your are familiar with.

```{bash, echo = TRUE }
gedit test.pl
cat test.pl
```

```{bash, echo = TRUE }
nano test.pl
cat test.pl
```

#### Hello world example
```{bash, echo = TRUE }
gedit hello.pl
```

```{perl, echo = TRUE }
#!/usr/bin/perl -w
# Display a greeting
print "Hello, Jihoon";
exit;
```

```{bash, echo = TRUE }
perl hello.pl
```


#### Display a variable
```{bash, echo = TRUE }
gedit dna.pl
```

```{perl, echo = TRUE }
#!/usr/bin/perl -w

# Store a DNA sequence into a variable called $DNA
$DNA = "ACGGGACT";

# Display a DNA sequence
print $DNA;

exit;
```

```{bash, echo = TRUE }
perl dna.pl
```


#### Transcribe DNA to RNA
```{bash, echo = TRUE }
gedit transcribe.pl
```

```{perl, echo = TRUE }
#!/usr/bin/perl -w

# Store a DNA sequence into a variable called $DNA
$DNA = "ACGGGACT";

# Copy DNA as it is as a variable called $RNA
$RNA = $DNA;

# Replace Thymin (T) with Uracil (U)
$RNA =~ s/T/U/g;

# Display two sequences
print "DNA = ", $DNA, "\n";
print "After transcription\n";
print "RNA = ", $RNA, "\n";

exit;
```

```{bash, echo = TRUE }
perl transcribe.pl
```


### Read from a file
```{bash, echo = TRUE }
wget https://github.com/jihoonkim/MED263/raw/master/week4/mysterysequence.fasta
```

```{perl, echo = TRUE }
#!/usr/bin/perl -w

# set the file name to read
$filename = "mysterysequence.fasta";

# open a file
open( $fh, '<', $filename ) or die "Can't open $filename: $!";

# initialize an empty string
$seq = ""; 

# read each line and concatenate it to a variable $seq
while ( my $line = <$fh> ) {
  
  # if the line does not start with the character '>'
  if (! ($line =~ /^>/) ) {

    # concatenate a line in to a string
    $seq = $seq.$line;
  
  }
}
print $seq;


# close the file 
close $fh;

exit;
```

### Install [BioPerl](http://bioperl.org/), an open source Perl tools for bioinformatics
```{bash, echo = TRUE }
https://www.biostars.org/p/193668/

cpan local::lib


git clone https://github.com/bioperl/bioperl-live.git
cd bioperl-live/
perl Build.PL 


./Build installdeps
./Build install



PERL5LIB=${PERL5LIB}:/opt/bin/bioperl-1.6.1
export PERL5LIB


```
Installing BioPerl takes several minutes.

### BLAST search of a mystery sequence 
```{bash, echo = TRUE }
wget https://github.com/jihoonkim/MED263/raw/master/week4/mysterysequence.fasta
wget https://github.com/jihoonkim/MED263/raw/master/week4/blast.pl
perl blast.pl > blast.out
head blast.out
```

To see the source of this mystery sequence,
search GenBank with AF011222.1, the top scoring accession number.
https://www.ncbi.nlm.nih.gov/nuccore/2286205