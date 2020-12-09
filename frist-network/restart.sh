echo "################################################################################################################################################################"
# stop container
./stop.sh

echo "################################################################################################################################################################"
# generate crypto-material
./build.sh

echo "################################################################################################################################################################"
# start container
./start.sh


sleep 10
# create Instant mychannel 
# !remember if channel work correctly
echo "################################################################################################################################################################"
./createChannel.sh

# deploy sample fabcar chaincode
# !remember enable if deploy chaincode work correctly
#./deployCC