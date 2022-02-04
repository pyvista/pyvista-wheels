#!/bin/sh
set -e
apt-get update
apt-get install --no-install-recommends --yes \
  gcc \
  curl \
  git \
  cmake \
  ninja-build \
  build-essential \
  libosmesa6-dev \
  libxt-dev \
  libhdf5-dev \
  libsdl2-mixer-2.0-0 \
  libsdl2-image-2.0-0 \
  libsdl2-2.0-0 \
  libc6-dev \
  libssl-dev \
  libexpat1-dev \
  python3-dev
rm -rf /var/lib/apt/lists/*
set +e
