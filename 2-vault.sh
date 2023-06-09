#!/bin/bash

source .colours

if [ -z $PREOP_MANIFEST ];
then
    echo -e " 💥 ${BRed}Something went wrong - can't find the preop manifest env var ${Color_Off} 💥"
    echo "exiting..."
    exit 1
fi

echo -e "${BGreen}----------------------------------------------------------"
echo -e 🏗 " deploying the vault using the following preop manifest:" 
echo -e ✨ ${BICyan}$PREOP_MANIFEST ✨
echo -e "${BGreen}-----------------------------------------------------------${Color_Off}"

aws-vault exec -n $AWSV_PROFILE -- \
    ansible-playbook aws-vault-staging.yml \
    -e manifest=$AMI_MANIFEST \
    -e device_identifier=$DEVICE_IDENTIFIER \
    -e cloud_region=$CLOUD_REGION \
    -e cloud_user=$CLOUD_USER \
    -e cloud_purpose=$CLOUD_PURPOSE \
    -e preop_manifest=$PREOP_MANIFEST \
    -e valid_certs=truecydar_account_id

