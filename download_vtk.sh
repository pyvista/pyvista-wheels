#!/bin/sh
set -e
GIT_SSL_NO_VERIFY=true git clone https://github.com/Kitware/VTK.git VTK
cd VTK
git checkout ${VTK_VERSION-v9.1.0}
mkdir build
set +e
