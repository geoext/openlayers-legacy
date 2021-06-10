#!/usr/bin/env bash

set -e

npx="$(pwd)/node_modules/.bin/npx"

# clean
rm -rf dist

# change to openlayers directory
cd node_modules/ol

# clean
rm -rf dist

# install openlayers dependencies
npm i

# build openlayers index
npm run build-index

# build debug version
$npx webpack --config config/webpack-config-legacy-build.js --mode=development
cp build/legacy/ol.js build/legacy/ol-debug.js

# build production version
$npx webpack --config config/webpack-config-legacy-build.js

# build css
$npx cleancss --source-map src/ol/ol.css -o build/legacy/ol.css

# remove .map file
rm build/legacy/ol.js.map

# copy
cp -r build/legacy ../../dist && cp LICENSE.md ../../dist/

# go back
cd ../../

# make ol.js ie 11 friendly
$npx babel dist/ol.js -o dist/ol.js
