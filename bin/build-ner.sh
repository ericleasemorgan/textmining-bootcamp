#!/usr/bin/env bash

# build-ner.sh - create named entities "files" from the corpora

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 9, 2018 - first cut


# configure
HOME=`pwd`
CORPORA='./corpora'
NER='./named-entities'
TXT2NER='./bin/txt2ner.sh'

# sanity
cd $HOME

# duplicate the corpora
rm -rf $NER
cp -r $CORPORA $NER

# find all the plain text files in the newly created dirctory and do NER against them
find $NER -name "*.txt" -exec $TXT2NER {} \;

# done
exit
