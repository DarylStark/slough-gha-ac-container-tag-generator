#!/bin/bash

version=$1
echo "Version: ${version}"

export REPO_NAME=$(echo ${GITHUB_REPOSITORY} | cut -d '/' -f 2)
export MAIN_TAG="${GITHUB_REF_NAME}"
if [ "${{ github.ref_name }}" == "main" ]; then
    export MAIN_TAG="latest"
elif [ "${{ github.ref_name }}" == "dev" ]; then
    export MAIN_TAG="latest-dev"
fi
echo "tag-name="${DOCKER_USERNAME}/${REPO_NAME}:${MAIN_TAG},${DOCKER_USERNAME}/${REPO_NAME}:${GITHUB_SHA}"" # >> "$GITHUB_OUTPUT"