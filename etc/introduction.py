# coding: utf-8

#  An introduction to the NLTK
#  
#  This file introduces the reader to the Python Natural
#  Langauge Toolkit (NLTK).
#  
#  The Python NLTK is a set of modules and corpora
#  enabling the reader to do natural langauge processing
#  against corpora of one or more texts. It goes beyond
#  text minnig and provides tools to do machine learning.
#  
#  This program enables the reader to get an idea of the
#  Toolkit's functionality. Given a sane Python intallation,
#  one can run this proram by saving it with a name like
#  introduction.py, saving a file named walden.txt in the
#  same directory, changing to the given directory, and
#  then running the following command:
#  
#    python introduction.py
#  
#  The result ought to be a number of textual outputs in
#  the terminal window as well as a few graphics.
#  
#  Errors may occur, probably because other Python
#  libraries/modules have not been installed. Follow the
#  error messages' instructions, and try again, but "Your
#  milage may vary."
#  
#  --  
#  Eric Lease Morgan <emorgan@nd.edu>  
#  April 14, 2018


# configure; using an absolute path, define the location of a plain text file for analysis
FILE = 'walden.txt'

# import / require the use of the Toolkit
from nltk import *

# slurp up the given file; display the result
handle = open( FILE, 'r')
data   = handle.read()
print( data )

# tokenize the data into features (words); display them
features = word_tokenize( data )
print( features )

# normalize the features to lower case and exclude punctuation
features = [ feature for feature in features if feature.isalpha() ]
features = [ feature.lower() for feature in features ]
print( features )

# create a list of (English) stopwords, and then remove them from the features
from nltk.corpus import stopwords
stopwords = stopwords.words( 'english' )
features  = [ feature for feature in features if feature not in stopwords ]

# count & tabulate the features, and then plot the results -- season to taste
frequencies = FreqDist( features )
plot = frequencies.plot( 10 )

# create a list of unique words (hapaxes); display them
hapaxes = frequencies.hapaxes()
print( hapaxes )

# count & tabulate ngrams from the features -- season to taste; display some
ngrams      = ngrams( features, 2 )
frequencies = FreqDist( ngrams )
frequencies.most_common( 10 )

# create a list each token's length, and plot the result; How many "long" words are there?
lengths = [ len( feature ) for feature in features ]
plot    = FreqDist( lengths ).plot( 10 )

# initialize a stemmer, stem the features, count & tabulate, and output
from nltk.stem import PorterStemmer
stemmer     = PorterStemmer()
stems       = [ stemmer.stem( feature ) for feature in features ]
frequencies = FreqDist( stems )
frequencies.most_common( 10 )

# re-create the features and create a NLTK Text object, so other cool things can be done
features = word_tokenize( data )
text     = Text( features )

# count & tabulate, again; list a given word -- season to taste
frequencies = FreqDist( text )
print( frequencies[ 'love' ] )

# do keyword-in-context searching against the text (concordancing)
print( text.concordance( 'love' ) )

# create a dispersion plot of given words
plot = text.dispersion_plot( [ 'love', 'war', 'man', 'god' ] )

# output the "most significant" bigrams, considering surrounding words (size of window) -- season to taste
text.collocations( num=10, window_size=4 )

# given a set of words, what words are nearby
text.common_contexts( [ 'love', 'war', 'man', 'god' ] )

# list the words (features) most associated with the given word
text.similar( 'love' )

# create a list of sentences, and display one -- season to taste
sentences = sent_tokenize( data )
sentence  = sentences[ 14 ]
print( sentence )

# tokenize the sentence and parse it into parts-of-speech, all in one go
sentence = pos_tag( word_tokenize( sentence ) )
print( sentence )

# extract named enities from a sentence, and print the results
entities = ne_chunk( sentence )
print( entities )

# done
quit()