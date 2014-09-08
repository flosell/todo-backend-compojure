#!/bin/bash -e

REPO_DIR=/tmp/mockrepo

echo "Publishing to $REPO_DIR"

cp target/todo-backend-compojure-standalone.jar $REPO_DIR/server-snapshot.tar.gz
cp deploy.sh $REPO_DIR/deploy-server.sh