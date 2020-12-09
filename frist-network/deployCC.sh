# env
export CC_VERSION=1
export CC_NAME=fabcar
export CC_RUNTIME_LANGUAGE=golang
export CC_SRC_PATH=../fabcar/go
# export FOO=BAR
# more...

echo "====== Package Chaincode ======"

# export FABRIC_CFG_PATH=../config

pre-setup-chaincode() {
    echo Vendoring Go dependencies ...
    pushd $CC_SRC_PATH
    GO111MODULE=on go mod vendor
    popd
    echo Finished vendoring Go dependencies
}

# # preset up chaincode 
pre-setup-chaincode

echo "clean ${CC_NAME} binaries"
sleep 2
rm -rf $CC_NAME.tar.gz

echo "generate ${CC_NAME} binaries"

# no sure right now using docker or export env 
../bin/peer lifecycle chaincode package ${CC_NAME}.tar.gz \
    --path ${CC_SRC_PATH} \
    --lang ${CC_RUNTIME_LANGUAGE} \
    --label ${CC_NAME}_${CC_VERSION}

# do something ...

echo "====== install Chaincode ======"

install-chaincode-peer0-org2() {
    echo "[peer0.org2.network.com] Installing..."

    export PEER_CONTAINER_NAME=peer0.org1.network.com

    docker exec ${PEER_CONTAINER_NAME} peer lifecycle chaincode install ${CC_NAME}.tar.gz

    # do something ...
}

install-chaincode-peer0-org2() {
    echo "[peer0.org2.network.com] Installing..."
    
    export PEER_CONTAINER_NAME=peer0.org2.network.com

    docker exec ${PEER_CONTAINER_NAME} peer lifecycle chaincode install ${CC_NAME}.tar.gz

    # do something ...
}

install-chaincode-peer0-org1
install-chaincode-peer0-org2

echo "====== approve Chaincode ======"

# do something ...

# TODO-List
# queryInstalled
# approveForMyOrg1
# checkCommitReadyness