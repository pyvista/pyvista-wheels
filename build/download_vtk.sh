#!/bin/bash
set -x
VTK_MINOR_VERSION=$(python -c "print('.'.join('${VTK_VERSION}'.split('.')[:2]))")
echo Downlodaing... https://www.vtk.org/files/release/${VTK_MINOR_VERSION}/VTK-${VTK_VERSION}.tar.gz
curl -L -o VTK-${VTK_VERSION}.tar.gz https://www.vtk.org/files/release/${VTK_MINOR_VERSION}/VTK-${VTK_VERSION}.tar.gz
tar -xzf VTK-${VTK_VERSION}.tar.gz && rm VTK-${VTK_VERSION}.tar.gz
set +x
