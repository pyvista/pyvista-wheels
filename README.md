### PyVista VTK Wheels

Here are hosted VTK wheels build using OSMesa on Ubuntu 20.04 with glib 2.31 for the Python 3.8 wheel, and Ubuntu 22.04 for the OSMesa Python 3.9 wheel. For a variety of reasons, these wheels were not built on an earlier version of Linux, nor were "repaired" using ``auditwheel``, and are therefore have limited comparability.  See the last section for build notes. 

These wheels are used within the [PyVista documentation build](https://github.com/pyvista/pyvista/blob/main/azure-pipelines.yml) to avoid using ``xvfb``, which has been found to be unstable and has lower performance.

### Build Process for the Python 3.8/3.9 OSMesa Wheels

Build requirements (Ubuntu)
```
sudo apt-get install libosmesa6-dev cmake ninja-build libboost-all-dev
```

The `vtk-osmesa-*-cp3*-cp3*-linux_x86_64.whl` wheels follows the build procedures
defined in in [VTK GitLab CI](https://gitlab.kitware.com/vtk/vtk/-/tree/master/.gitlab/ci).

```
git clone https://github.com/Kitware/VTK.git
cd VTK
git checkout v9.1.0
mkdir build
cd build

PYBIN=/usr/bin/python3.8  # or 3.9
cmake -GNinja \
      -DCMAKE_BUILD_TYPE=Release \
      -DVTK_BUILD_TESTING=OFF \
      -DVTK_BUILD_DOCUMENTATION=OFF \
      -DVTK_BUILD_EXAMPLES=OFF \
      -DVTK_DATA_EXCLUDE_FROM_ALL:BOOL=ON \
      -DVTK_MODULE_ENABLE_VTK_PythonInterpreter:STRING=NO \
      -DVTK_BUILD_ALL_MODULES:BOOL=ON \
      -DVTK_ENABLE_REMOTE_MODULES:BOOL=OFF \
      -DVTK_ENABLE_OSPRAY:BOOL=OFF \
      -DVTK_ENABLE_VR_COLLABORATION:BOOL=OFF \
      -DVTK_GROUP_ENABLE_Qt:STRING=NO \
      -DVTK_DEBUG_LEAKS:BOOL=OFF \
      \
      -DModule_vtkAcceleratorsVTKm:BOOL=OFF \
      -DVTK_MODULE_ENABLE_VTK_CommonArchive:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_DomainsMicroscopy:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_FiltersOpenTURNS:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_FiltersReebGraph:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOADIOS2:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOFFMPEG:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOGDAL:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOLAS:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOMySQL:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOODBC:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOOpenVDB:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOPDAL:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_IOPostgreSQL:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_InfovisBoost:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_InfovisBoostGraphAlgorithms:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_RenderingFreeTypeFontConfig:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_RenderingOpenVR:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_RenderingRayTracing:STRING=NO \
      -DVTK_MODULE_ENABLE_VTK_fides:STRING=NO \
      \
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


### Auditwheel and ManyLinux Build Issues for OSMesa

Note that these wheels failed to be repaired correctly using ``auditwheel`` for Ubuntu 20.04 due to an issue linking ``libffi``, and therefore were not converted.

Wheels build using images from https://quay.io/organization/pypa did not work on Ubuntu 20.04 due to a [GLSL 1.50 not supported](https://discourse.vtk.org/t/error-glsl-1-50-is-not-supported/1444) bug.

---

### Python 3.10

Unlike OSMesa, the wheel build for Python 3.10 Linux x86_64 was surprisingly
straightforward using `quay.io/pypa/manylinux2014_x86_64`:

#### `build_wheel.sh`:
```
docker run \
       --rm -v `pwd`:/io \
       quay.io/pypa/manylinux2014_x86_64 \
       /io/build_wheel_manylinux.sh 3.10

```

#### `build_wheel_manylinux.sh`:

```
#!/bin/bash
set -e -x

cd io
rm -rf build
mkdir build
cd build

# install build dependencies
yum update -y
yum install mesa-libGL-devel cmake ninja-build -y

# build based on python version from args
PYTHON_VERSION="$1"
case $PYTHON_VERSION in
3.7)
  PYBIN="/opt/python/cp37-cp37m/bin"
  ;;
3.8)
  PYBIN="/opt/python/cp38-cp38/bin"
  ;;
3.9)
  PYBIN="/opt/python/cp39-cp39/bin"
  ;;
3.10)
  PYBIN="/opt/python/cp310-cp310/bin"
  ;;
esac

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
       -DPython3_EXECUTABLE=$PYBIN/python \
       ../

ninja

# build, don't install
echo "using Python'${PYBIN}'"
"${PYBIN}/python" setup.py bdist_wheel --dist-dir wheel

# create wheel in wheelhouse
"${PYBIN}/pip" install auditwheel
"${PYBIN}/python" -m auditwheel repair wheel/*.whl --plat manylinux2014_x86_64
chmod -R 777 wheelhouse
```
