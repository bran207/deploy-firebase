#!/bin/sh

if [ -z "${FIREBASE_TOKEN}" ]; then
    echo "FIREBASE_TOKEN is missing"
    exit 1
fi

if [ -z "${FIREBASE_PROJECT}" ]; then
    echo "FIREBASE_PROJECT is missing"
    exit 1
fi

if [ "${GITHUB_REF}" != "refs/heads/master" ]; then
    echo "Branch: ${GITHUB_REF}"
    echo "Aborting non-master branch deployment"
    exit 1
fi

if [ -z "${FILES_TO_MINIFY}" ]; then
    echo "No files to minify";
else
    python3 /usr/local/bin/minify.py minify "${FILES_TO_MINIFY}"
    ls
fi

firebase deploy \
    -m "${GITHUB_SHA}" \
    --project ${FIREBASE_PROJECT} \
    --only hosting

if [ -z "${FILES_TO_MINIFY}" ]; then
    echo "No files to deminify";
else
    python3 /usr/local/bin/minify.py deminify "${FILES_TO_MINIFY}"
fi
