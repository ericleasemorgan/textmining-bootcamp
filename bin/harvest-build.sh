#!/usr/bin/env bash

# harvest-build.sh - use various means to cache Web content and save it with meaningful file names

# Eric Lease Morgan <emorgan@nd.edu>
# April 10, 2018 - first documentation; getting closer to Prague

# (c) University of Notre Dame under a GNU Public License


# configure
HARVESTHANDLE='./bin/harvest-twitter-handles.py'
HARVESTHASHTAG='./bin/harvest-twitter-hashtags.py'
HOME=`pwd`

# sanity check
cd $HOME

# build file system
mkdir -p ./harvest
mkdir -p ./harvest/asist
mkdir -p ./harvest/dhq
mkdir -p ./harvest/first-monday
mkdir -p ./harvest/gutenberg
mkdir -p ./harvest/infomotions
mkdir -p ./harvest/internet-archive
mkdir -p ./harvest/twitter/artinstitutechi
mkdir -p ./harvest/twitter/cambridge_uni
mkdir -p ./harvest/twitter/cbsnews
mkdir -p ./harvest/twitter/diadetroit
mkdir -p ./harvest/twitter/digitalhumanities
mkdir -p ./harvest/twitter/foxnews
mkdir -p ./harvest/twitter/harvard
mkdir -p ./harvest/twitter/machinelearning
mkdir -p ./harvest/twitter/metmuseum
mkdir -p ./harvest/twitter/nbcnews
mkdir -p ./harvest/twitter/nlp
mkdir -p ./harvest/twitter/textmining
mkdir -p ./harvest/twitter/uniofoxford
mkdir -p ./harvest/wikipedia/american-literature
mkdir -p ./harvest/wikipedia/digital-humanities
mkdir -p ./harvest/wikipedia/text-mining

# harvest infomotions
echo Harvesting Infomotions >&2
cd $HOME
cd ./harvest/infomotions; wget -nc -i ../../etc/infomotions.txt

# harvest asist
echo Harvesting ASIST >&2
cd $HOME
cd ./harvest/asist; wget -nc -i ../../etc/asist.txt

# harvest twitter
echo Harvesting Twitter >&2
cd $HOME
$HARVESTHANDLE artinstitutechi       > ./harvest/twitter/artinstitutechi.txt
$HARVESTHANDLE cambridge_uni         > ./harvest/twitter/cambridge_uni.txt
$HARVESTHANDLE cbsnews               > ./harvest/twitter/cbsnews.txt
$HARVESTHANDLE diadetroit            > ./harvest/twitter/diadetroit.txt
$HARVESTHANDLE foxnews               > ./harvest/twitter/foxnews.txt
$HARVESTHANDLE harvard               > ./harvest/twitter/harvard.txt
$HARVESTHANDLE metmuseum             > ./harvest/twitter/metmuseum.txt
$HARVESTHANDLE nbcnews               > ./harvest/twitter/nbcnews.txt
$HARVESTHANDLE uniofoxford           > ./harvest/twitter/uniofoxford.txt
$HARVESTHASHTAG "#textmining"        > ./harvest/twitter/textmining.txt
$HARVESTHASHTAG "#digitalhumanities" > ./harvest/twitter/digitalhumanities.txt
$HARVESTHASHTAG "#nlp"               > ./harvest/twitter/nlp.txt
$HARVESTHASHTAG "#machinelearning"   > ./harvest/twitter/machinelearning.txt

# harvest pre-named ("database") content so nice naming can happen
echo Harvesting DHQ, First Monday, Gutenberg, and Internet Archive >&2
cd $HOME
./bin/harvest-from-db.sh ./etc/dhq.txt              ./harvest/dhq
./bin/harvest-from-db.sh ./etc/first-monday.txt     ./harvest/first-monday
./bin/harvest-from-db.sh ./etc/gutenberg.txt        ./harvest/gutenberg
./bin/harvest-from-db.sh ./etc/internet-archive.txt ./harvest/internet-archive

# harvest "kewly" from an HTML file
echo Harvesting Web pages >&2
cd $HOME
./bin/harvest-wikipedia.sh https://en.wikipedia.org/wiki/Text_mining         ./harvest/wikipedia/text-mining
./bin/harvest-wikipedia.sh https://en.wikipedia.org/wiki/Digital_humanities  ./harvest/wikipedia/digital-humanities
./bin/harvest-wikipedia.sh https://en.wikipedia.org/wiki/American_literature ./harvest/wikipedia/american-literature

# done
exit

