#!/usr/bin/env bash

# build-pos.sh - create POS "files" from the corpus

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 9, 2018 - first investigations


# configure
POSCLIENT='./bin/pos-client.pl'
POS2TAB='./bin/pos2tab.pl'

# get input
FILE=$1

# do error checking here

# initialize
BASENAME=$( basename $FILE .txt )
DIRNAME=$( dirname $FILE )
XML="$DIRNAME/$BASENAME.xml"
TSV="$DIRNAME/$BASENAME.tsv"

# debug
echo $FILE >&2
echo $XML  >&2
echo $TSV  >&2
echo       >&2

# do the work
$POSCLIENT $FILE > $XML
$POS2TAB $XML    > $TSV
rm $FILE

# done
exit
