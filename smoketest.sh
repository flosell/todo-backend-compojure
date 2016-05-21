#!/bin/bash -e

if [ -z "${DEPLOY_ENVIRONMENT}" ]; then
  echo "ERROR: No DEPLOY_ENVIRONMENT defined!"
  exit 1
fi

if [ "${DEPLOY_ENVIRONMENT}" == "ci" ]; then
  BACKEND_PORT=8081
elif [ "${DEPLOY_ENVIRONMENT}" == "qa" ]; then
  BACKEND_PORT=8091
else
  echo "DEPLOY_ENVIRONMENT must be ci or qa"
fi
URL="http://localhost:${BACKEND_PORT}/todos"
for i in {1..10}; do 
  if curl --silent --output /dev/null --fail ${URL}; then 
    echo -e "\033[1m${URL} is up\033[0m"
    exit 0
  fi
  echo "${URL} not up, retrying..."
  sleep 1
done

echo -e "\033[1mCould not reach server at ${URL}\033[0m"
