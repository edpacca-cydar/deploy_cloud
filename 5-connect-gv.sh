#!/bin/bash

source .colours

if [ -z $VAULT_API_HOST ];
then
    echo -e " 💥 ${BRed}Something went wrong - can't find the vault api host env var ${Color_Off} 💥"
    echo "exiting..."
    exit 1
elif [ -z $GUICLOUD_API_HOST ];
then
    echo -e " 💥 ${BRed}Something went wrong - can't find the guicloud api host env var ${Color_Off} 💥"
    echo "exiting..."
    exit 1
fi

echo -e "${BGreen}----------------------------------------------------------"
echo -e 🏗 " connecting vault and guicloud with following urls:" 
echo -e ✨ "vault:" ${BICyan}$VAULT_API_HOST ✨
echo -e ✨ "${BGreen}session manager:" ${BICyan}$GUICLOUD_API_HOST ✨
echo -e ⚡ "${BIYellow}\033[5m PREPARE TO SPAM ENTER ${Color_Off} ⚡"
echo -e "${BGreen}-----------------------------------------------------------${Color_Off}"

aws-vault exec -n $AWSV_PROFILE -- \
    ansible-playbook aws-guicloud-vault-mutual-connect.yml \
    -e manifest=$AMI_MANIFEST \
    -e release=$RELEASE_TAG \
    -e shared_cloud_region=$CLOUD_REGION \
    -e shared_cloud_purpose=$CLOUD_PURPOSE \
    -e shared_cloud_user=$CLOUD_USER \
    -e shared_release=$RELEASE_TAG \
    -e vault_cloud_user=$CLOUD_USER \
    -e vault_api_host=$VAULT_API_HOST \
    -e guicloud_release=$RELEASE_TAG \
    -e guicloud_host=$GUICLOUD_API_HOST \
    -e valid_certs=true
