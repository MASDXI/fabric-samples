# stop Hyperledger Fabric network container
docker stop $(docker ps -aq)

# clean Hyperledger Fabric network container
docker rm $(docker ps -aq)

docker network prune -f

docker volume prune -f