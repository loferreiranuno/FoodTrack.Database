export POSTGRES_PASSWORD="admin"
export POSTGRES_USER="admin"
export DATA="./data/" 
export BUILD_NUMBER=$RANDOM
export IMAGE=foodtrackgrpc
export IMAGE_BASE_NAME=foodtrackgrpc

docker network create web

docker build . \
    --file pipelines/Build.Dockerfile \
    --tag $IMAGE_BASE_NAME-base:$BUILD_NUMBER

docker build . \
    --file pipelines/Publish.Dockerfile \
    --tag $IMAGE \
    --build-arg BUILD_NUMBER=$BUILD_NUMBER \
    --build-arg BASE=$IMAGE_BASE_NAME-base:$BUILD_NUMBER

docker push $IMAGE

# pushd pipelines
cd pipelines

docker-compose \
    --project-name foodtrack-database \
    up \
    --detach \
    --remove-orphans

read varname