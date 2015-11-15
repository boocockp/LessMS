#!/usr/bin/env bash

function syncDir {
    fromDir=${1}
    toDir=${2}
    rsync -rtp --exclude-from=distExcludes ${fromDir}/ ${toDir}/
}

mkdir -p dist dist/custom dist/bower
cp -p src/main/*.html dist
cp -p -r src/main/custom/ dist/custom
cp -p -r lib/ dist/lib

syncDir bower_components dist/bower
cp -p -r bower_components/xdate/src dist/bower/xdate/src


