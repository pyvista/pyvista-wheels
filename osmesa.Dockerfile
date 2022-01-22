FROM ubuntu:18.04

COPY . /opt/build-context/
WORKDIR /opt/build-context/

RUN /opt/build-context//apt.sh
RUN /opt/build-context//download_vtk.sh

WORKDIR VTK/build
RUN /opt/build-context/configure_vtk_osmesa.sh

RUN cd VTK/build && ninja

RUN tar -zcvf vtk-osmesa-build.tar.gz VTK/build/

WORKDIR /opt/build-context/
