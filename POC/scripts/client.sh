#!/bin/bash

#this script creates client certificates and rsa keys
set -e


if [ $# -ne 1 ];then
  echo "./client.sh <client_name>"
fi

PASS_FILE="mypass.enc"
EXPIRE_DAYS=1460
CA_KEY="cakey.pem"
CA_CERT="cacert.pem"
DC_1="fr"
DC_2="esiee"
OU="GROUP_TAVE"
CN_AC="AC"
mkdir -p certs private

echo "Generating $1 certificate.."
openssl genrsa -out private/"$1.key" #generate private key
openssl req -new -key private/"$1.key" -out "$1.csr" -subj "/DC=$DC_1/DC=$DC_2/OU=$OU/CN=$1" #generate certificate signing request
openssl  x509 -req -in "$1.csr" -CA certs/$CA_CERT -CAkey private/$CA_KEY  -passin file:$PASS_FILE \
-CAcreateserial -out private/"$1.pem" -days 1460 -sha256 #Sign certificate by CA
