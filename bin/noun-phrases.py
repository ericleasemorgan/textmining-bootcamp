#!/usr/bin/env python

# noun-phrases.py - given a text, list the frequency of its noun phrases

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame, distributed under a GNU Public License

# April 22, 2018 - first cut


# configure; define the shape of noun phrases, and there are many possibilities
GRAMMER = 'NP: {<DT|PP\$>?<JJ.*>*<NN.*>+}\n{<JJ.*>*<NN*><CC>*<NN*>+}\n{<NNP>+}\n{<NN>+}'

# require
from nltk import RegexpParser, sent_tokenize, pos_tag, word_tokenize, FreqDist
import sys

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <file>\n" )
	quit()

# get input
file = sys.argv[ 1 ]

# initialize
parser = RegexpParser( GRAMMER )

# open and read the input
handle = open ( file, 'r' )
data   = handle.read()

# get all sentences and process them
sentences = sent_tokenize( data )
phrases   = []
for sentence in sentences :
	
	# tokenize and tag the sentence
	sentence = ( pos_tag( word_tokenize( sentence ) ) )

	# parse the sentence and process each noun phrase
	tree = parser.parse( sentence )
	for phrase in tree.subtrees( filter = lambda t : t.label() == 'NP' ) :
		
		# re-initialize, and build up a list of normalized phrases sans determiners
		words = []
		for leaves in phrase :
			if leaves[ 1 ] == 'DT' : continue
			words.append( leaves[ 0 ].lower() )
		phrases.append( ' '.join( words ) )

# count & tabulate the phrases, output the result, and done
frequencies = FreqDist( phrases )
for phrase, count in frequencies.most_common() : print( "%s\t%s" % ( count, phrase ) )
quit()
