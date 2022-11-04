PYTHON_VERSION="3.9"
VTK_VERSION="9.2.2"
BUILD_VARIANT="egl"

IMAGE_NAME="vtkbuild-$BUILD_VARIANT"

docker build \
    -t $IMAGE_NAME \
    --build-arg PYTHON_VERSION=$PYTHON_VERSION \
    --build-arg VTK_VERSION=$VTK_VERSION \
    --build-arg BUILD_VARIANT=$BUILD_VARIANT \
    .

# Extract the wheel
docker run -v $PWD:/opt/build-dir --rm $IMAGE_NAME "cp /opt/wheels/*.whl /opt/build-dir"
