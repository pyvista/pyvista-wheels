FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
ARG VTK_VERSION=v9.0.1

COPY . /opt/build-context/
WORKDIR /opt/build-context/

RUN /opt/build-context/apt.sh
RUN /opt/build-context/download_vtk.sh

WORKDIR /opt/build-context/VTK/build
RUN /opt/build-context/configure_vtk_osmesa.sh
RUN ninja
