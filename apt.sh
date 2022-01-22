#!/bin/sh
set -e
apt-get update
apt-get install --no-install-recommends --yes $(grep -vE "^\s*#" apt.txt  | tr "\n" " ")
rm -rf /var/lib/apt/lists/*
set +e
