#!/usr/bin/env bash
set -eu
set -o pipefail
###################
SERVER="https://chainz.cryptoid.info/uno/api.dws?q=nodes"
DATADIR="/home/uno/.unobtanium"
###################
echo "UNO config file generator."

cat >unobtanium.conf <<EOF
#unobtanium.conf
rpcuser=unobtanium-rpc
rpcpassword=$(dd if=/dev/urandom bs=33 count=1 2>/dev/null | base64)

myip=127.0.0.1
server=1
listen=1
daemon=1
txindex=1

$(curl -sSL ${SERVER} | grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | sed '/^0/d' | sed -e "s/^/addnode=/g")
EOF

echo "Setting permissions ...."
chmod 0600 unobtanium.conf
echo "Installing config ...."
mkdir -p ${DATADIR} &&\
mv unobtanium.conf ${DATADIR}

echo -e "[\033[32mdone!\033[0m]"
echo "Your config file is located at ${DATADIR}/unobtanium.conf"



