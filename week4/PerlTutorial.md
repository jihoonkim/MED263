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
You can use other editors (e.g. emachs, nano, sublime, vim) 
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


### Installl BioPerl
```{bash, echo = TRUE }
git clone https://github.com/bioperl/bioperl-live.git
cd bioperl-live
perl Build.PL
sudo ./Build install
```


### BLAST search of a mystery sequence 
```{perl, echo = TRUE }
#!perl -w
use Bio::Tools::Run::RemoteBlast;
use Bio::SearchIO;
use Data::Dumper;

# Input file for BLAST
my $infile = 'mysterysequence.fasta';

#Here i set the parameters for blast
$prog = "blastn";
$db = "nr";
$e_val = "1e-10";
my @params = ( '-prog' => $prog,
               '-data' => $db,
               '-expect' => $e_val,
               '-readmethod' => 'SearchIO' );

my $remoteBlast = Bio::Tools::Run::RemoteBlast->new(@params);

#Select the file and make the blast.
my $r = $remoteBlast->submit_blast($infile);

my $v = 1;
print STDERR "waiting..." if( $v > 0 ); ######## WAIT FOR THE RESULTS TO RETURN!!!!!
while ( my @rids = $remoteBlast->each_rid ) {
  foreach my $rid ( @rids ) {
    my $rc = $remoteBlast->retrieve_blast($rid);
    if( !ref($rc) ) {  

      if( $rc < 0 ) {
        $remoteBlast->remove_rid($rid);
      }
      print STDERR "." if ( $v > 0 );

      sleep 5;
   
    } else {
       my $result = $rc->next_result();

       #save the output
       my $filename = $result->query_name()."\.out";
       $remoteBlast->save_output($filename);
       $remoteBlast->remove_rid($rid);
       print "\nQuery Name: ", $result->query_name(), "\n";

       while ( my $hit = $result->next_hit ) {
         next unless ( $v > 0);
         print "\thit name is ", $hit->name, "\n";

         while( my $hsp = $hit->next_hsp ) {
           print "\t\tscore is ", $hsp->score, "\n";
         }
       }
   }
  }
}
```