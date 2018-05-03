#!/usr/bin/env perl

# pos2ngram.pl - given a plain text file, extract ngrams from "POS" file

# Eric Lease Morgan <emorgan@nd.edu>
# April 10, 2018 - first documentation but brain-dead; getting closer to Prague

# (c) University of Notre Dame under a GNU Public License


# requires
use strict;

# get input
my $pos = $ARGV[ 0 ];
my $n   = $ARGV[ 1 ];

# do error checking here

# do the work and done, sort of
print &ngram( &pos2txt( $pos ), $n );


# return all the word elements from a "POS" file
sub pos2txt {

	# require
	use XML::XPath;
	
	# initialize
	my $pos    = XML::XPath->new( xml => shift );
	my $result = '';

	# get all words and update the list of them 
	foreach my $word ( $pos->findnodes( '//word' )->get_nodelist ) { $result .= ' ' . $word->string_value }
	
	# done
	return $result;

}


# given a plain text file, count & tabulate the text's ngrams
sub ngram {

	# get input
	my $text = shift;
	my $n    = shift;
	
	# sanity check
	if ( ! $n ) { die "This method -- ngram -- requires an integer as an argument." }
	if ( $n =~ /\D/ ) { die "This method -- ngram -- requires an integer as an argument." }
	
	# initalize
	my @words  = split( / /, lc( $text ) );
	my @ngrams = ();
	my %count  = ();

	# process each word
	for ( my $i = 0; $i <= $#words; $i++ ) {
	
		# repeat n number of times
		my $tokens = '';
		for ( my $j = $i; $j < $i + $n; $j++ ) { $tokens .= $words[ $j ] . ' ' }
				
		# build the ngram and count
		$ngrams[ $i ] = $tokens;
		$count{ $ngrams[ $i ] }++;
		
	}
	
	# done
	return \%count;

}
