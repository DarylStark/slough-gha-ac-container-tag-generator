#!/bin/bash

if [ "${INPUT_CONTAINER_NAME}" == "" ]; then
    # No container name given, extract it from the GITHUB_REPOSITORY
    INPUT_CONTAINER_NAME=$(echo ${GITHUB_REPOSITORY} | cut -d '/' -f 2)
fi

IMAGE_NAME="${INPUT_CONTAINER_REPOSITORY}/${INPUT_CONTAINER_NAME}"

if [ "${GITHUB_REF_NAME}" == "main" ]; then
    TAGS="${IMAGE_NAME}:latest"
fi

if [ "${GITHUB_REF_NAME}" == "dev" ]; then
    TAGS="${IMAGE_NAME}:latest-dev"
fi

if [ "${INPUT_VERSION}" != "" ]; then
    TAGS="${TAGS},${IMAGE_NAME}:${INPUT_VERSION}"
fi

# Add the tag for the SHA hash of the commit
SHORT_SHA=$(echo ${GITHUB_SHA} | cut -c1-7)
TAGS="${TAGS}:${IMAGE_NAME}:${SHORT_SHA}"

echo "tags="${TAGS}"" >> "$GITHUB_OUTPUT"
