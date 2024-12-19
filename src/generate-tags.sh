#!/bin/bash

if [ "${INPUT_CONTAINER_NAME}" = "" ]; then
    # No container name given, extract it from the GITHUB_REPOSITORY
    INPUT_CONTAINER_NAME=$(echo ${GITHUB_REPOSITORY} | cut -d '/' -f 2)
fi

export IMAGE_NAME="${INPUT_CONTAINER_REPOSITORY}/${INPUT_CONTAINER_NAME}"

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