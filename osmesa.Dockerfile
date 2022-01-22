FROM ubuntu:18.04

COPY . /opt/build-context/
WORKDIR /opt/build-context/

RUN ./apt.sh
RUN ./download_vtk.sh

RUN ./configure_vtk_osmesa.sh

RUN cd VTK/build && ninja

RUN tar -zcvf vtk-osmesa-build.tar.gz VTK/build/
