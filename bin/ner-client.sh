#!/usr/bin/env bash

# ner-client.sh - given the name of file, output named entities embedded in an XML FILE

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 8, 2018 - getting ready for Prague


# configure
HOME=`pwd`
LIB='./lib'
TMP='./tmp'
FILE='ner.txt'

# get input here

# do error checking here

# make sane
cd $HOME

# munge the input, and save
XML=$( cat $1 | sed -e 's/&/&amp;/g' | sed -e 's/</\&lt;/g' | sed -e 's/>/\&gt;/g' | sed -e 's/\W+/ /g' |sed -e 's/^ //' | sed -e 's/ $//g' )
echo $XML > "$HOME/$TMP/$FILE"

# do the work
cd $LIB
echo "<ner>"
java -cp ner.jar: edu.stanford.nlp.ie.crf.CRFClassifier -loadClassifier english.crf.ser.gz -outputFormat inlineXML -textFile "$HOME/$TMP/$FILE"
echo "</ner>"
