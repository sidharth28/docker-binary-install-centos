docker image load -i ca_1.4.4.tar
echo "ca image loaded"

docker image load -i tools_1.4.4.tar
echo "tools image loaded"

docker image load -i ccenv_1.4.4.tar
echo "ccenv image loaded"

docker image load -i orderer_1.4.4.tar
echo "orderer image loaded"

docker image load -i peer_1.4.4.tar
echo "peer image loaded"

docker image load -i couch_1.4.4.tar
echo "couch image loaded"

docker image load -i baseimage_1.4.4.tar
echo "baseimage image loaded"

docker image load -i baseos_1.4.4.tar
echo "baseos image loaded"
