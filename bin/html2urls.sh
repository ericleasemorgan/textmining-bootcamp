#!/usr/bin/env bash

# html2urls.sh - given an HTML file, output a list of embedded URLs

# Eric Lease Morgan <emorgan@nd.edu>
# April 10, 2018 - first documentation; getting closer to Prague

# (c) University of Notre Dame under a GNU Public License


# get input
HTML=$1

# INSERT ERROR CHECKING HERE

# do the work; leans towards Wikipedia pages
cat "$HTML" | egrep -o 'https?://[^ ]+' | sed -e 's/https/http/g' |  sed -e 's/>.*//g' | sed -e 's/\W+$/\n/g' | sed -e 's/"//g'| sort | uniq | sed -e 's/^.*wikimediafoundation.*$//g' | sed -e 's/^.*mediawiki.*$//g' | sed -e 's/^.*wikipedia.*$//g' | uniq | sort -bnr
