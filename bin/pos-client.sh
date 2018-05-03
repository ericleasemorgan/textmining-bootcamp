#!/usr/bin/env bash

# pos-client.sh - given the full path to a plain text file, return POS marked up in XML

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame under a GNU Public License

# April 8, 2018 - getting ready for Prague


# configure
HOME=`pwd`
LIB='./lib'

# make sane
cd $HOME
cd $LIB

# do the work
java -cp tagger.jar: edu.stanford.nlp.tagger.maxent.MaxentTagger -model english.tagger -outputFormat inlineXML -outputFormatOptions lemmatize -textFile $1
