### PyVista VTK Wheels

Here are hosted VTK wheels build using OSMesa on Ubuntu 20.04 with glib 2.31. For a variety of reasons, these wheels were not built on an earlier version of Linux, nor were "repaired" using ``auditwheel``, and are therefore have limited comparability.  See the last section for build notes. 

These wheels are used within the [PyVista documentation build](https://github.com/pyvista/pyvista/blob/main/azure-pipelines.yml) to avoid using ``xvfb``, which has been found to be unstable and has lower performance.

### Build Process

Build requirements (Ubuntu)
```
sudo apt-get install libosmesa6-dev cmake ninja-build
```

The `vtk-osmesa-*-cp3*-cp3*-linux_x86_64.whl` wheels were using the following:

```
git clone https://github.com/Kitware/VTK.git
cd VTK
git checkout v9.1.0
mkdir build
cd build

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

Wheels will then be generated in VTK/build/dist.

### Auditwheel and ManyLinux Build Issues

Note that these wheels failed to be repaired correctly using ``auditwheel`` for Ubuntu 20.04 due to an issue linking ``libffi``, and therefore were not converted.

Wheels build using images from https://quay.io/organization/pypa did not work on Ubuntu 20.04 due to a [GLSL 1.50 not supported](https://discourse.vtk.org/t/error-glsl-1-50-is-not-supported/1444) bug.
