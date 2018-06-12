#!/bin/bash
set -x
set -e
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
docker tag ${TRAVIS_REPO_SLUG%-docker-image} ${TRAVIS_REPO_SLUG%-docker-image}:$TRAVIS_TAG
docker push ${TRAVIS_REPO_SLUG%-docker-image}:$TRAVIS_TAG
docker logout
