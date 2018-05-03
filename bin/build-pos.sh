#!/usr/bin/env bash

# build-pos.sh - create POS "files" from the corpora

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 9, 2018 - first cut


# configure
HOME=`pwd`
CORPORA='./corpora'
POS='./part-of-speech'
TXT2POS='./bin/txt2pos.sh'

# sandity
cd $HOME

# initialize; duplicate the corpora
rm -rf $POS
cp -r $CORPORA $POS

# do the work; find all plain text files in the newly created directory and "POS" them
find $POS -name "*.txt" -exec $TXT2POS {} \;

# done
exit
