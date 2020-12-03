set -x

docker stop $(docker ps -aq)

docker rm $(docker ps -aq)

res=$?
set +x