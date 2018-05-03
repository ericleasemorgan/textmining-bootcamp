#!/usr/bin/env perl

# ner-client.pl - given a file name, output an XML stream containing named entities
# see: http://www.perlmonks.org/?node_id=54146

# Eric Lease Morgan <emorgan@nd.edu>
# April 10, 2018 - first documentation; getting closer to Prague

# (c) University of Notre Dame under a GNU Public License


# configure
use constant PORT     => 8082;
use constant HOST     => 'localhost';
use constant PROTOCOL => 'tcp';
use constant BUFFER   => '10240';
use constant TIMEOUT  => 10;
use constant RBITS    => '';

# require
use strict;
use IO::Socket;

# sanity check
my $file = $ARGV[ 0 ];
if ( ! $file ) { die "Usage: $0 <file>\n" }

# initialize
$|           = 1;
my $response = '';
my $text     = '';
my $rbits    = RBITS;

# get the text to process and normalize it for xml
$text =  &slurp( $file );
$text =~ s/\&/\&amp;/g;
$text =~ s/</\&lt;/g;
$text =~ s/>/\&gt;/g;
$text =~ s/\W+/ /g;
$text =~ s/^ //;
$text =~ s/ $//;
 
# open the socket and write the text
my $socket = IO::Socket::INET->new( PeerAddr => HOST, PeerPort => PORT, Proto => PROTOCOL );
$socket->write( "$text\n" );

# loop, forever
while ( 1 ) {

	# set the bit flag; ???
	vec( $rbits, $socket->fileno, 1 ) = 1;

	# wait
	if ( select( $rbits, undef, undef, TIMEOUT ) >= 0 ) {

			# re-initialize, read and update the response
			my $buffer  = '';
			my $result  = $socket->read( $buffer, BUFFER );
			$response  .= $buffer;

			# done, maybe
			last unless $result;
		
	}

	# vec failed, apparently
	else { last }
	
}

# done
print "<ner>$response</ner>\n";
exit;


# read a file in one go
sub slurp {

	my $f = shift;
	open ( F, $f ) or die "Can't open $f: $!\n";
	my $r = do { local $/; <F> };
	close F;
	return $r;

}
