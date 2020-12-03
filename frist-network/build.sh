export FABRIC_CFG_PATH=$PWD

set -x

rm -rf configtx
mkdir configtx
rm -rf crypto-config
../bin/cryptogen generate --config=./crypto-config.yaml

#====================== Orderer Msp ===================================//
../bin/configtxgen -printOrg OrdererMSP > configtx/OrdererMSP.json

#====================== Org Msp ===================================//
../bin/configtxgen -printOrg Org1MSP > configtx/Org1MSP.json
../bin/configtxgen -printOrg Org2MSP > configtx/Org2MSP.json

#====================== Block Config ===================================//
../bin/configtxgen -profile TwoOrgsOrdererGenesis -outputBlock ./configtx/genesis.block -channelID mychannel

# #====================== Channel Config ===================================//
../bin/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ./configtx/mychannel.tx -channelID mychannel
../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./configtx/mychannel-Org1MSP.tx -channelID mychannel -asOrg Org1MSP
../bin/configtxgen -profile TwoOrgsChannel -outputAnchorPeersUpdate ./configtx/mychannel-Org2MSP.tx -channelID mychannel -asOrg Org2MSP

res=$?
set +x