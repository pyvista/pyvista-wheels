#!/bin/sh
sudo apt-get update && sudo apt-get install xargs
xargs sudo apt-get install --no-install-recommends --yes <apt.txt \
  && \
  sudo rm -rf /var/lib/apt/lists/*
