#!/usr/bin/env python

# ngrams.py - given a file and an integer, count & tabulate ngrams

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame, distributed under a GNU Public License

# April 12, 2018 - first cut; rudimentary
# April 13, 2018 - exploited more of the Toolkit


# require
from nltk        import word_tokenize, ngrams, FreqDist
from nltk.corpus import stopwords
import string
import sys

# sanity check
if len( sys.argv ) != 3 :
	sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <file> <integer>\n" )
	quit()

# get input
file = sys.argv[ 1 ]
n    = int( sys.argv[ 2 ] )

# initialize
stopwords = stopwords.words( 'english' )

# open and read the input
handle = open ( file, 'r' )
data   = handle.read()

# tokenize the text into features, normalize, and remove (English) stopwords
features = word_tokenize( data )
features = [ feature for feature in features if feature.isalpha() ]
features = [ feature.lower() for feature in features ]
features = [ feature for feature in features if feature not in stopwords ]

# create ngrams
ngrams = ngrams( features, n )

# count & tabulate the ngrams, loop through each frequency, output, and done
frequencies = FreqDist( ngrams )
for ngram, count in frequencies.most_common() : print( "%s\t%s" % ( count, ' '.join( ngram ) ) )
quit()