#!/usr/bin/env bash

# pos-server.sh - make Stanford POS Tagger available via TCP

# Eric Lease Morgan <emorgan@nd.edu>
# April 10, 2018 - first documentation; getting closer to Prague

# (c) University of Notre Dame under a GNU Public License


# configure
HOME=`pwd`
LIB='./lib'
PORT=8081
PIDFILE="$HOME/tmp/pos-server.pid"

# make sane
cd $HOME
cd $LIB

# start the server
printf "Starting POS server on port $PORT. Please wait... " 1>&2
java -cp tagger.jar: edu.stanford.nlp.tagger.maxent.MaxentTaggerServer -model english.tagger -outputFormat inlineXML -outputFormatOptions lemmatize -port $PORT &

# get, save, and echo the pid
PID=$!
printf "($PID)\n" 1>&2
echo $PID > $PIDFILE

# done
exit


