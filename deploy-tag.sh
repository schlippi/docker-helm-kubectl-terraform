#!/bin/bash
set -ex

function tagAndPush {
    docker tag $1 $2
    docker push $2
}

# login
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# find all top level folders, except hidden
for dir in $(find . -maxdepth 1 -type d  -regex ".+/[a-z-]+"); do
    # the build tag from build.sh, same name as the folder (stripping the "./" prefix)
    BUILD_IMAGE_TAG=$(basename $dir)

    IMAGE_NAME=$DOCKER_USERNAME/$BUILD_IMAGE_TAG

    FLAVOR="2.8.2"

    # tag as 2.8.2-v1.1.2
    tagAndPush $BUILD_IMAGE_TAG $IMAGE_NAME:$FLAVOR-$TRAVIS_TAG

    # but also tag as 2.8.2
    tagAndPush $BUILD_IMAGE_TAG $IMAGE_NAME:$FLAVOR

    # also tag as latest
    tagAndPush $BUILD_IMAGE_TAG $IMAGE_NAME:latest
done

docker logout
