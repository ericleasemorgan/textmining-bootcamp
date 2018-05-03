#!/usr/bin/env bash

# build-corpora.sh - convert sets of harvested file to plain text, and organize the lot into corpora

# Eric Lease Morgan <eric_morgan@infomotions.com>
# April 7, 2018 - first working cut; requires Tika server!


# configure
HOME=`pwd`

echo Building file system >&2
mkdir -p ./corpora
mkdir -p ./corpora/art-news
mkdir -p ./corpora/articles
mkdir -p ./corpora/asist
mkdir -p ./corpora/campus-news
mkdir -p ./corpora/dhq
mkdir -p ./corpora/digital-humanities
mkdir -p ./corpora/first-monday
mkdir -p ./corpora/gutenberg
mkdir -p ./corpora/infomotions
mkdir -p ./corpora/internet-archive
mkdir -p ./corpora/literature
mkdir -p ./corpora/news
mkdir -p ./corpora/wikipedia/american-literature
mkdir -p ./corpora/wikipedia/digital-humanities
mkdir -p ./corpora/wikipedia/text-mining

echo Converting DHQ, ASIST, First Monday, Gutenberg, Infomotions, and Internet Archive >&2
find ./harvest/dhq -name "*.html"             -exec ./bin/file2txt.sh {} ./corpora/dhq \;
find ./harvest/asist -name "*.pdf"            -exec ./bin/file2txt.sh {} ./corpora/asist \;
find ./harvest/first-monday -name "*.html"    -exec ./bin/file2txt.sh {} ./corpora/first-monday \;
find ./harvest/gutenberg -name "*.txt"        -exec ./bin/file2txt.sh {} ./corpora/gutenberg \;
find ./harvest/infomotions -name "*.txt"      -exec ./bin/file2txt.sh {} ./corpora/infomotions \;
find ./harvest/internet-archive -name "*.pdf" -exec ./bin/file2txt.sh {} ./corpora/internet-archive \;

echo Converting American literature >&2
find ./harvest/wikipedia/american-literature -name "*.pdf"  -exec ./bin/file2txt.sh {} ./corpora/wikipedia/american-literature \;
find ./harvest/wikipedia/american-literature -name "*.html" -exec ./bin/file2txt.sh {} ./corpora/wikipedia/american-literature \;
find ./harvest/wikipedia/american-literature -name "*.xml"  -exec ./bin/file2txt.sh {} ./corpora/wikipedia/american-literature \;

echo Converting digital humanities >&2
find ./harvest/wikipedia/digital-humanities -name "*.pdf"  -exec ./bin/file2txt.sh {} ./corpora/wikipedia/digital-humanities \;
find ./harvest/wikipedia/digital-humanities -name "*.html" -exec ./bin/file2txt.sh {} ./corpora/wikipedia/digital-humanities \;
find ./harvest/wikipedia/digital-humanities -name "*.xml"  -exec ./bin/file2txt.sh {} ./corpora/wikipedia/digital-humanities \;

echo Converting text mining >&2
find ./harvest/wikipedia/text-mining -name "*.pdf"  -exec ./bin/file2txt.sh {} ./corpora/wikipedia/text-mining \;
find ./harvest/wikipedia/text-mining -name "*.html" -exec ./bin/file2txt.sh {} ./corpora/wikipedia/text-mining \;
find ./harvest/wikipedia/text-mining -name "*.xml"  -exec ./bin/file2txt.sh {} ./corpora/wikipedia/text-mining \;

# build articles corpus
echo Building articles >&2
cp -r ./corpora/dhq/*.txt          ./corpora/articles
cp -r ./corpora/asist/*.txt        ./corpora/articles
cp -r ./corpora/first-monday/*.txt ./corpora/articles

# build literature corpus
echo Building literature >&2
cp -r ./corpora/infomotions/*.txt                   ./corpora/literature
cp -r ./corpora/gutenberg/*.txt                     ./corpora/literature
cp -r ./corpora/internet-archive/*.txt              ./corpora/literature
cp -r ./corpora/wikipedia/american-literature/*.txt ./corpora/literature

# build dh corpus
echo Building digital humanities >&2
cp -r ./corpora/dhq/*.txt                          ./corpora/digital-humanities
cp -r ./corpora/wikipedia/digital-humanities/*.txt ./corpora/digital-humanities
cp -r ./corpora/wikipedia/text-mining/*.txt        ./corpora/digital-humanities
cp -r ./harvest/twitter/digitalhumanities.txt      ./corpora/digital-humanities
cp -r ./harvest/twitter/textmining.txt             ./corpora/digital-humanities
cp -r ./harvest/twitter/nlp.txt                    ./corpora/digital-humanities
cp -r ./harvest/twitter/machinelearning.txt        ./corpora/digital-humanities

# build news corpus
echo Building news >&2
cp -r ./harvest/twitter/cbsnews.txt ./corpora/news
cp -r ./harvest/twitter/foxnews.txt ./corpora/news
cp -r ./harvest/twitter/nbcnews.txt ./corpora/news

# build art corpus
echo Building art >&2
cp -r ./harvest/twitter/artinstitutechi.txt ./corpora/art-news
cp -r ./harvest/twitter/diadetroit.txt      ./corpora/art-news
cp -r ./harvest/twitter/metmuseum.txt       ./corpora/art-news

# build art corpus
echo Building campus news >&2
cp -r ./harvest/twitter/cambridge_uni.txt ./corpora/campus-news
cp -r ./harvest/twitter/harvard.txt       ./corpora/campus-news
cp -r ./harvest/twitter/uniofoxford.txt   ./corpora/campus-news

# done
echo Done building corpora
exit

