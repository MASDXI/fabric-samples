export IMAGE_TAG=latest

docker-compose -f ./docker/docker-compose-test-net.yaml up -d

docker ps -a