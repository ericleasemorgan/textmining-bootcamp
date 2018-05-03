#!/usr/bin/env bash

# model-chunks.sh - slit a text file into parts, and topic model; a wrapper around model.py

# Eric Lease Morgan <emorgan@nd.edu>
# April 10, 2018 - first documentation; getting closer to Prague

# (c) University of Notre Dame under a GNU Public License


# configure
HOME=`pwd`
CHUNKS="$HOME/tmp"
MODEL="./bin/model.py $CHUNKS 5 3 0"
SIZE=1024

# initialize
FILE=$1
BASE=$( basename $FILE .txt )

# DO ERROR CHECKING HERE

# sanity check; a bit dangerous
cd $HOME
cd $CHUNKS
rm -rf ./*

# split the given text
split -b $SIZE -d --additional-suffix=.txt $FILE $BASE

# model the chunks and done
cd $HOME
$MODEL
exit
