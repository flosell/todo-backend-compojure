#!/bin/bash -e

if [ -z "${BACKEND_VERSION}" ]; then
  echo "ERROR: No BACKEND_VERSION defined!"
  exit 1
fi

echo -e "\033[1mBuilding jar-file...\033[0m"

lein uberjar

echo -e "\033[1mBuilding docker container...\033[0m"

docker build -t lambdacd-demo/backend:${BACKEND_VERSION} .