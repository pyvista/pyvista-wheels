ARG PYTHON_VERSION=3.9
FROM python:$PYTHON_VERSION
ARG DEBIAN_FRONTEND=noninteractive

# Install apt dependencies
WORKDIR /opt/workdir
COPY packages.apt /opt/workdir/
RUN apt-get update && \
    xargs apt-get install --no-install-recommends --yes <packages.apt && \
    rm -rf /var/lib/apt/lists/*

ARG VTK_VERSION=9.2.2
ARG BUILD_VARIANT=osmesa
# https://gitlab.kitware.com/vtk/vtk/-/merge_requests/9674
ENV VTK_BUILD_VARIANT_SUFFIX=$BUILD_VARIANT

# Download VTK
RUN echo ${VTK_VERSION}
COPY download_vtk.sh ./
RUN ./download_vtk.sh

# Build requested variant from configs
RUN mkdir /opt/workdir/VTK-${VTK_VERSION}/build
WORKDIR /opt/workdir/VTK-${VTK_VERSION}/build
COPY *.cmake /opt/workdir/VTK-${VTK_VERSION}/build/
RUN cmake -GNinja \
    -C configure_${BUILD_VARIANT}.cmake \
    ..
RUN ninja

# Edit the setup.py file to support variant in version
# https://gitlab.kitware.com/vtk/vtk/-/merge_requests/9674
COPY hack_version.py ./
RUN python hack_version.py

# Make Python wheel
RUN python -m pip install wheel
RUN python setup.py bdist_wheel

# Move wheel to /opt/wheels/
RUN mkdir /opt/wheels/ && cp /opt/workdir/VTK-${VTK_VERSION}/build/dist/*.whl /opt/wheels/

# Test/verify the wheel
WORKDIR /opt/
RUN python -m pip install /opt/wheels/*.whl
# Test
RUN python -c "import vtk;vtk.vtkRenderer()"
RUN python -m pip install pyvista
RUN python -c "import pyvista;print(pyvista.Report())"
# Make sure off screen by default
RUN python -c "import pyvista;pyvista.Cone().plot(show_edges=True)"

# Repair wheel to include OSMesa libs
# RUN python -m pip install auditwheel
# RUN auditwheel show /opt/wheels/*.whl
# RUN auditwheel repair --plat linux_x86_64 /opt/wheels/*.whl


ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
