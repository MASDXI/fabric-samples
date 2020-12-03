export IMAGE_TAG=latest

set -x

docker-compose -f ./docker/docker-compose-test-net.yaml up -d

docker ps -a

res=$?
set +x