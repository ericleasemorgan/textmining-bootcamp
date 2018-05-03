#!/usr/bin/env perl

# pos2tab.pl - given a "POS" file, output a tab-delimited file

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame under a GNU Public License

# April 10, 2018 - first documentation; getting closer to Prague


# configure
use constant HEADER => ( 'POS', 'lemma', 'word' );

# require
use XML::XPath;

# get input
my $xml = $ARGV[ 0 ];

# do error checking here

# initialize
my $pos    = XML::XPath->new( filename => $xml );
my $result = '';
binmode( STDOUT, ':utf8' );

# get all sentences
foreach my $sentence ( $pos->findnodes( '//sentence' )->get_nodelist ) {

	# process each word in this sentence
	foreach my $word ( $sentence->findnodes( './/word' )->get_nodelist ) {

		# parse
		my $value = $word->string_value;
		my $pos   = $word->find( './@pos' );
		my $lemma = $word->find( './@lemma' );

		# update the result
		$result .= join( "\t", ( $pos, $lemma, $value ) ) . "\n";
	
	}
	
}

# output header, the data, and done
print join( "\t", HEADER ), "\n";
print $result;
exit;

