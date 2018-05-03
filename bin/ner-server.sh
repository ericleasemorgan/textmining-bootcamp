#!/usr/bin/env bash

# ner-server.sh - make the Standford NER tool available via a local tcp link

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame, distributed under a GNU Public License

# November 17, 2017 - first investigations


# configure
HOME=`pwd`
LIB='./lib'
PORT=8082
PIDFILE="$HOME/tmp/ner-server.pid"

# make sane
cd $HOME
cd $LIB

# start the server
printf "Starting NER server on port $PORT. Please wait... " 1>&2
java -mx1000m -cp ner.jar: edu.stanford.nlp.ie.NERServer -loadClassifier english.crf.ser.gz -port $PORT -outputFormat inlineXML &

# get, save, and echo the pid; cool!
PID=$!
printf "($PID)\n" 1>&2
echo $PID > $PIDFILE

# done
exit
