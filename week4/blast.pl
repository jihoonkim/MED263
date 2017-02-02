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

#Select the file and make the balst.
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

