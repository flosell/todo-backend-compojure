#!/bin/bash -e

if [ $# -lt 2 ]; then
  echo "usage: <environment> <jarfile>"
  exit 1
fi

ENVIRONMENT=$1
JARFILE=$2

echo "Deploying $JARFILE to $ENVIRONMENT..."

scp $JARFILE vagrant@$ENVIRONMENT:/home/vagrant/backend.jar

ssh vagrant@$ENVIRONMENT "killall java; nohup  java -jar backend.jar 8084 > foo.out 2> foo.err < /dev/null &"

RETRIES=5

for i in $(seq $RETRIES); do
  if curl localhost:18084/todos --silent --fail; then 
    echo "Found deployed version"
    exit 0
  else 
    echo "waiting for deployed version..."
    sleep 1
  fi
done

echo "ERROR, no deployed version found after $RETRIES retries"
exit 1