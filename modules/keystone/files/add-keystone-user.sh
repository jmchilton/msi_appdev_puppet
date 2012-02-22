#!/bin/bash
set -e

USER=$1
PASSWORD=$2
TENANT=$3

[[ -z ${TENANT} ]] && { echo "user password tenant"; exit 1 ;}

keystone-manage tenant list | grep -q ${TENANT} || keystone-manage tenant add ${TENANT}
keystone-manage user add ${USER} ${PASSWORD} ${TENANT}
