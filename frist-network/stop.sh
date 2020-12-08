# stop Hyperledger Fabric network container
docker stop $(docker ps -aq)

# clean Hyperledger Fabric network container
docker rm $(docker ps -aq)