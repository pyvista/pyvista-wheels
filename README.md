## PyVista VTK Wheels

The `vtk-osmesa-*-cp38-cp38-linux_x86_64.whl` wheels were using the following:

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

Build requirements (Ubuntu)
```
sudo apt-get install libosmesa6-dev cmake ninja-build
```
