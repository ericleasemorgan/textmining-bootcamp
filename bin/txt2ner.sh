#!/usr/bin/env bash

# txt2ner.sh - create named entity "files" from the corpus

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 9, 2018 - first investigations


# configure
NERCLIENT='./bin/ner-client.pl'
NER2TAB='./bin/ner2tab.pl'

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
$NERCLIENT $FILE > $XML
$NER2TAB $XML    > $TSV
rm $FILE

# done
exit
