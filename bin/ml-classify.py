#!/usr/bin/env python

# classify.py - given a previously generate classification model, classify a set of documents

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# September 5, 2017 - calling it "done"; see http://zacstewart.com/2015/04/28/document-classification-with-scikit-learn.html


# require
import os
import pickle
import glob
import sys

# sanity check
if len( sys.argv ) != 3 :
	sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <model> <directory>\n" )
	quit()

# get input
model     = sys.argv[ 1 ]
directory = sys.argv[ 2 ]

# load the model
with open( model, 'rb' ) as handle : ( vectorizer, classifier ) = pickle.load( handle )

# process each unclassified file
for file in glob.glob( directory + "/*.txt" ) :
	
	# open, read, and classify a press release
	with open( file, 'r' ) as handle : classification = classifier.predict( vectorizer.transform( [ handle.read() ] ) )
	
	# output
	print( "\t".join( ( classification[ 0 ], os.path.basename( file ) ) ) )
	
# done
quit()






