#!/bin/sh
set -e
apt-get update && apt-get install xargs
xargs apt-get install --no-install-recommends --yes <apt.txt \
  && \
 rm -rf /var/lib/apt/lists/*
set +e
