## PyVista VTK Wheels

`vtk-osmesa-9.0.1-cp38-cp38-linux_x86_64.whl` was built using the following:

```

# install build dependencies
sudo apt-get install ninja-build cmake libosmesa6-dev libgl1-mesa-dev -y

PYBIN=/usr/bin/python3.8
cmake -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DVTK_BUILD_TESTING=OFF \
      -DVTK_BUILD_DOCUMENTATION=OFF \
      -DVTK_BUILD_EXAMPLES=OFF \
      -DVTK_DATA_EXCLUDE_FROM_ALL:BOOL=ON \
      -DVTK_MODULE_ENABLE_VTK_PythonInterpreter:STRING=NO \
      -DVTK_WHEEL_BUILD=ON \
      -DVTK_PYTHON_VERSION=3 \
      -DVTK_WRAP_PYTHON=ON \
      -DVTK_OPENGL_HAS_EGL=False \
      -DVTK_OPENGL_HAS_OSMESA=True \
      -DVTK_USE_COCOA=FALSE \
      -DVTK_USE_X=FALSE \
      -DPython3_EXECUTABLE=$PYBIN ../
ninja
$PYBIN setup.py bdist_wheel
```

Wheel was build on Ubuntu 20.04 with glibc 2.31 and is not a manylinux wheel.

### Dev Wheel

The `vtk-osmesa-9.0.20210926.dev0-cp38-cp38-linux_x86_64.whl` was built with

```
PYBIN=/usr/bin/python3.8
cmake -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DVTK_BUILD_TESTING=OFF \
      -DVTK_BUILD_DOCUMENTATION=OFF \
      -DVTK_BUILD_EXAMPLES=OFF \
      -DVTK_DATA_EXCLUDE_FROM_ALL:BOOL=ON \
      -DVTK_MODULE_ENABLE_VTK_PythonInterpreter:STRING=NO \
      -DVTK_WHEEL_BUILD=ON \
      -DVTK_PYTHON_VERSION=3 \
      -DVTK_WRAP_PYTHON=ON \
      -DVTK_OPENGL_HAS_EGL=False \
      -DVTK_OPENGL_HAS_OSMESA=True \
      -DVTK_USE_COCOA=FALSE \
      -DVTK_USE_X=FALSE \
      -DVTK_DEFAULT_RENDER_WINDOW_HEADLESS=True \
      -DPython3_EXECUTABLE=$PYBIN ../
ninja
$PYBIN setup.py bdist_wheel
```

This wheel works better than the `v9.0.1` wheel, probably because of enabling `VTK_DEFAULT_RENDER_WINDOW_HEADLESS`, but it also might be because it's a more recent release of VTK.
