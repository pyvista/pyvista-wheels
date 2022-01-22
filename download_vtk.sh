#!/bin/sh
set -e
GIT_SSL_NO_VERIFY=true git clone https://github.com/Kitware/VTK.git VTK
cd VTK
git checkout v${VTK_VERSION-9.1.0}
mkdir build
set +e
