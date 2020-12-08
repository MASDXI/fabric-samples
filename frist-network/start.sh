export IMAGE_TAG=latest
export COMPOSE_PROJECT_NAME=net

docker-compose -f ./docker/docker-compose-test-net.yaml up -d

# fetch docker process
docker ps -a