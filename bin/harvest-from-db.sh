#!/usr/bin/env bash

# harvest-form-db.sh - given a file and a directory, cache Web content locally

# Eric Lease Morgan <emorgan@nd.edu>
# April 10, 2018 - first documentation; getting closer to Prague

# (c) University of Notre Dame under a GNU Public License


# get input
DATABASE=$1
OUTPUT=$2

# INSERT ERROR CHECKING HERE

# process each record in the "database"
while IFS='' read -r RECORD; do

	# re-configure
	IFS=' '

	# parse
	KEY="$(echo $RECORD | cut -f1)"
	URL="$(echo $RECORD | cut -f2)"
	
	# do the work
	wget -k -nc -O "$OUTPUT/$KEY" $URL
	
done < $DATABASE

# quit
exit
