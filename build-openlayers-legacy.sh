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
cd build/legacy
cp ol.js ol-debug.js
cp ol.js.map ol-debug.js.map
cd ../../

# build production version
$npx webpack --config config/webpack-config-legacy-build.js

# build css
$npx cleancss --source-map src/ol/ol.css -o build/legacy/ol.css

# copy
cp -r build/legacy ../../dist && cp LICENSE.md ../../dist/
