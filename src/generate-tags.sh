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
SHORT_SHA=$(echo ${GITHUB_SHA} | cut -c1-16)
TAGS="${TAGS}:${IMAGE_NAME}:${SHORT_SHA}"

echo "Tags: ${TAGS}"

env | sort

exit

export REPO_NAME=$(echo ${GITHUB_REPOSITORY} | cut -d '/' -f 2)
export MAIN_TAG="${GITHUB_REF_NAME}"
if [ "${{ github.ref_name }}" == "main" ]; then
    export MAIN_TAG="latest"
elif [ "${{ github.ref_name }}" == "dev" ]; then
    export MAIN_TAG="latest-dev"
fi
echo "tag-name="${DOCKER_USERNAME}/${REPO_NAME}:${MAIN_TAG},${DOCKER_USERNAME}/${REPO_NAME}:${GITHUB_SHA}"" # >> "$GITHUB_OUTPUT"