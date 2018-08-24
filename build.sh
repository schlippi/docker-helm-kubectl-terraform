#!/bin/bash
set -ex

# find all top level folders, except hidden
for dir in $(find . -maxdepth 1 -type d  -regex ".+/[a-z-]+"); do
    # build a docker image, same name as the folder (stripping the "./" prefix)
    BUILD_IMAGE_TAG=$(basename $dir)
    docker build -t $BUILD_IMAGE_TAG $dir
done
