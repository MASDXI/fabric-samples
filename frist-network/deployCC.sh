# env
export CC_VERSION=1
export CC_NAME=fabcar
export CC_RUNTIME_LANGUAGE=golang
export CC_SRC_PATH=../fabcar/go
# export FOO=BAR
# more...

echo "====== Package Chaincode ======"

export FABRIC_CFG_PATH=../config

presetup() {
    echo Vendoring Go dependencies ...
    pushd $CC_SRC_PATH
    GO111MODULE=on go mod vendor
    popd
    echo Finished vendoring Go dependencies
}

# preset up chaincode 
presetup

echo "clean ${CC_NAME} binaries"
sleep 2
rm -rf $CC_NAME.tar.gz

echo "generate ${CC_NAME} binaries"
    
../bin/peer lifecycle chaincode package ${CC_NAME}.tar.gz \
    --path ${CC_SRC_PATH} \
    --lang ${CC_RUNTIME_LANGUAGE} \
    --label ${CC_NAME}_${CC_VERSION}

# do something ...

echo "====== install Chaincode ======"

# do something ...

echo "====== approve Chaincode ======"

# do something ...

# TODO-List
# queryInstalled
# approveForMyOrg1
# checkCommitReadyness