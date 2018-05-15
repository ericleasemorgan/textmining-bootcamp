#!/usr/bin/env bash

# build-all.sh - brain-dead script to harvest content, build a corpus, and extract POS and named entities

# Eric Lease Morgan <eric_morgan@infomotions.com>
# May 7, 2018 - first cut and Ms. Gina's birthday ("Happy birthday, Gina!")


# do the work; hardcoded
./bin/harvest-build.sh
./bin/tika-server.sh
sleep 10
./bin/build-corpora.sh
./bin/pos-server.sh
sleep 10
./bin/build-pos.sh
./bin/ner-server.sh
sleep 10
./bin/build-ner.sh