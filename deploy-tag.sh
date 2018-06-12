#!/bin/bash
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker tag $TRAVIS_REPO_SLUG $TRAVIS_REPO_SLUG:$TRAVIS_TAG
docker push $TRAVIS_REPO_SLUG:$TRAVIS_TAG
docker logout
