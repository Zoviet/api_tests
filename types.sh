#!/bin/bash

sed -r -e 's/:.\"[0-9]{4}-.*$/:datetime/; s/:.[0-9]+,.*$/:int/; s/:.[0-9\.]+,.*$/:float/g; s/:.[true|false].*,.*$/:boolean/; s/:.\[.*\],.*$/:array/; s/:.\"[^\[].*\",.*$/:string/; ' defaults.json > temp
sort -i temp | sed 1,2d | sed -r -e 's/^\s+//g; s/\"//g; s/:/;/g;' > types.csv
rm -f temp
