#!/bin/bash

set -e

echo "GITHUB_REPOSITORY=$GITHUB_REPOSITORY" > .env
echo "GITHUB_REF=$GITHUB_REF" >> .env
echo "GITHUB_SHA=$GITHUB_SHA" >> .env