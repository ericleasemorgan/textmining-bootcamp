#!/usr/bin/env python

# twitter-handle.py - given the handle to a Twitter account, harvest a set of tweets

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 2, 2018 - first (real) cut


# configure
CONSUMERKEY    = 'DdbABWl2qHvoa5OE59sa5YWej'
CONSUMERSECRET = 'Lm82WN6UpuvNibNPud6EzmA6DsmCnR8G8lQfRb55i1HDWzdM7E'
ACCESSTOKEN    = '192056435-SWAzQagU4sn3q9qP7qAf0MOumgrjzLJCDXTmFwE6'
ACCESSSECRET   = 'oAJdDtyP6lkALo8rFh78XIXypdyU8fEBmJydl6rz26MWw'

# require
from TwitterSearch import *
import sys

# sanity check
if len( sys.argv ) != 2 :
	sys.stderr.write( 'Usage: ' + sys.argv[ 0 ] + " <handle>\n" )
	quit()

# get input
handle = sys.argv[ 1 ]

# go
try :

    # initialize
    tuo = TwitterUserOrder( handle )
    ts  = TwitterSearch(
    
        consumer_key        = CONSUMERKEY, 
        consumer_secret     = CONSUMERSECRET,
        access_token        = ACCESSTOKEN, 
        access_token_secret = ACCESSSECRET
        
     )

    # request tweets and output
    for tweet in ts.search_tweets_iterable( tuo ) : print( '%s' % ( tweet[ 'text' ].replace( '\n', ' ' ) ) )

# trap errors
except TwitterSearchException as e : print( e )

# done
quit()
