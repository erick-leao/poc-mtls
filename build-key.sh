#!/bin/bash

COMMAND=${1}
PATH_SSL=ssl
PATH_CA=${PATH_SSL}/ca_certs
PATH_SERVER=${PATH_SSL}/server_certs
PATH_CLIENT=${PATH_SSL}/client_certs
CA_PASSWORD=112233

if [ "${COMMAND}" == "init" ]; then
    mkdir -p ${PATH_CERTS} ${PATH_PRIVATE} ${PATH_SERVER} ${PATH_CLIENT} ${PATH_CA}
    echo "Paths created"
fi

#Autoridade de Certificação
if [ "${COMMAND}" == "ca" ]; then
    #generate key
    openssl genrsa -des3 -passout pass:${CA_PASSWORD} -out ${PATH_CA}/ca.key 4096
    #generate certificate sign
    openssl req -new -x509 -days 365 -passin pass:${CA_PASSWORD} -key ${PATH_CA}/ca.key -out ${PATH_CA}/ca.crt
fi

if [ "${COMMAND}" == "server" ]; then
    #generate key
    openssl req -new -nodes -out ${PATH_SERVER}/server.csr -keyout ${PATH_SERVER}/server.key -days 365
    #generate certificate sign
    openssl x509 -req -days 365 -passin pass:${CA_PASSWORD} -in ${PATH_SERVER}/server.csr -CA ${PATH_CA}/ca.crt -CAkey ${PATH_CA}/ca.key -set_serial 01 -out ${PATH_SERVER}/server.crt  
fi

if [ "${COMMAND}" == "client" ]; then
    #generate key
    openssl req -new -nodes -out ${PATH_CLIENT}/client.csr -keyout ${PATH_CLIENT}/client.key -days 365
    #generate certificate sign
    openssl x509 -req -days 365 -passin pass:${CA_PASSWORD} -in ${PATH_CLIENT}/client.csr -CA ${PATH_CA}/ca.crt -CAkey ${PATH_CA}/ca.key -set_serial 01 -out ${PATH_CLIENT}/client.crt  
fi
