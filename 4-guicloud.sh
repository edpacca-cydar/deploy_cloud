#!/bin/bash

source .colours

echo -e "${BGreen}----------------------------------------------------------"
echo -e 🏗 " deploying gui-cloud"
echo -e "${BGreen}----------------------------------------------------------${Color_Off}"

aws-vault exec -n $AWSV_PROFILE -- \
    ansible-playbook aws-guicloud-staging.yml \
    -e manifest=$AMI_MANIFEST \
    -e device_identifier=$DEVICE_IDENTIFIER \
    -e cloud_region=$CLOUD_REGION \
    -e cloud_user=$CLOUD_USER \
    -e cloud_purpose=$CLOUD_PURPOSE \
    -e valid_certs=true
