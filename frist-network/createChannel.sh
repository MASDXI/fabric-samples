export ORDERER_DOMAIN=orderer.network.com
export ORDERER_PORT=7050
export ORDERER_ADDRESS=${ORDERER_DOMAIN}:${ORDERER_PORT}
export ORDERER_MSP_FILE=/etc/hyperledger/fabric/orderer/msp/tlscacerts/tlsca.network.com-cert.pem

export PEER_NAME=peer0.org1.network.com
export PEER_ADMIN_MSP_PATH=/etc/hyperledger/fabric/admin/msp
export FABRIC_PATH=/etc/hyperledger/fabric
export CONFIGTX_PATH=${FABRIC_PATH}/configtx
export CHANNEL_NAME=mychannel

export ENV="-e CORE_PEER_MSPCONFIGPATH=${PEER_ADMIN_MSP_PATH}"

# Org1 create channel
docker exec ${ENV} ${PEER_NAME} peer channel create -o ${ORDERER_ADDRESS} -c ${CHANNEL_NAME} -f ${CONFIGTX_PATH}/${CHANNEL_NAME}.tx --tls --cafile $ORDERER_MSP_FILE

# Org1 join peer to channel
docker exec ${ENV} ${PEER_NAME} peer channel join -b $CHANNEL_NAME.block

export PEER_NAME=peer0.org2.network.com

# Org2 Fetch config channel
docker exec ${ENV} ${PEER_NAME} peer channel fetch config -c $CHANNEL_NAME -o $ORDERER_ADDRESS --tls --cafile $ORDERER_MSP_FILE

# Org2 join peer to channel
docker exec ${ENV} ${PEER_NAME} peer channel join -b ${CHANNEL_NAME}_config.block
