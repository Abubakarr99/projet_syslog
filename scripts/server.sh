#!/bin/bash

#this script creates a certificate authority with a self-signed certificate
set -e
PASS_FILE="mypass.enc"
EXPIRE_DAYS=1460
CA_KEY="cakey.pem"
CA_CERT="cacert.pem"
DC_1="fr"
DC_2="esiee"
OU="GROUP_TAVE"
CN_AC="AC"
mkdir -p certs private
echo password > $PASS_FILE #fichier mdp

echo "generating CA cert.."
openssl genrsa -des3 -passout file:$PASS_FILE -out private/$CA_KEY 2048
openssl req -new -x509 -days 1460 -passin file:$PASS_FILE   -key private/$CA_KEY -out certs/$CA_CERT -subj "/DC=$DC_1/DC=$DC_2/OU=$OU/CN=$CN_AC/emailAddress=admin.esiee.fr"

