# Build OSMesa or EGL Wheels

The docker build and scripts in this directly make it possible to target any recent version of VTK and Python (on linux) to create OSMesa and EGL wheels.

## Docker build script

Edit `make_wheel.sh` to specify the VTK and Python versions you desire, then run:

```
./make_wheel.sh
```

After this completes, it should dump the built wheel in your current directory.


## Building natively

The included `.cmake` files here make it fairly easy to reproduce this build on your system (linux, Mac, and maybe even Windows).

To create an OSMesa wheel:

```
VTK_VERSION="9.2.2"
BUILD_VARIANT="osmesa"

./download_vtk.sh

mkdir VTK-${VTK_VERSION}/build
cd VTK-${VTK_VERSION}/build
cmake -GNinja \
    -C configure_${BUILD_VARIANT}.cmake \
    ..
ninja

# Edit the setup.py file to support variant in version
# https://gitlab.kitware.com/vtk/vtk/-/merge_requests/9674
python hack_version.py
```
