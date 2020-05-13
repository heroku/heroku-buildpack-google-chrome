#!/usr/bin/env bash

set -euo pipefail

[ $# -eq 1 ] || { echo "Usage: $0 STACK"; exit 1; }

STACK="${1}"

if [[ "${STACK}" == "cedar-14" ]]; then
    BASE_IMAGE="heroku/${STACK/-/:}"
else
    BASE_IMAGE="heroku/${STACK/-/:}-build"
fi

OUTPUT_IMAGE="google-chrome-test-${STACK}"

echo "Building buildpack on stack ${STACK}..."

docker build \
    --build-arg "BASE_IMAGE=${BASE_IMAGE}" \
    --build-arg "STACK=${STACK}" \
    ${GOOGLE_CHROME_CHANNEL:+--build-arg "GOOGLE_CHROME_CHANNEL=${GOOGLE_CHROME_CHANNEL}"} \
    -t "${OUTPUT_IMAGE}" \
    .

echo "Checking Google Chrome can start and aliases exist..."

TEST_COMMAND="for alias in google-chrome{,-${GOOGLE_CHROME_CHANNEL:-stable}} \${GOOGLE_CHROME_BIN} \${GOOGLE_CHROME_SHIM}; do \${alias} --version; done"
docker run --rm -it "${OUTPUT_IMAGE}" bash -c "set -ex && for f in .profile.d/*; do source \"\$f\"; done && ${TEST_COMMAND}"

echo "Success!"
